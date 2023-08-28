//
//  AppDelegate.swift
//  ditech-test
//
//  Created by Andres Diaz  on 25/08/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")
        
        // Crea una instancia del UINavigationController y asigna el viewController como la vista raíz
        let navigationController = UINavigationController(rootViewController: viewController)
        
        // Configura la ventana principal de la aplicación y establece el navigationController como el controlador de vista raíz
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

