//
//  LoginScenePresenter.swift
//  RegisterApp
//
//  Created by Curitiba01 on 15/09/21.
//

import Foundation

typealias LoginScenePresenterInput = LoginSceneInteractorOutput
typealias LoginScenePresenterOutput = LoginSceneViewControllerInput

class LoginScenePresenter {
    weak var viewController: LoginScenePresenterOutput?
}

extension LoginScenePresenter: LoginScenePresenterInput {
    func showLoginSucceed() {
        viewController?.showLoginSucceed()
    }
    
    func showLoginError(errorDescription: String) {
        viewController?.showLoginError(errorMessage: errorDescription)
    }
    
    func didValidateFields(_ isValid: Bool) {
        viewController?.shouldEnableLoginButton(isValid)
    }
}
