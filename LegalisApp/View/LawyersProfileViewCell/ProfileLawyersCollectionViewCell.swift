//
//  ProfileLawyersCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 19/6/26.
//

import UIKit

class ProfileLawyersCollectionViewCell: UICollectionViewCell {
    
  // lawyer image
  let lawyerImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    
    return image
  }()
  
  //lawyer name
  private let lawyerNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Pedro Martinez"
    label.numberOfLines = 1
    label.font = UIFont(name: "Inter-Regular_Bold", size: 17)
    label.textColor = .systemBackground
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //Speciality label
  private let headerSecondSection: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    
    let text = "ESPECIALIDAD"
    
    let attributedString = NSAttributedString(
      string: text,
      attributes: [
        .font : UIFont(name: "Inter", size: 13) as Any,
        .kern : -0.65,
        .foregroundColor : #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
      ]
    )
    label.attributedText = attributedString
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  //lawyer category label
  private let lawCategoryLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 17)
    label.textColor = #colorLiteral(red: 0, green: 0.1370561421, blue: 0.2949633002, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
