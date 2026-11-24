//
//  LawyersCategoriesListCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 13/6/26.
//


import UIKit

enum SectionLawyersList: Int, CaseIterable {

    case firstSection
    case secondSection

}

class LawyersCategoriesListCollectionViewController:
    CoreCollectionViewController {

    var categories: CategoriesModel?

    weak var coordinator: BookingCoordinator?

    // MARK: - Datos reales obtenidos desde FastAPI

    private var lawyers: [LawyerResponseModel] = []

    // MARK: - Modelos de presentación

    var lawyersCard: [LawyersCardsModel] {

        lawyers.map { lawyer in

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

        registerCells()

        configureLayout()

        // Consultar los abogados registrados en PostgreSQL
        loadLawyers()

    }

    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()

        collectionView.frame = view.bounds

    }

    // MARK: - Consultar abogados desde FastAPI

    private func loadLawyers() {

        Task { @MainActor [weak self] in

            guard let self = self else {
                return
            }

            do {

                let response = try await APICaller.shared.getLawyers()

                // Mostrar únicamente cuentas activas
                self.lawyers = response.filter {
                    $0.user.isActive
                }

                self.collectionView.reloadSections(
                    IndexSet(
                        integer: SectionLawyersList.secondSection.rawValue
                    )
                )

            } catch {

                self.showError(error.localizedDescription)

            }

        }

    }

    // MARK: - Mostrar errores

    private func showError(_ message: String) {

        let alert = UIAlertController(
            title: "Abogados",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "Aceptar",
                style: .default
            )
        )

        present(alert, animated: true)

    }

    // MARK: - REGISTER CELLS

    func registerCells() {

        collectionView.register(
            LawyersListHeaderCollectionViewCell.self,
            forCellWithReuseIdentifier:
                LawyersListHeaderCollectionViewCell.identifier
        )

        collectionView.register(
            LawyersListCollectionViewCell.self,
            forCellWithReuseIdentifier:
                LawyersListCollectionViewCell.identifier
        )

        collectionView.register(
            FilterSectionCollectionViewCell.self,
            forSupplementaryViewOfKind:
                UICollectionView.elementKindSectionHeader,
            withReuseIdentifier:
                FilterSectionCollectionViewCell.identifier
        )

    }

    // MARK: - LAYOUT OF COLLECTION VIEW

    func configureLayout() {

        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, _ -> NSCollectionLayoutSection in

            return self.createSectionLayout(
                section: sectionIndex
            )

        }

        collectionView.setCollectionViewLayout(
            layout,
            animated: false
        )

    }

    func createSectionLayout(
        section: Int
    ) -> NSCollectionLayoutSection {

        let header = [

            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(54)
                ),
                elementKind:
                    UICollectionView.elementKindSectionHeader,
                alignment: .topLeading
            )

        ]

        switch section {

        // MARK: - Primera sección

        case 0:

            let firstItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(135)
                )
            )

            let firstGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: firstItem.layoutSize,
                subitems: [firstItem]
            )

            let firstSection = NSCollectionLayoutSection(
                group: firstGroup
            )

            return firstSection

        // MARK: - Segunda sección

        case 1:

            let secondItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(420)
                )
            )

            let secondGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: secondItem.layoutSize,
                subitems: [secondItem]
            )

            secondGroup.contentInsets = .init(
                top: 0,
                leading: 15,
                bottom: 0,
                trailing: 15
            )

            let secondSection = NSCollectionLayoutSection(
                group: secondGroup
            )

            secondSection.boundarySupplementaryItems = header

            secondSection.interGroupSpacing = 20

            return secondSection

        // MARK: - Sección por defecto

        default:

            let defaultItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .estimated(140),
                    heightDimension: .absolute(200)
                )
            )

            let defaultGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: defaultItem.layoutSize,
                subitem: defaultItem,
                count: 23
            )

            let defaultSection = NSCollectionLayoutSection(
                group: defaultGroup
            )

            return defaultSection

        }

    }

}

// MARK: - UICollectionView DataSource

extension LawyersCategoriesListCollectionViewController:
    UICollectionViewDelegateFlowLayout {

    override func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {

        return SectionLawyersList.allCases.count

    }

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        guard let section = SectionLawyersList(
            rawValue: section
        ) else {
            return 0
        }

        switch section {

        case .firstSection:

            return 1

        case .secondSection:

            // Cantidad real de abogados
            return lawyers.count

        }

    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard let section = SectionLawyersList(
            rawValue: indexPath.section
        ) else {
            return UICollectionViewCell()
        }

        switch section {

        case .firstSection:

            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier:
                    LawyersListHeaderCollectionViewCell.identifier,
                for: indexPath
            ) as? LawyersListHeaderCollectionViewCell else {

                return UICollectionViewCell()

            }

            if let category = categories {

                cell.configure(with: category)

            }

            return cell

        case .secondSection:

            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier:
                    LawyersListCollectionViewCell.identifier,
                for: indexPath
            ) as? LawyersListCollectionViewCell else {

                return UICollectionViewCell()

            }

            let lawyer = lawyers[indexPath.item]

            // Convertir el modelo de API en un modelo visual
            let card = LawyersCardsModel(
                profileImage: UIImage(named: "abog"),
                name: lawyer.user.name,
                qualification: nil
            )

            cell.delegate = self

            // La API todavía no devuelve la especialidad.
            // No asignar una categoría que no está confirmada.
            cell.configure(
                with: card,
                and: nil
            )

            return cell

        }

    }

    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {

        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier:
                    FilterSectionCollectionViewCell.identifier,
                for: indexPath
              ) as? FilterSectionCollectionViewCell else {

            return UICollectionReusableView()

        }

        return header

    }

}

// MARK: - Filtros

extension LawyersCategoriesListCollectionViewController:
    FilterSectionCollectionViewCellDelegate {

    func onFilterLawyerListBtnTapped(
        _ filter: LawyersFilter
    ) {

        switch filter {

        case .all:

            print("all")

        case .available:

            print("available")

        case .topRated:

            print("top rated")

        }

        collectionView.reloadSections(
            IndexSet(integer: 1)
        )

    }

}

// MARK: - Seleccionar el abogado

extension LawyersCategoriesListCollectionViewController:
    LawyersListCollectionViewCellDelegate {

    func didTapWatchLawyerProfile(
        _ cell: LawyersListCollectionViewCell
    ) {

        guard let indexPath = collectionView.indexPath(for: cell),
              indexPath.section == SectionLawyersList.secondSection.rawValue,
              lawyers.indices.contains(indexPath.item) else {

            return

        }

        // Obtener el abogado real seleccionado
        let selectedLawyer = lawyers[indexPath.item]

        // Enviar el modelo de API al coordinador
        coordinator?.goToLawyerDescriptionProfile(
            lawyer: selectedLawyer
        )

    }

}
