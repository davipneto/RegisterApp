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
    func showRegisterScene()
}

class LoginSceneRouter: LoginSceneRoutingLogic {
    weak var source: UIViewController?
    
    func showLoginError(errorDescription: String) {
        source?.showAlert(title: "Erro", message: errorDescription)
    }
    
    func showLoginSucceed() {
        let resourcesFactory = ResourcesSceneFactory()
        resourcesFactory.configurator = ResourcesSceneConfigurator(sceneFactory: resourcesFactory)
        let vc = resourcesFactory.makeResourcesScene()
        source?.present(vc, animated: true, completion: nil)
    }
    
    func showRegisterScene() {
        let registerSceneFactory = RegisterSceneFactory()
        registerSceneFactory.configurator = RegisterSceneConfigurator(sceneFactory: registerSceneFactory)
        let registerViewController = registerSceneFactory.makeRegisterScene()
        source?.present(registerViewController, animated: true, completion: nil)
    }
}
