//
//  Validators.swift
//  RegisterApp
//
//  Created by Curitiba01 on 14/09/21.
//

import UIKit

class Validators {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    var minimumSizeForPassword: Int
    var textFields: [RegisterTextField: UITextField] = [:]
    
    init(minimumSizeForPassword: Int, textFields: [UITextField]) {
        self.minimumSizeForPassword = minimumSizeForPassword
        for textField in textFields {
            if let registerTextField = RegisterTextField(rawValue: textField.tag) {
                self.textFields[registerTextField] = textField
            }
        }
    }
    
    func validateAllFields() -> Bool {
        return
            validateName(textFields[.name]!.text!) &&
            validateEmail(textFields[.email]!.text!) &&
            validatePhone(textFields[.telefone]!.text!) &&
            validatePassword(textFields[.password]!.text!)
    }
    
    func validateEmail(_ email: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
    
    func validatePassword(_ pass: String) -> Bool {
        return pass.count >= minimumSizeForPassword
    }
    
    func validatePhone(_ phone: String) -> Bool {
        return phone.count == 11
    }
    
    func validateAddress(_ address: String) -> Bool {
        return !address.isEmpty
    }
    
    func validateName(_ name: String) -> Bool {
        return !name.isEmpty
    }
}

class EmailValidator {
    static let shared = EmailValidator()
    
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    var predicate: NSPredicate
    
    private init() {
        predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    }

    func validateEmail(_ email: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
}

class PasswordValidator {
    static let shared = PasswordValidator()
    let minimumSizeForPassword = 6
    
    func validatePassword(_ password: String) -> Bool {
        return password.count >= minimumSizeForPassword
    }
}
