//
//  CoinListPresenter.swift
//  ditech-test
//
//  Created by Andres Diaz  on 25/08/23.
//

import Foundation

protocol CoinListDelegate: NSObject {
    func getResults(results: [CoinData]?)
}

protocol CoinListPresenterProtocol {
    func searchItem()
    func setDelegate(delegate: CoinListDelegate)
}

class CoinListPresenter {
    weak var delegate: CoinListDelegate!
    let baseURL = "https://rest.coinapi.io/v1/"
    let params = ["apikey":"4DCD15DF-74B9-4C6D-ACA4-3EB048C57178"]
    func setDelegate(delegate: CoinListDelegate) {
        self.delegate = delegate
    }
}
/*
extension CoinListPresenter: CoinListPresenterProtocol {
    func searchItem() {
        let networkService = NetworkService(baseURL: baseURL)
        networkService.fecthData(path: "assets", params: params) { (result: Result<CoinData, Error>) in
            switch result {
            case .success(let coinResult):
                if !coinResult.coins.isEmpty && self.delegate != nil {
                    self.delegate.getResults(results: coinResult.coins)
                } else {
                    
                }
            case .failure(_):
                print("Hubo un error en la busqueda")
            }
        }
    }
}
*/

extension CoinListPresenter: CoinListPresenterProtocol {
    func searchItem() {
        let networkService = NetworkService(baseURL: baseURL)
        networkService.fecthData(path: "assets", params: params) { (result: Result<[CoinData], Error>) in
            switch result {
            case .success(let coinResults):
                if !coinResults.isEmpty {
                    self.delegate?.getResults(results: coinResults)
                } else {
                    self.delegate?.getResults(results: nil)
                }
            case .failure(let error):
                print("Hubo un error en la búsqueda: \(error)")
            }
        }
    }
}
