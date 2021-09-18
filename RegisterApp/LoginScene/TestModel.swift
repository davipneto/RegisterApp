//
//  TestModel.swift
//  RegisterApp
//
//  Created by Curitiba01 on 18/09/21.
//

import Foundation

@objc(SwiftModel)
class SwiftModel: NSObject {
    @objc var name: NSString = ""
    
    @objc init(name: NSString) {
        self.name = name
    }
    
    @objc func printName() {
        print("\n name: \(name)")
    }
}
