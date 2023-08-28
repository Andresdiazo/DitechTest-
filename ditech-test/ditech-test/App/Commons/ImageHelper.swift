//
//  ImageHelper.swift
//  ditech-test
//
//  Created by Andres Diaz  on 25/08/23.
//


import Foundation
import UIKit

class ImageHelper {
    static func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completion(nil)
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else {
                completion(nil)
                return
            }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
