//
//  ExpenseTableViewCell.swift
//  EVIOS4
//
//  Created by Quentin Bona on 10/10/2022.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
    
    static let identifier = "ExpenseTableViewCell"

    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var valueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(expense: Entity){
        
        valueLabel.text = expense.value.description
        nameLabel.text = expense.name
        
    }
    
}
