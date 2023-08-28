//
//  CoinListViewController.swift
//  ditech-test
//
//  Created by Andres Diaz  on 27/08/23.
//

import Foundation
import UIKit

class CoinListViewController: UIViewController {
    @IBOutlet weak var coinListTableView: UITableView!
    var presenter: CoinListPresenterProtocol = CoinListPresenter()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: TABLE view
        self.coinListTableView.delegate = self
        self.coinListTableView.dataSource = self
        let nib = UINib(nibName: "CoinCell", bundle: nil)
        coinListTableView.register(nib, forCellReuseIdentifier: "myCell")
        
        // MARK: Presenter
        activityIndicator.startAnimating()
        presenter.setDelegate(delegate: self)
        presenter.searchData()
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(okayAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension CoinListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? CoinCell else {
            fatalError("No se pudo obtener la celda personalizada.")
        }
        
        let coin = self.presenter.coins[indexPath.row]
        cell.assetLabel.text = coin.assetID
        cell.nameCoinLabel.text = coin.name
        let priceNumber = NSNumber(value: coin.volume1DayUSD ?? 0)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 0
        let formattedPrice = formatter.string(from: priceNumber)
        cell.priceLabel.text = formattedPrice
        
        if let icon = self.presenter.coinImages.first(where: { $0.id == coin.assetID }),
            let url = icon.url {
            ImageHelper.loadImage(from: url) { image in
                cell.coinImage.image = image
            }
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

}

extension CoinListViewController: CoinListDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.coinListTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func fail() {
        DispatchQueue.main.async {
            self.showAlert(message: "Ha ocurrido un error inesperado")
        }
    }
}
