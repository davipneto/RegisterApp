//
//  RegisterSceneConfigurator.swift
//  RegisterApp
//
//  Created by Curitiba01 on 16/09/21.
//

import Foundation

protocol RegisterSceneConfiguratorProtocol {
    func configured(_ vc: RegisterSceneViewController)
}

class RegisterSceneConfigurator: RegisterSceneConfiguratorProtocol {
    var sceneFactory: RegisterSceneFactoryProtocol

    init(sceneFactory: RegisterSceneFactoryProtocol) {
        self.sceneFactory = sceneFactory
    }

    func configured(_ vc: RegisterSceneViewController) {
        sceneFactory.configurator = self
        
        let interactor = RegisterSceneInteractor()
        let presenter = RegisterScenePresenter()
        let router = RegisterSceneRouter()
        
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.viewController = vc
        router.source = vc
    }
}
