//
//  RegisterMVVMViewController.swift
//  RegisterApp
//
//  Created by Curitiba01 on 18/09/21.
//

import UIKit
import RxSwift

class RegisterMVVMViewController: UIViewController {
    // MARK: - Variables
    let viewModel = RegisterViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - IBOutlets
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var dateTextField: UITextField!
    
    // MARK: - Views
    let datePickerView = UIDatePicker()
    
    // MARK: - Life Cycke
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
    }
    
    // MARK: - IBActions
    @IBAction func register() {
        viewModel.validateFields(textFields)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] _ in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "resourcesViewController")
                self?.present(vc, animated: true, completion: nil)
            } onError: { [weak self] error in
                if let registerError = error as? RegisterError {
                    if registerError == .fieldsNotValid {
                        self?.showAlert(title: "Erro", message: "Preencha os campos corretamente")
                    }
                } else {
                    self?.showAlert(title: "Erro", message: error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)

    }
    
    // MARK: - Private Methods
    private func setupDatePicker() {
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.addTarget(self, action: #selector(self.insertDateOnTextField), for: .valueChanged)
        dateTextField.inputView = datePickerView
    }
    
    @objc private func insertDateOnTextField() {
        self.dateTextField.text = viewModel.formatDate(date: datePickerView.date)
    }

}
