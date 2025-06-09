//
//  CharacterDetailView.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation
import UIKit

class CharacterDetailView: UIViewController {
    private let viewModel: CharacterDetailViewModel
    private let imageView = UIImageView()
    private let statusLabel = UILabel()
    private let speciesLabel = UILabel()
    private let genderLabel = UILabel()
    private let originLabel = UILabel()
    private let locationLabel = UILabel()
    private let favouriteButton = UIButton(type: .system)
    
    init(character: Character) {
        self.viewModel = CharacterDetailViewModel(character: character)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.character.name
        view.backgroundColor = .darkGray
        setupUI()
        bindViewModel()
        viewModel.loadImage()
    }
    
    private func setUpLabel(label: UILabel, text: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.text = text
    }
    
    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        favouriteButton.addTarget(self, action: #selector(toggleFavourite), for: .touchUpInside)
        
        setUpLabel(label: statusLabel, text: "Status: \(viewModel.character.status)")
        setUpLabel(label: speciesLabel, text: "Species: \(viewModel.character.species)")
        setUpLabel(label: genderLabel, text: "Gender: \(viewModel.character.gender)")
        setUpLabel(label: originLabel, text: "Origin: \(viewModel.character.origin.name)")
        setUpLabel(label: locationLabel, text: "Location: \(viewModel.character.location.name)")
        
        view.addSubview(imageView)
        view.addSubview(statusLabel)
        view.addSubview(speciesLabel)
        view.addSubview(genderLabel)
        view.addSubview(originLabel)
        view.addSubview(locationLabel)
        view.addSubview(favouriteButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo : view.safeAreaLayoutGuide.topAnchor , constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            statusLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            speciesLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            speciesLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            speciesLabel.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            
            genderLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 10),
            genderLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            genderLabel.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            
            originLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10),
            originLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            originLabel.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            
            favouriteButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 24),
            favouriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onImageLoaded = { [weak self] image in
            self?.imageView.image = image
        }
        
        updateFavouriteButton()
    }
    
    private func updateFavouriteButton() {
        let title = viewModel.isFavourite() ? "Quit Favourite" : " Add Favourite"
        favouriteButton.setTitle(title, for: .normal)
    }
    
    @objc private func toggleFavourite() {
        viewModel.toggleFavourite()
        updateFavouriteButton()
    }
}
