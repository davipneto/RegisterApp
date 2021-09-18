//
//  LoginViewModel.swift
//  RegisterApp
//
//  Created by Curitiba01 on 18/09/21.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    var areFieldsValid: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func login(email: String, pass: String) -> Observable<String> {
        return ReqressAPI.shared.login(email: email, password: pass)
            .map { token in
                self.saveToken(email: email, token: token)
                return token
            }
    }
    
    func validateFields(email: String, pass: String) {
        let isEmailValid = EmailValidator.shared.validateEmail(email)
        let isPassValid = PasswordValidator.shared.validatePassword(pass)
        
        areFieldsValid.accept(isEmailValid && isPassValid)
    }
    
    private func saveToken(email: String, token: String) {
        guard let data = token.data(using: .utf8)
              else { return }
        do {
            try KeychainHelper.addItem(server: ReqressAPI.server, account: email, data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}
    
    
    
//    private func handleError(_ error: Error) {
//        if let loginError = error as? LoginError {
//            var errorMessage: String = ""
//            switch loginError {
//            case .invalidData:
//                errorMessage = "Dados de retorno inválidos"
//            case .other(let message):
//                errorMessage = message
//            }
//            //showLoginError(errorDescription: errorMessage)
//        } else {
//            //showLoginError(errorDescription: error.localizedDescription)
//        }
//    }
