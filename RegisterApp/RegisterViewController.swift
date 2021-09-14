//
//  RegisterViewController.swift
//  RegisterApp
//
//  Created by Curitiba01 on 14/09/21.
//

import UIKit

enum RegisterTextField: Int {
    case name = 0
    case email = 1
    case telefone = 2
    case address = 3
    case password = 4
}

class RegisterViewController: UIViewController {
    @IBOutlet var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
