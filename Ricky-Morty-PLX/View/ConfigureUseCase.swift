//
//  ConfigureUseCase.swift
//  Ricky-Morty-PLX
//
//  Created by Paula Fernández Vázquez on 27/5/25.
//

import Foundation
import UIKit

class ConfigureUseCase: ConfigureUseCaseProtocol {
    private let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func recieveImage(url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
}
