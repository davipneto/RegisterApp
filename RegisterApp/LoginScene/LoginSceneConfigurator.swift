//
//  LoginSceneConfigurator.swift
//  RegisterApp
//
//  Created by Curitiba01 on 15/09/21.
//

import Foundation

protocol LoginSceneConfiguratorProtocol {
    func configured(_ vc: LoginSceneViewController)
}

class LoginSceneConfigurator: LoginSceneConfiguratorProtocol {
    var sceneFactory: LoginSceneFactoryProtocol
    
    init(sceneFactory: LoginSceneFactoryProtocol) {
        self.sceneFactory = sceneFactory
    }
    
    func configured(_ vc: LoginSceneViewController) {
        sceneFactory.configurator = self
        
        let interactor = LoginSceneInteractor()
        let presenter = LoginScenePresenter()
        let router = LoginSceneRouter()
        
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.viewController = vc
        router.source = vc
    }
}
