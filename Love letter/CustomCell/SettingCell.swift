//
//  SettingCell.swift
//  Love letter
//
//  Created by KJW on 2022/07/19.
//

import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var lbProduct: UILabel!
    @IBOutlet weak var btnUse: UIButton!
    
    var useAction: (() -> ())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        ivProduct.image = nil
    }
    
    @IBAction func clickUse(_ sender: Any) {
        useAction?()
    }

}
