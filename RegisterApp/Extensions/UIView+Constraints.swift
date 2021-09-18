//
//  UIView+Constraints.swift
//  RegisterApp
//
//  Created by Curitiba01 on 18/09/21.
//

import UIKit

extension UIView {
    func prepareForConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func fillSuperview(constant: CGFloat = 0) {
        guard let superview = superview else { return }
        prepareForConstraints()
        
        topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).activateConstraint()
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).activateConstraint()
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant).activateConstraint()
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant).activateConstraint()
    }
    
    func centerOnSuperview() {
        guard let superview = superview else { return }
        prepareForConstraints()
        
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).activateConstraint()
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).activateConstraint()
    }
    
    func defineSize(width: CGFloat?, height: CGFloat?) {
        prepareForConstraints()
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).activateConstraint()
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).activateConstraint()
        }
    }
}

extension NSLayoutConstraint {
    func activateConstraint() {
        isActive = true
    }
}
