//
//  PendingCashPaymentCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 20/11/26.
//

import UIKit

final class PendingCashPaymentCollectionViewCell: UICollectionViewCell {

    static let identifier = "PendingCashPaymentCollectionViewCell"

    private let pendingIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "clock.badge.exclamationmark")
        image.tintColor = .systemOrange
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pendiente de pago presencial"
        label.font = UIFont(name: "Inter-Regular_Bold", size: 28) ?? .boldSystemFont(ofSize: 28)
        label.textColor = UIColor(red: 0, green: 0.106, blue: 0.239, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Tu cita ha sido registrada.

        Deberás realizar el pago directamente al abogado cuando llegues a su oficina.
        """
        label.font = UIFont(name: "Inter-Regular", size: 15) ?? .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let appointmentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Bold", size: 26) ?? .boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Estado: Pendiente de pago presencial"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemOrange
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let informationLabel: UILabel = {
        let label = UILabel()
        label.text = """
        El abogado deberá solicitar el pago y confirmar su recepción cuando asistas a la oficina.
        """
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {

        let detailsStack = UIStackView(arrangedSubviews: [
            appointmentLabel,
            amountLabel,
            statusLabel
        ])

        detailsStack.axis = .vertical
        detailsStack.alignment = .fill
        detailsStack.spacing = 12
        detailsStack.backgroundColor = .systemGray6
        detailsStack.layer.cornerRadius = 12
        detailsStack.isLayoutMarginsRelativeArrangement = true
        detailsStack.layoutMargins = UIEdgeInsets(top: 20, left: 12, bottom: 20, right: 12)

        let globalStack = UIStackView(arrangedSubviews: [
            pendingIcon,
            titleLabel,
            descriptionLabel,
            detailsStack,
            informationLabel
        ])

        globalStack.axis = .vertical
        globalStack.alignment = .fill
        globalStack.spacing = 20
        globalStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(globalStack)

        NSLayoutConstraint.activate([
            globalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            globalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            globalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            pendingIcon.heightAnchor.constraint(equalToConstant: 75)
        ])
    }

    func configure(appointmentId: Int, pendingAmount: Int) {

        appointmentLabel.text = "Cita #\(appointmentId)"

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "es_CO")
        formatter.maximumFractionDigits = 0

        let amount = formatter.string(from: NSNumber(value: pendingAmount)) ?? "\(pendingAmount)"

        amountLabel.text = "$\(amount) COP"
    }
}
