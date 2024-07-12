//
//  LetterCell.swift
//  Love letter
//
//  Created by KJW on 2022/07/22.
//

import UIKit

class LetterCell: UITableViewCell {

    @IBOutlet weak var lbletter: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
