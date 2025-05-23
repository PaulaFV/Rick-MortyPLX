//
//  ListaPersonajesView.swift
//  ProyectoRick
//
//  Created by Paula Fernández Vázquez on 20/5/25.
//
import UIKit
import Combine

class ListaPersonajesView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private var viewModel: CharactersListViewModel
    private var collectionView: UICollectionView!
    private var cancelables = Set<AnyCancellable>()

    init(viewModel: CharactersListViewModel = CharactersListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rick&Morty Characters"
        view.backgroundColor = .darkGray
        configureCollectionView()
        linkViewModel()
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

    private func linkViewModel() {
        viewModel.$characters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancelables)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharactersCell.reuseId,
            for: indexPath
        ) as? CharactersCell else {
            return UICollectionViewCell()
        }
        let character = viewModel.getCharacters(index: indexPath.item)
        cell.configure(character: character)
        return cell
    }
    
    // TODO AÑADIR FUNCIONALIDAD PARA IR A LA CLASE CHARACTERDETAILS
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = viewModel.characters[indexPath.item]
        let vcDetail = ClasePrueba()
        navigationController?.pushViewController(vcDetail, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 100 {
            viewModel.loadCharacters()
        }
    }
}
