//
//  HoursCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 25/6/26.
//

import UIKit

import UIKit

final class HoursCollectionViewCell: UICollectionViewCell {

    static let identifier = "HoursCollectionViewCell"

    let hourLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        contentView.addSubview(hourLabel)

        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.textAlignment = .center
        hourLabel.font = UIFont(
            name: "Inter-Regular",
            size: 14
        ) ?? .systemFont(ofSize: 14)

        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1

        NSLayoutConstraint.activate([
            hourLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            hourLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            )
        ])
    }

    func configure(
        hour: String,
        isAvailable: Bool,
        isSelected: Bool
    ) {

        hourLabel.text = hour

        if !isAvailable {

            contentView.backgroundColor = .systemGray6
            contentView.layer.borderColor = UIColor.systemGray5.cgColor

            hourLabel.textColor = .systemGray3

            hourLabel.attributedText = NSAttributedString(
                string: hour,
                attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .foregroundColor: UIColor.systemGray3
                ]
            )

        } else if isSelected {

            contentView.backgroundColor = UIColor.systemBlue
                .withAlphaComponent(0.12)

            contentView.layer.borderColor = UIColor.systemBlue.cgColor
            hourLabel.attributedText = nil
            hourLabel.text = hour
            hourLabel.textColor = .systemBlue

        } else {

            contentView.backgroundColor = .white
            contentView.layer.borderColor = UIColor.systemGray4.cgColor

            hourLabel.attributedText = nil
            hourLabel.text = hour
            hourLabel.textColor = .label
        }
    }
}
