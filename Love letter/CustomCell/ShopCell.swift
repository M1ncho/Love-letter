//
//  ShopCell.swift
//  Love letter
//
//  Created by KJW on 2022/07/11.
//

import UIKit

class ShopCell: UITableViewCell {

    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var lbProduct: UILabel!
    @IBOutlet weak var btnBuy: UIButton!
    
    var buyAction: (() -> ())?
    
    
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
    
    
    @IBAction func clickBuy(_ sender: Any) {
        buyAction?()
    }
    
}
