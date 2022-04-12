//  SuggestionCell.swift
//  DwitBook

import UIKit

class SuggestionCell: UITableViewCell {

    @IBOutlet weak var suggestionLabel: UILabel!
    
    func bind(text: String) {
        self.suggestionLabel.text = text
    }
    
}
