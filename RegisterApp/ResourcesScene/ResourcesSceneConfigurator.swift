//
//  ResourcesSceneConfigurator.swift
//  RegisterApp
//
//  Created by Curitiba01 on 16/09/21.
//

import Foundation

protocol ResourcesSceneConfiguratorProtocol {
    func configured(_ vc: ResourcesSceneViewController)
}

class ResourcesSceneConfigurator: ResourcesSceneConfiguratorProtocol {
    var sceneFactory: ResourcesSceneFactoryProtocol
    
    init(sceneFactory: ResourcesSceneFactoryProtocol) {
        self.sceneFactory = sceneFactory
    }
    
    func configured(_ vc: ResourcesSceneViewController) {
        sceneFactory.configurator = self
        
        let interactor = ResourcesSceneInteractor()
        let presenter = ResourcesScenePresenter()
        let router = ResourcesSceneRouter()
        
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.viewController = vc
        router.source = vc
    }
}
