//
//  LoginSceneViewController.swift
//  RegisterApp
//
//  Created by Curitiba01 on 15/09/21.
//

import UIKit

protocol LoginSceneViewControllerInput: AnyObject {
    func shouldEnableLoginButton(_ isEnabled: Bool)
    func showLoginError(errorMessage: String)
    func showLoginSucceed()
}

protocol LoginSceneViewControllerOutput {
    func login(email: String, pass: String)
    func validateFields(email: String, pass: String)
}

class LoginSceneViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Variables
    var interactor: LoginSceneViewControllerOutput?
    var router: LoginSceneRoutingLogic?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - IBActions
    @IBAction func login() {
        guard let email = emailTextField.text,
              let pass = passwordTextField.text
        else { return }
        
        interactor?.login(email: email, pass: pass)
    }
    
    @IBAction func editingChanged() {
        guard let email = emailTextField.text,
              let pass = passwordTextField.text
        else { return }
        
        interactor?.validateFields(email: email, pass: pass)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        loginButton.isEnabled = false
    }
}

// MARK: - View Controller Input
extension LoginSceneViewController: LoginSceneViewControllerInput {
    func showLoginSucceed() {
        router?.showLoginSucceed()
    }
    
    func showLoginError(errorMessage: String) {
        router?.showLoginError(errorDescription: errorMessage)
    }
    
    func shouldEnableLoginButton(_ isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
    }
}
