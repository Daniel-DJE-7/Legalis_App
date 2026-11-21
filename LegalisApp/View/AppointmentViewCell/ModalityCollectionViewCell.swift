//
//  ModalityCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 26/6/26.
//

import UIKit

enum AppointmentModality: String {
    case virtual = "VIRTUAL"
    case inPerson = "IN_PERSON"
}

protocol ModalityCollectionViewCellDelegate: AnyObject {
    func modalityCell(
        _ cell: ModalityCollectionViewCell,
        didSelect modality: AppointmentModality
    )
}

final class ModalityCollectionViewCell: UICollectionViewCell {

    static let identifier = "ModalityCollectionViewCell"

    weak var delegate: ModalityCollectionViewCellDelegate?

    private let virtualBtn = UIButton(type: .system)
    private let physicalBtn = UIButton(type: .system)

    private let selectedColor = UIColor(
        red: 0,
        green: 0.106,
        blue: 0.239,
        alpha: 1
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        virtualBtn.addTarget(
            self,
            action: #selector(virtualTapped),
            for: .touchUpInside
        )

        physicalBtn.addTarget(
            self,
            action: #selector(physicalTapped),
            for: .touchUpInside
        )

        let stack = UIStackView(
            arrangedSubviews: [
                virtualBtn,
                physicalBtn
            ]
        )

        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            stack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            stack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            stack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            )
        ])
    }

    func configure(selected: AppointmentModality?) {

        styleButton(
            virtualBtn,
            title: "Virtual",
            symbol: "video.fill",
            selected: selected == .virtual
        )

        styleButton(
            physicalBtn,
            title: "Presencial",
            symbol: "person.2.fill",
            selected: selected == .inPerson
        )
    }

    private func styleButton(
        _ button: UIButton,
        title: String,
        symbol: String,
        selected: Bool
    ) {

        var configuration = UIButton.Configuration.plain()

        configuration.title = title
        configuration.image = UIImage(systemName: symbol)
        configuration.imagePlacement = .top
        configuration.imagePadding = 8

        configuration.baseForegroundColor = selected
            ? .white
            : .darkGray

        configuration.background.backgroundColor = selected
            ? selectedColor
            : UIColor.systemGray5

        configuration.background.cornerRadius = 12

        button.configuration = configuration
    }

    @objc private func virtualTapped() {
        delegate?.modalityCell(self, didSelect: .virtual)
    }

    @objc private func physicalTapped() {
        delegate?.modalityCell(self, didSelect: .inPerson)
    }
}
