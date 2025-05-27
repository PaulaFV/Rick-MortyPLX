//
//  CharactersCell.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//
import UIKit

class CharactersCell: UICollectionViewCell, CharactersCellProtocol {
    static let reuseId = "CharactersCell"
    private var configureUseCase: ConfigureUseCaseProtocol?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        //  label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    func injectUseCase(useCase: ConfigureUseCaseProtocol) {
        self.configureUseCase = useCase
    }
    
    func configure(character: Character) {
        nameLabel.text = character.name
        imageView.image = nil
        
        configureUseCase?.recieveImage(url: character.image) { [weak self] image in
            self?.imageView.image = image
        }
    }
}
