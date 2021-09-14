//
//  Validators.swift
//  RegisterApp
//
//  Created by Curitiba01 on 14/09/21.
//

import Foundation

class EmailValidator {
    static let shared = EmailValidator()
    
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    var predicate: NSPredicate
    
    private init() {
        predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    }
    
    func validateEmail(_ email: String) -> Bool {
        return predicate.evaluate(with: email)
    }
}

class PasswordValidator {
    static let shared = PasswordValidator()
    
    let minimumSize = 6
    
    func validatePassword(_ pass: String) -> Bool {
        return pass.count >= minimumSize
    }
}
