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
}
