//
//  CoinCell.swift
//  ditech-test
//
//  Created by Andres Diaz  on 27/08/23.
//

import UIKit

class CoinCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    @IBOutlet weak var nameCoinLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
