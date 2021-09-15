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
    case dateOfBirth = 5
}

class RegisterViewController: UIViewController {
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    
    lazy var validator: Validators = {
        return Validators(minimumSizeForPassword: 6, textFields: textFields)
    }()
    let datePickerView = UIDatePicker()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        setupDateFormatter()
    }
    
    private func setupDatePicker() {
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.addTarget(self, action: #selector(self.insertDateOnTextField), for: .valueChanged)
        dateOfBirthTextField.inputView = datePickerView
    }
    
    private func setupDateFormatter() {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        //dateFormatter.dateFormat = "dd/MM/yy"
    }
    
    @objc private func insertDateOnTextField() {
        let date = datePickerView.date
        let dateString = dateFormatter.string(from: date)
        dateOfBirthTextField.text = dateString
    }
    
    @IBAction func register() {
        let isValid = validator.validateAllFields()
        if !isValid {
            print("Verificar campos")
        }
    }
}

extension RegisterViewController: UIPickerViewDataSource,  UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nil
    }
}
