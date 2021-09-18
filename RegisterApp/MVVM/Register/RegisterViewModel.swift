//
//  RegisterViewModel.swift
//  RegisterApp
//
//  Created by Curitiba01 on 18/09/21.
//

import Foundation
import RxSwift

enum RegisterError: Error {
    case fieldsNotValid
}

class RegisterViewModel {
    private let dateFormatter = DateFormatter()
    
    init() {
        setupDateFormatter()
    }
    
    private func setupDateFormatter() {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
    }
    
    func validateFields(_ textFields: [UITextField]) -> Observable<RegisterResponse> {
        let validators = Validators(minimumSizeForPassword: 6, textFields: textFields)
        let isValid = validators.validateAllFields()
        if isValid {
            return ReqressAPI.shared.register(email: validators.getEmail(), password: validators.getPassword())
        } else {
            return Observable.error(RegisterError.fieldsNotValid)
        }
    }
    
    func formatDate(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
