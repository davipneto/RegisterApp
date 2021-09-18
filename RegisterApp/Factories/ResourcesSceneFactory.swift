//
//  ResourcesSceneFactory.swift
//  RegisterApp
//
//  Created by Curitiba01 on 16/09/21.
//

import UIKit

protocol ResourcesSceneFactoryProtocol {
    var configurator: ResourcesSceneConfiguratorProtocol! { get set }
    func makeResourcesScene() -> UIViewController
}

class ResourcesSceneFactory: ResourcesSceneFactoryProtocol {
    var configurator: ResourcesSceneConfiguratorProtocol!
    
    func makeResourcesScene() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "resourcesViewController") as! ResourcesSceneViewController
        configurator.configured(vc)
        return vc
    }
}
