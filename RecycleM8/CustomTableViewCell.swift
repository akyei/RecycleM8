//
//  CustomTableViewCell.swift
//  RecycleM8
//
//  Created by Alexander Kyei on 4/9/16.
//  Copyright © 2016 Alexander Kyei. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var labelGuess: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func loadItem(item: String) {
        
    }
}