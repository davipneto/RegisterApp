//
//  ViewController.swift
//  RegisterApp
//
//  Created by Curitiba01 on 14/09/21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
    }

    @IBAction func login() {
        guard let email = emailTextField.text,
              let pass = passwordTextField.text
        else { return }
        
        ReqressAPI.shared.login(email: email, password: pass) { token, error in
            if let error = error {
                self.handleError(error)
            } else if let token = token {
                self.saveToken(token)
            }
        }
    }
    
    @IBAction func textDidChange(_ sender: Any) {
        guard let email = emailTextField.text,
              let pass = passwordTextField.text
        else { return }
        
        let isEmailValid = EmailValidator.shared.validateEmail(email)
        let isPassValid = PasswordValidator.shared.validatePassword(pass)
        
        loginButton.isEnabled = isEmailValid && isPassValid
    }
    
    private func saveToken(_ token: String) {
        guard let email = emailTextField.text,
              let data = token.data(using: .utf8)
              else { return }
        
        do {
            try KeychainHelper.addItem(server: ReqressAPI.server, account: email, data: data)
            print("Token Salvo com sucesso")
            let dataRetrieved = try KeychainHelper.retriveItem(server: ReqressAPI.server, account: email)
            if let retrievedToken = String(data: dataRetrieved, encoding: .utf8) {
                print("Token recuperado: " + retrievedToken)
            }
        } catch {
            if let keychainError = error as? KeychainError {
                switch keychainError {
                case .errorStatus(let status):
                    if status == errSecDuplicateItem {
                        print("Item duplicado: \(status.description)")
                    }
                case .invalidData:
                    print("Dados inválidos")
                }
            } else {
                print(error.localizedDescription)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        if let loginError = error as? LoginError {
            switch loginError {
            case .invalidData:
                print("Dados de retorno inválidos")
            case .other(let message):
                print(message)
            }
        } else {
            print(error.localizedDescription)
        }
    }
}

