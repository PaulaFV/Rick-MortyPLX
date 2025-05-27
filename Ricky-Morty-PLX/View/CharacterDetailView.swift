//
//  CharacterDetailView.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation
import UIKit

class CharacterDetailView : UIViewController{
    
    private let character : Character
    private let imageView = UIImageView()
    private let infoLabel = UILabel()
    
    init(character : Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder : NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = character.name
        view.backgroundColor = .darkGray
        setupUI()
        loadImage()
    }
    
    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.numberOfLines = 0
        infoLabel.font = .systemFont(ofSize: 24)
        infoLabel.textColor = .white
        infoLabel.textAlignment = .center
        
        view.addSubview(imageView)
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo : view.safeAreaLayoutGuide.topAnchor , constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            infoLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        infoLabel.text = """
        Status: \(character.status)
        
        Species: \(character.species)
        
        Gender: \(character.gender)
        
        Origin: \(character.origin.name)
        
        Location: \(character.location.name)
        """

    }
    
    private func loadImage() {
        guard let url = URL(string: character.image) else { return }
        
        URLSession.shared.dataTask(with: url) { data , _ , _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
