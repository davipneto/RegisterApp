//
//  LoginMVVMViewController.swift
//  RegisterApp
//
//  Created by Curitiba01 on 18/09/21.
//

import UIKit
import RxSwift

class LoginMVVMViewController: UIViewController {
    // MARK: - Variables
    var viewModel = LoginViewModel()
    let disposeBag = DisposeBag()

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var stackViewCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }

    // MARK: - IBActions
    @IBAction func login() {
        guard let email = emailTextField.text,
              let pass = passwordTextField.text
        else { return }
        
        viewModel.login(email: email, pass: pass)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] token in
                self?.didLoginSucceed()
            } onError: { [weak self] error in
                self?.showAlert(title: "Erro", message: error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    @IBAction func editingChanged() {
        guard let email = emailTextField.text,
              let pass = passwordTextField.text
        else { return }
        
        viewModel.validateFields(email: email, pass: pass)
    }
    
    @IBAction func showRegisterScene(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "registerViewController")
        present(vc, animated: true, completion: nil)
    }

    private func bindUI() {
        viewModel.areFieldsValid.bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func didLoginSucceed() {
        let screenHeight = view.frame.height
        let stackViewHeight = stackView.frame.height
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseIn) {
            self.stackViewCenterConstraint.constant = (screenHeight + stackViewHeight) / 2
            self.logoImageView.alpha = 0
            self.registerButton.alpha = 0
            self.stackView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "resourcesViewController")
            self?.present(vc, animated: true, completion: nil)
        }
    }
}
