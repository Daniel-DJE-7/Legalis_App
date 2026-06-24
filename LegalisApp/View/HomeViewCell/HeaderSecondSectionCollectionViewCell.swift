//
//  HeaderSecondSectionCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 11/6/26.
//

import UIKit

class HeaderSecondSectionCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "HeaderSecondSectionCollectionViewCell"
  
  //Header label of second section
   let headerSecondSection: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    
    let text = "a"
    
    let attributedString = NSAttributedString(
      string: text,
      attributes: [
        .font : UIFont(name: "Inter", size: 13) as Any,
        .kern : -0.32,
        .foregroundColor : #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
      ]
    )
    label.attributedText = attributedString
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(headerSecondSection)
    headerSecondSection.frame = CGRect(x: 16, y: 0, width: 326, height: 18)
    
    NSLayoutConstraint.activate([
      headerSecondSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23)
    ])
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with title: String) {
    headerSecondSection.text = title
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
 
