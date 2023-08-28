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
    var coinSelected: CoinData?
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
    
    func navigateToDetailView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let coinDetailViewController = storyboard.instantiateViewController(withIdentifier: "CoinDetailViewController") as! CoinDetailViewController
        coinDetailViewController.coinSelected = self.coinSelected
        self.navigationController?.pushViewController(coinDetailViewController, animated: true)
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
        let formattedPrice = GeneralHelper.formatCurrencyValue(coin.price)
        cell.priceLabel.text = formattedPrice
        
        if let icon = self.presenter.coinImages.first(where: { $0.id == coin.assetID }),
           let url = icon.url {
            ImageHelper.loadImage(from: url) { image in
                cell.coinImage.image = image
            }
        }
        
        var variation = self.presenter.getVariationHourAndDate(coin: coin)
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 3
        
        if variation.isNaN {
            variation = 0
        }
        
        if let formattedPercentage = formatter.string(from: NSNumber(value: variation)) {
            cell.variationLabel.text = formattedPercentage
            if variation == 0 {
                cell.variationLabel.textColor = .white
            } else if variation > 0 {
                cell.variationLabel.textColor = .green
            } else if variation < 0 {
                cell.variationLabel.textColor = .red
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coinSelected = self.presenter.coins[indexPath.row]
        
        if let icon = self.presenter.coinImages.first(where: { $0.id == coinSelected?.assetID }),
            let url = icon.url {
            ImageHelper.loadImage(from: url) { image in
                self.coinSelected?.image = image // Agregar la imagen al coinSelected
                self.navigateToDetailView()
            }
        }
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
    

