//
//  LoginSceneFactory.swift
//  RegisterApp
//
//  Created by Curitiba01 on 15/09/21.
//

import UIKit

protocol LoginSceneFactoryProtocol {
    var configurator: LoginSceneConfiguratorProtocol! { get set }
    func makeLoginScene() -> UIViewController
}

class LoginSceneFactory: LoginSceneFactoryProtocol {
    var configurator: LoginSceneConfiguratorProtocol!
    
    func makeLoginScene() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "loginViewController") as! LoginSceneViewController
        configurator.configured(vc)
        return vc
    }
}
