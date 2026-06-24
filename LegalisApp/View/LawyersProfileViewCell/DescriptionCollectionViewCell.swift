//
//  DescriptionCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 22/6/26.
//

import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell {
  
  let descriptionView: UIView = {
    let dv = UIView()
    dv.backgroundColor = .systemBackground
    dv.layer.cornerRadius = 12
    dv.layer.borderWidth = 2
    dv.layer.borderColor = #colorLiteral(red: 0.7682896852, green: 0.7757481933, blue: 0.817332685, alpha: 1)
    dv.translatesAutoresizingMaskIntoConstraints = false
    return dv
  }()
  
  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    label.numberOfLines = 20
    label.textColor = #colorLiteral(red: 0.262216866, green: 0.2779523134, blue: 0.3071090579, alpha: 1)
    label.font = UIFont(name: "Inter", size: 17)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  static let identifier = "DescriptionCollectionViewCell"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpUI() {
    
    descriptionView.addSubview(descriptionLabel)
    contentView.addSubview(descriptionView)
    
    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 15),
      descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 15),
      descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -15),
      descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -15),
      
      descriptionView.heightAnchor.constraint(equalToConstant: 200),
      
      descriptionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
      descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      descriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)

    ])
  }
  
}
