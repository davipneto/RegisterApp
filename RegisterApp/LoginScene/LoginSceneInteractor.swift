//
//  LoginSceneInteractor.swift
//  RegisterApp
//
//  Created by Curitiba01 on 15/09/21.
//

import Foundation

typealias LoginSceneInteractorInput = LoginSceneViewControllerOutput
protocol LoginSceneInteractorOutput {
    func showLoginSucceed()
    func showLoginError(errorDescription: String)
    func didValidateFields(_ isValid: Bool)
}

class LoginSceneInteractor {
    var presenter: LoginSceneInteractorOutput?
    
    private func saveToken(email: String, token: String) {
        guard let data = token.data(using: .utf8)
              else { return }
        do {
            try KeychainHelper.addItem(server: ReqressAPI.server, account: email, data: data)
            presenter?.showLoginSucceed()
        } catch {
            if let keychainError = error as? KeychainError {
                var errorMessage: String = ""
                switch keychainError {
                case .errorStatus(let status):
                    if status == errSecDuplicateItem {
                        errorMessage = "Item duplicado: \(status.description)"
                    }
                case .invalidData:
                    errorMessage = "Dados inválidos"
                }
                presenter?.showLoginError(errorDescription: errorMessage)
            } else {
                presenter?.showLoginError(errorDescription: error.localizedDescription)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        if let loginError = error as? LoginError {
            var errorMessage: String = ""
            switch loginError {
            case .invalidData:
                errorMessage = "Dados de retorno inválidos"
            case .other(let message):
                errorMessage = message
            }
            presenter?.showLoginError(errorDescription: errorMessage)
        } else {
            presenter?.showLoginError(errorDescription: error.localizedDescription)
        }
    }
}

extension LoginSceneInteractor: LoginSceneInteractorInput {
    func login(email: String, pass: String) {
        ReqressAPI.shared.login(email: email, password: pass) { token, error in
            if let error = error {
                self.handleError(error)
            } else if let token = token {
                self.saveToken(email: email, token: token)
            }
        }
    }
    
    func validateFields(email: String, pass: String) {
        let isEmailValid = EmailValidator.shared.validateEmail(email)
        let isPassValid = PasswordValidator.shared.validatePassword(pass)
        presenter?.didValidateFields(isEmailValid && isPassValid)
    }
}
