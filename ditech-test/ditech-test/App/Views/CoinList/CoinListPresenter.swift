//
//  CoinListPresenter.swift
//  ditech-test
//
//  Created by Andres Diaz  on 25/08/23.
//

import Foundation

protocol CoinListDelegate: NSObject {
    func reloadData()
    func fail()
}

protocol CoinListPresenterProtocol {
    var coins: [CoinData] { get set }
    var coinImages: [CoinIcon] { get set }
    
    func setDelegate(delegate: CoinListDelegate)
    
    func searchData()
    func getVariationHourAndDate(coin: CoinData) -> Double
}

class CoinListPresenter {
    private weak var delegate: CoinListDelegate?
    private let networkService: NetworkServiceProtocol
    var coins: [CoinData] = []
    var coinImages: [CoinIcon] = []
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func setDelegate(delegate: CoinListDelegate) {
        self.delegate = delegate
    }
}

extension CoinListPresenter: CoinListPresenterProtocol {
    private func getCoinImages() {
        networkService.fecthData(htttpMethod: .get,
                                 path: "assets/icons/80",
                                 params: NetworkService.apikey) { [weak self] (result: Result<[CoinIcon], Error>) in
            switch result {
            case .success(let coinImages):
                self?.coinImages = coinImages
                self?.delegate?.reloadData()
            default:
                self?.delegate?.fail()
            }
        }
    }
    
    func searchData() {
        networkService.fecthData(htttpMethod: .get,
                                 path: "assets",
                                 params: NetworkService.apikey) { [weak self] (result: Result<[CoinData], Error>) in
            switch result {
            case .success(let coinResults):
                self?.coins = coinResults
                self?.getCoinImages()
                self?.delegate?.reloadData()
            default:
                self?.delegate?.fail()
            }
        }
    }
    
    func getVariationHourAndDate(coin: CoinData) -> Double {
        if let volume1DayUSD = coin.volume1DayUSD, let volume1MonthUSD = coin.volume1MonthUSD {
            return ((volume1DayUSD / volume1MonthUSD))     } else {
                return 0
            }
    }
}
