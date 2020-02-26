//
//  ResultViewCell.swift
//  RateModules
//
//  Created by user164220 on 26/02/2020.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class ResultViewCell: UITableViewCell {
    
    let identifier = "ratingCell"
    @IBOutlet weak var showNameStudent: UILabel!
    @IBOutlet weak var showModuleStudent: UILabel!
    @IBOutlet weak var showRateStudent: UILabel!
    @IBOutlet weak var showEmojiStudent: UILabel!
    
    func configure(result: Result) {
        
        showNameStudent.text = "Name : " + result.name
        showModuleStudent.text = "Module : " + result.module
        showRateStudent.text = "Emoji : " + result.emoji
        showEmojiStudent.text = "Score : " + result.rate
    }
    
}
