//
//  PendingCashPaymentViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 20/11/26.
//

import UIKit

private enum SectionPendingCashPayment: Int, CaseIterable {
    case header
    case paymentDetails
    case continueBtn
}

final class PendingCashPaymentCollectionViewController: CoreCollectionViewController {

    weak var coordinator: BookingCoordinator?

    var appointmentId: Int = 0
    var pendingAmount: Int = 0

    private let titleHeader = "Pago presencial"
    private let descriptionPage = "Información de tu reserva"

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .systemGray6

        setUpNavBar()
        registerCells()
        configureLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    // MARK: - NAVIGATION BAR

    private func setUpNavBar() {

        navigationItem.title = "Legalis"

        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(
                name: "Inter-Regular_SemiBold",
                size: 17
            ) ?? .systemFont(ofSize: 17, weight: .semibold),

            .foregroundColor: UIColor(
                red: 0,
                green: 0.106,
                blue: 0.239,
                alpha: 1
            )
        ]

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.hidesBackButton = true
    }

    // MARK: - REGISTER CELLS

    private func registerCells() {

        collectionView.register(
            PaymentHeaderCollectionViewCell.self,
            forCellWithReuseIdentifier:
                PaymentHeaderCollectionViewCell.identifier
        )

        collectionView.register(
            PendingCashPaymentCollectionViewCell.self,
            forCellWithReuseIdentifier:
                PendingCashPaymentCollectionViewCell.identifier
        )

        collectionView.register(
            ContinueButtonCollectionViewCell.self,
            forCellWithReuseIdentifier:
                ContinueButtonCollectionViewCell.identifier
        )
    }

    // MARK: - LAYOUT

    private func configureLayout() {

        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in

            return self?.createSectionLayout(section: sectionIndex)
        }

        collectionView.setCollectionViewLayout(layout,animated: false)
    }

    private func createSectionLayout(section: Int) -> NSCollectionLayoutSection {

        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(100)
            )
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(100)
            ),
            subitems: [item]
        )

        let layoutSection = NSCollectionLayoutSection(group: group)

        switch SectionPendingCashPayment(rawValue: section) {

        case .header:
            break

        case .paymentDetails:
            layoutSection.contentInsets = NSDirectionalEdgeInsets(
                top: 8,
                leading: 16,
                bottom: 8,
                trailing: 16
            )

        case .continueBtn:
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 24, trailing: 16)

        case .none:
            break
        }

        return layoutSection
    }
}

// MARK: - COLLECTION VIEW DATA SOURCE

extension PendingCashPaymentCollectionViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionPendingCashPayment.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let section = SectionPendingCashPayment(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }

        switch section {

        case .header:

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentHeaderCollectionViewCell.identifier, for: indexPath) as? PaymentHeaderCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.configure(with: titleHeader, and: descriptionPage)

            return cell

        case .paymentDetails:

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:PendingCashPaymentCollectionViewCell.identifier,
                for: indexPath) as? PendingCashPaymentCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.backgroundColor = .white
            cell.layer.cornerRadius = 12
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.systemGray4.cgColor

            cell.configure(appointmentId: appointmentId,pendingAmount: pendingAmount)

            return cell

        case .continueBtn:

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContinueButtonCollectionViewCell.identifier, for: indexPath) as? ContinueButtonCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.configure(with: "Ir a mis citas")
            cell.delegate = self

            return cell
        }
    }
}

// MARK: - BUTTON DELEGATE

extension PendingCashPaymentCollectionViewController: ContinueButtonCollectionViewCellDelegate {

    func onContinueBtnTapped() {
      coordinator?.userDidTapGoToMyAppointments()
    }
}
