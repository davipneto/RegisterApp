//
//  RegisterSceneFactory.swift
//  RegisterApp
//
//  Created by Curitiba01 on 16/09/21.
//

import UIKit

protocol RegisterSceneFactoryProtocol {
    var configurator: RegisterSceneConfiguratorProtocol! { get set }
    func makeRegisterScene() -> UIViewController
}

class RegisterSceneFactory: RegisterSceneFactoryProtocol {
    var configurator: RegisterSceneConfiguratorProtocol!
    
    func makeRegisterScene() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "registerViewController") as! RegisterSceneViewController
        configurator.configured(vc)
        return vc
    }
}
