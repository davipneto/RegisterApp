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
    @IBOutlet weak var stackViewCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Variables
    var interactor: LoginSceneViewControllerOutput?
    var router: LoginSceneRoutingLogic?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createObjCModel()
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
    
    @IBAction func showRegisterScene(_ sender: Any) {
        router?.showRegisterScene()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        loginButton.isEnabled = false
    }
    
    private func createObjCModel() {
        guard let model = ObjCModel(message: "Mensagem Teste") else { return }
        model.printMessage()
    }
}

// MARK: - View Controller Input
extension LoginSceneViewController: LoginSceneViewControllerInput {
    func showLoginSucceed() {
        let screenHeight = view.frame.height
        let stackViewHeight = stackView.frame.height
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseIn) {
            self.stackViewCenterConstraint.constant = (screenHeight + stackViewHeight) / 2
            self.logoImageView.alpha = 0
            self.registerButton.alpha = 0
            self.stackView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.router?.showLoginSucceed()
        }
    }
    
    func showLoginError(errorMessage: String) {
        router?.showLoginError(errorDescription: errorMessage)
    }
    
    func shouldEnableLoginButton(_ isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
    }
}
