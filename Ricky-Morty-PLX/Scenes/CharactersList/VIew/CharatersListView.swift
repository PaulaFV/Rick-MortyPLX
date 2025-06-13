//
//  CharatersListView.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import UIKit
import Combine

class CharactersListView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private var viewModel: CharactersListViewModel
    private var collectionView: UICollectionView!
    private var cancellables = Set<AnyCancellable>()
    private let configureUseCase: ConfigureUseCaseProtocol
    private var selectedImageData: Data?
    
    init(viewModel: CharactersListViewModel, configureUseCase: ConfigureUseCaseProtocol) {
        self.viewModel = viewModel
        self.configureUseCase = configureUseCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rick & Morty Characters"
        view.backgroundColor = .darkGray
        setupCreateButton()
        configureCollectionView()
        bindViewModel()
        viewModel.loadCharacters()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 15
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .darkGray
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(CharactersCell.self, forCellWithReuseIdentifier: CharactersCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
    
    private func bindViewModel() {
        viewModel.$characters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCell.reuseId, for: indexPath) as? CharactersCell else {
            return UICollectionViewCell()
        }
        
        if let cellViewModel = viewModel.characterCellViewModel(at: indexPath.item) {
            cell.configure(with: cellViewModel)
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = viewModel.characters[indexPath.item]
        navigateToDetail(character: selectedCharacter)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.characters.count - 1 {
            viewModel.loadCharacters()
        }
    }
    
    private func navigateToDetail(character: Character) {
        let detailVC = CharacterDetailView(character: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //Create a custom character funcs
    private func setupCreateButton() {
        let createButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapCreateCharacter))
        navigationItem.rightBarButtonItem = createButton
    }
    
    @objc private func didTapCreateCharacter() {
        showCharacterCreationAlert()
    }
    
    private func showCharacterCreationAlert() {
        let alert = UIAlertController(title: "New character", message: "Input data", preferredStyle: .alert)
        
        alert.addTextField { $0.placeholder = "Name" }
        alert.addTextField { $0.placeholder = "Species" }
        alert.addTextField { $0.placeholder = "Gender" }
        alert.addTextField { $0.placeholder = "Status" }
        alert.addTextField { $0.placeholder = "Image URL" }
        alert.addTextField { $0.placeholder = "Origin" }
        alert.addTextField { $0.placeholder = "Location" }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard
                let name = alert.textFields?[0].text,
                let species = alert.textFields?[1].text,
                let gender = alert.textFields?[2].text,
                let status = alert.textFields?[3].text,
                let image = alert.textFields?[4].text,
                let origin = alert.textFields?[5].text,
                let location = alert.textFields?[6].text
            else {
                return
            }
            
            self.viewModel.createCustomCharacter(
                name: name,
                species: species,
                gender: gender,
                status: status,
                image: image,
                originName: origin,
                locationName: location
            )
        }
        
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
}
