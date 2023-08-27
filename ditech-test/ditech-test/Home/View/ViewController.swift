//
//  ViewController.swift
//  ditech-test
//
//  Created by Andres Diaz  on 25/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var coinListTableView: UITableView!
    @IBOutlet weak var coinListButton: UIButton!
    
    var array: [CoinData]?
    var presenter: CoinListPresenterProtocol = CoinListPresenter()
    override func viewDidLoad() {
        presenter.searchItem()
        presenter.setDelegate(delegate: self)
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension ViewController: CoinListDelegate {
    func getResults(results: [CoinData]?) {
        if let data = results {
            array = data
        }
        DispatchQueue.main.async {
//            self.searchTableView.delegate = self
//            self.searchTableView.dataSource = self
//            self.aIndicator.stopAnimating()
//            self.searchTableView.reloadData()
        }
    }
}

