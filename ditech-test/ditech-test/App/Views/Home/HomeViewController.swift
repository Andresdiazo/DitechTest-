//
//  ViewController.swift
//  ditech-test
//
//  Created by Andres Diaz  on 25/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var coinListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Button Gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = coinListButton.bounds
        gradientLayer.colors = [UIColor(named: "initialGradient")!.cgColor, UIColor(named: "endGradient")!.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = 10
        
        coinListButton.layer.insertSublayer(gradientLayer, at: 0)
        
        
        // MARK: Navigation
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    
    @IBAction func coinListButtonTapped(_ sender: UIButton) {
        navigateToCoinListView()
    }
    
    func navigateToCoinListView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let coinListViewController = storyboard.instantiateViewController(withIdentifier: "CoinListViewController") as? CoinListViewController {
            self.navigationController?.pushViewController(coinListViewController, animated: true)
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}


