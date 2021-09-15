//
//  LoginSceneRouter.swift
//  RegisterApp
//
//  Created by Curitiba01 on 15/09/21.
//

import UIKit

protocol LoginSceneRoutingLogic {
    func showLoginError(errorDescription: String)
    func showLoginSucceed()
}

class LoginSceneRouter: LoginSceneRoutingLogic {
    weak var source: UIViewController?
    
    func showLoginError(errorDescription: String) {
        let alertController = UIAlertController(title: "Erro", message: errorDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        source?.present(alertController, animated: true, completion: nil)
    }
    
    func showLoginSucceed() {
        let alertController = UIAlertController(title: "Sucesso", message: "O Login foi realizado com sucesso", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        source?.present(alertController, animated: true, completion: nil)
    }
}
