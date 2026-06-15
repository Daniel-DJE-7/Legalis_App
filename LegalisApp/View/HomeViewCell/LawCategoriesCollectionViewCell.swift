//
//  LawCategoriesCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 11/6/26.
//

import UIKit

class LawCategoriesCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "LawCategoriesCollectionViewCell"
  
  private let leftIcon = UIImageView()
  private let categoriesName = UILabel()
  private let rightIcon:  UIImageView = {
    let img = UIImageView()
    img.image = UIImage(systemName: "chevron.right")
    img.tintColor = .systemGray4
    img.clipsToBounds = true
    img.contentMode = .scaleAspectFit
    img.widthAnchor.constraint(equalToConstant: 20).isActive = true
    img.heightAnchor.constraint(equalToConstant: 20).isActive = true
    img.translatesAutoresizingMaskIntoConstraints = false
    
    return img
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpDivider() {
    
    //leftIcon
    leftIcon.clipsToBounds = true
    leftIcon.contentMode = .scaleAspectFit
    leftIcon.translatesAutoresizingMaskIntoConstraints = false
    
    //categoriesName
    categoriesName.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    categoriesName.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func setUpUI() {
    
    let categoriesStack = UIStackView(arrangedSubviews: [
      leftIcon,
      categoriesName,
      rightIcon
    ])
    categoriesStack.axis = .horizontal
    categoriesStack.spacing = 10
    categoriesStack.alignment = .leading
    categoriesStack.isLayoutMarginsRelativeArrangement = true
    categoriesStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 5)
    categoriesStack.contentMode = .scaleAspectFill
    categoriesStack.translatesAutoresizingMaskIntoConstraints = false

    contentView.addSubview(categoriesStack)
  
    
    NSLayoutConstraint.activate([
      //leftIcon
      leftIcon.widthAnchor.constraint(equalToConstant: 20),
      leftIcon.heightAnchor.constraint(equalToConstant: 20),
      
     categoriesStack.widthAnchor.constraint(equalToConstant: 350),
      
  
    ])
  }
  
  func configure(categories: categoriesModel) {
    leftIcon.image = categories.leftIcon
    categoriesName.text = categories.name
  }
  
}
