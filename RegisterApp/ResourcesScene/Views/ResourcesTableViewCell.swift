//
//  ResourcesTableViewCell.swift
//  RegisterApp
//
//  Created by Curitiba01 on 17/09/21.
//

import UIKit

class ResourcesTableViewCell: UITableViewCell {
    var resource: Resource? {
        didSet {
            setupCell()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var pantoneValueLabel: UILabel!

    func setupCell() {
        guard let resource = resource else { return }
        selectionStyle = .none
        nameLabel.text = resource.name
        yearLabel.text = String(resource.year)
        pantoneValueLabel.text = resource.pantoneValue
        
        if let color = resource.color {
            backgroundColor = color
        }
    }
}
