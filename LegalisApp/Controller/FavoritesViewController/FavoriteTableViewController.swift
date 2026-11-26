//
//  FavoriteCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 19/6/26.
//

import UIKit

class FavoriteCollectionViewController: CoreCollectionViewController {

    fileprivate let searchBarController = UISearchController(
        searchResultsController: nil
    )

    var categories: CategoriesModel?

    weak var coordinator: FavoritesClientCoordinator?

    // MARK: - Datos reales de los abogados favoritos

    private var favoriteLawyers: [LawyerResponseModel] = []

    private var filteredLawyers: [LawyerResponseModel] = []

    // MARK: - Modelo de presentación

    var lawyersCard: [LawyersCardsModel] {

        filteredLawyers.map { lawyer in

            LawyersCardsModel(
                profileImage: UIImage(named: "abog"),
                name: lawyer.user.name,
                qualification: nil
            )

        }

    }

    // MARK: - Ciclo de vida

    override func viewDidLoad() {

        super.viewDidLoad()

        collectionView.backgroundColor = .systemGray6

        setUpSearchBar()
        configureLayout()
        resgisterCells()

    }

    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()

        collectionView.frame = view.bounds

    }

    // MARK: - Recibir abogados favoritos

    func configureFavorites(with lawyers: [LawyerResponseModel]) {

        favoriteLawyers = lawyers.filter {
            $0.user.isActive
        }

        filterLawyers(
            with: searchBarController.searchBar.text ?? ""
        )

    }

    // MARK: - Filtrar abogados por nombre

    private func filterLawyers(with text: String) {

        let searchText = text.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if searchText.isEmpty {

            filteredLawyers = favoriteLawyers

        } else {

            filteredLawyers = favoriteLawyers.filter {

                $0.user.name.localizedCaseInsensitiveContains(
                    searchText
                )

            }

        }

        if isViewLoaded {
            collectionView.reloadData()
        }
    }

    // MARK: - Registrar celdas

    func resgisterCells() {

        collectionView.register(
            LawyersListCollectionViewCell.self,
            forCellWithReuseIdentifier:
                LawyersListCollectionViewCell.identifier
        )

    }

    // MARK: - Configurar layout

    private func configureLayout() {

        let layout = UICollectionViewCompositionalLayout {
            [weak self] _, _ in

            return self?.createSectionLayout()

        }

        collectionView.setCollectionViewLayout(
            layout,
            animated: false
        )

    }

    func createSectionLayout() -> NSCollectionLayoutSection {

        // Item

        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(420)
            )
        )

        // Group

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: item.layoutSize,
            subitems: [item]
        )

        group.contentInsets = .init(
            top: 0,
            leading: 15,
            bottom: 0,
            trailing: 15
        )

        // Section

        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = 10

        return section

    }

}

// MARK: - SearchBar

extension FavoriteCollectionViewController: UISearchBarDelegate {

    func setUpSearchBar() {

        definesPresentationContext = true

        navigationItem.searchController = searchBarController

        navigationItem.hidesSearchBarWhenScrolling = false

        searchBarController.searchBar.placeholder = "Buscar"

        searchBarController.searchBar.searchTextField
            .clearButtonMode = .whileEditing

        searchBarController.obscuresBackgroundDuringPresentation = false

        searchBarController.searchBar.delegate = self

    }

    // Buscar abogados favoritos por nombre

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String ) {
        filterLawyers(with: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      filterLawyers(with: "")
    }
}

// MARK: - UICollectionView DataSource

extension FavoriteCollectionViewController:
    UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return filteredLawyers.count

    }

    override func collectionView( _ collectionView: UICollectionView,
                                  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
                LawyersListCollectionViewCell.identifier,
            for: indexPath
        ) as? LawyersListCollectionViewCell else {

            return UICollectionViewCell()

        }

        let lawyer = filteredLawyers[indexPath.item]

        let card = LawyersCardsModel(
            profileImage: UIImage(named: "abog"),
            name: lawyer.user.name,
            qualification: nil
        )

        cell.configure(with: card, and: nil)

        cell.delegate = self

        return cell

    }

}

// MARK: - Mostrar perfil del abogado favorito
extension FavoriteCollectionViewController:LawyersListCollectionViewCellDelegate {

    func didTapWatchLawyerProfile(_ cell: LawyersListCollectionViewCell) {

        guard let indexPath = collectionView.indexPath(for: cell),
              filteredLawyers.indices.contains(indexPath.item) else {
            return
        }

        // Obtener el abogado real seleccionado

        let selectedLawyer = filteredLawyers[indexPath.item]

        // Enviar todos los datos al coordinador

        coordinator?.goToLawyerDescriptionProfile(lawyer: selectedLawyer)

    }

}
