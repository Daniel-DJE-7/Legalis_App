//
//  LawCategoriesCollectionViewCell.swift
//  LegalisApp
//
//  Created by Memo Figueredo on 11/6/26.
//

import UIKit

class LawCategoriesCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "LawCategoriesCollectionViewCell"
  
  private let leftIcon = UIImageView()
  private let categoriesName = UILabel()
  private let rightIcon = UIImageView()
  let categoriesDivider = UIView()
  let spacer = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpDivider() {
    Utilities.divider(categoriesDivider, backgroundColor: .systemGray6, height: 1)
    
    //leftIcon
    leftIcon.clipsToBounds = true
    leftIcon.contentMode = .scaleAspectFit
    leftIcon.translatesAutoresizingMaskIntoConstraints = false
    
    //categoriesName
    categoriesName.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    
    //rightIcon
    Utilities.creatingImage(imageView: rightIcon,
                            image: UIImage(systemName: "") ?? UIImage(),
                            contentMode: .scaleAspectFit,
                            clipsToBounds: true,
                            tintColor: UIColor.systemGray6,
                            width: 10,
                            height: 10)
    
    rightIcon.translatesAutoresizingMaskIntoConstraints = false
    
  }
  
  func setUpUI() {
    
    let categoriesStack = UIStackView(arrangedSubviews: [
      leftIcon,
      categoriesName,
    ])
    categoriesStack.axis = .horizontal
    categoriesStack.spacing = 5
    categoriesStack.alignment = .leading
    categoriesStack.isLayoutMarginsRelativeArrangement = true
    categoriesStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
    categoriesStack.contentMode = .scaleAspectFill
    categoriesStack.translatesAutoresizingMaskIntoConstraints = false
  
    

    contentView.addSubview(categoriesStack)
    
    NSLayoutConstraint.activate([
      //leftIcon
      leftIcon.widthAnchor.constraint(equalToConstant: 20),
      leftIcon.heightAnchor.constraint(equalToConstant: 20),
      
      categoriesStack.widthAnchor.constraint(equalToConstant: 330),
      
      
  
    ])
  }
  
  func configure(categories: categoriesModel) {
    leftIcon.image = categories.leftIcon
    categoriesName.text = categories.name
    //rightIcon.image = categories.rightIcon
  }
  
}
