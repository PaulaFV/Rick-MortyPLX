//
//  ImageDonwloaderProtocol.swift
//  Ricky-Morty-PLX
//
//  Created by Paula Fernández Vázquez on 30/5/25.
//

import Foundation
import Combine
import UIKit

protocol ImageDownloaderProtocol {
    func downloadImage(from url: String) -> AnyPublisher<UIImage?, Never>
}

class ImageDownloader: ImageDownloaderProtocol {
    func downloadImage(from url: String) -> AnyPublisher<UIImage?, Never> {
        guard let url = URL(string: url) else {
            return Just(nil).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response -> UIImage? in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200,
                      let mimeType = httpResponse.mimeType,
                      mimeType.hasPrefix("image") else {
                    return nil
                }
                return UIImage(data: data)
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
