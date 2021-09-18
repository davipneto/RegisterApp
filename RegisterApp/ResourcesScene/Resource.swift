//
//  Resource.swift
//  RegisterApp
//
//  Created by Curitiba01 on 17/09/21.
//

import UIKit
import SwiftyJSON

struct Resource {
    var id: Int
    var name: String
    var year: Int
    var color: UIColor?
    var pantoneValue: String
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        year = json["year"].intValue
        pantoneValue = json["pantone_value"].stringValue
        color = UIColor(rgbHexString: json["color"].stringValue)
    }
}
