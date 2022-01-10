//
//  UIImageView+downloaded.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 10.01.2022.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping (UIImage?) -> Void) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                print("Image downloaded")
                completion(image)
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: link) else {
            return }
        downloaded(from: url, contentMode: mode, completion: completion)
    }
}
