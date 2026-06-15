//
//  LawyersListCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 15/6/26.
//

import UIKit

class LawyersListCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "LawyersListCollectionViewCell"
  
  
  private let categoryName: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Inter-Regular_Bold", size: 34)
    label.numberOfLines = 0
    label.lineBreakMode = .byClipping
    label.backgroundColor = .red
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let categoryDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "Escoge los mejores especialistas para tu caso."
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.numberOfLines = 1
    label.textAlignment = .left
    label.font = UIFont(name: "Inter", size: 15)
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
  
  
  func setUpUI() {
    
    let headerStack = UIStackView(arrangedSubviews: [
      categoryName,
      categoryDescriptionLabel
    ])
    headerStack.axis = .vertical
    headerStack.alignment = .leading
    headerStack.spacing = 4
    headerStack.isLayoutMarginsRelativeArrangement = true
    headerStack.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 16, right: 5)
    headerStack.translatesAutoresizingMaskIntoConstraints = false
    
    
    contentView.addSubview(headerStack)
    
    NSLayoutConstraint.activate([
      categoryName.widthAnchor.constraint(equalToConstant: 352),
      categoryName.heightAnchor.constraint(equalToConstant: 82)
    ])
   
  }
  
  
  func configure(with category: categoriesModel) {
    categoryName.text = category.name
  }
  

  
  
  
}


/*
 Inter
 Inter-Regular
 Inter-Regular_Thin
 Inter-Regular_ExtraLight
 Inter-Regular_Light
 Inter-Regular_Medium
 Inter-Regular_SemiBold
 Inter-Regular_Bold
 Inter-Regular_ExtraBold
 Inter-Regular_Black
 */
