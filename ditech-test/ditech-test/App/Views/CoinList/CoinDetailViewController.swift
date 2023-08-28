//
//  CoinDetailViewController.swift
//  ditech-test
//
//  Created by Andres Diaz  on 28/08/23.
//

import Foundation
import UIKit

class CoinDetailViewController:UIViewController {
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailAssetLabel: UILabel!
    @IBOutlet weak var detailLastHourLabel: UILabel!
    @IBOutlet weak var detailLastDayLabel: UILabel!
    @IBOutlet weak var detailLastMonthLabel: UILabel!
    var coinSelected: CoinData?
    var presenter: CoinListPresenterProtocol = CoinListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.detailAssetLabel.text = self.coinSelected?.assetID
        let formattedPrice1 = GeneralHelper.formatCurrencyValue(coinSelected?.volume1HrUSD)
        let formattedPrice2 = GeneralHelper.formatCurrencyValue(coinSelected?.volume1DayUSD)
        let formattedPrice3 = GeneralHelper.formatCurrencyValue(coinSelected?.volume1MonthUSD)
        self.detailLastHourLabel .text = formattedPrice1
        self.detailLastDayLabel.text = formattedPrice2
        self.detailLastMonthLabel.text = formattedPrice3
        
        if let image = coinSelected?.image {
                self.detailImageView.image = image
            }
    }
    
    
}
