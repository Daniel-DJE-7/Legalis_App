//
//  HeaderSectionsCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 24/6/26.
//

import UIKit

class HeaderSectionsCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "HeaderSectionsCollectionViewCell"
  
  
  
  let headerRatingLabel = HeaderSecondSectionCollectionViewCell().headerSecondSection

  
  private let starIcon: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(systemName: "star.fill")
    img.tintColor = .systemYellow
    img.contentMode = .scaleAspectFit
    img.widthAnchor.constraint(equalToConstant: 20).isActive = true
    img.heightAnchor.constraint(equalToConstant: 20).isActive = true
    img.translatesAutoresizingMaskIntoConstraints = false
    
    return img
  }()
  
  let ratingNumberLabel: UILabel = {
    let label = UILabel()
//    label.text = "4.9"
    label.numberOfLines = 0
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.font = UIFont(name: "Inter-Regular_semibold", size: 17)
    label.translatesAutoresizingMaskIntoConstraints = false
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
    
    let starNumberStack = UIStackView(arrangedSubviews: [
      starIcon,
      ratingNumberLabel
    ])
    starNumberStack.axis = .horizontal
    starNumberStack.spacing = 5
    starNumberStack.translatesAutoresizingMaskIntoConstraints = false
    
    let globalStack = UIStackView(arrangedSubviews: [
      headerRatingLabel,
      starNumberStack
    ])
    globalStack.axis = .horizontal
    globalStack.spacing = 5
    globalStack.distribution = .equalSpacing
    globalStack.isLayoutMarginsRelativeArrangement = true
    globalStack.layoutMargins = .init(top: 16, left: 6, bottom: 0, right: 10)
    globalStack.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(globalStack)
    
    globalStack.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 5, right: 16))
  }
  
  func configure(with title: String, and number: String) {
    headerRatingLabel.text = title
    ratingNumberLabel.text = number
  }
  
}
