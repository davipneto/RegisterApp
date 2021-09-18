//
//  RegisterSceneModel.swift
//  RegisterApp
//
//  Created by Curitiba01 on 17/09/21.
//

import SwiftyJSON

struct RegisterResponse {
    var id: Int
    var token: String
    
    init(json: JSON) {
        id = json["id"].intValue
        token = json["token"].stringValue
    }
}
