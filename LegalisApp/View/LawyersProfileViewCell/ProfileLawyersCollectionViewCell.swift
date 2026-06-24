//
//  ProfileLawyersCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 19/6/26.
//

import UIKit

class ProfileLawyersCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "ProfileLawyersCollectionViewCell"
  
  // lawyer image
  let lawyerImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.backgroundColor = .orange
    image.clipsToBounds = true
    image.heightAnchor.constraint(equalToConstant: 397).isActive = true

    image.translatesAutoresizingMaskIntoConstraints = false
    
    return image
  }()
  
  //lawyer name
  private let lawyerNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Pedro Martinez"
    label.numberOfLines = 1
    label.font = UIFont(name: "Inter-Regular_Bold", size: 34)
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
    label.text = "Derecho civil"
    label.numberOfLines = 1
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 17)
    label.textColor = #colorLiteral(red: 0, green: 0.1370561421, blue: 0.2949633002, alpha: 1)
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
    
    let specialityStack = UIStackView(arrangedSubviews: [
      headerSecondSection,
      lawCategoryLabel
    ])
    specialityStack.axis = .vertical
    specialityStack.spacing = 3
    specialityStack.alignment = .leading
    specialityStack.backgroundColor = .white
    specialityStack.layer.cornerRadius = 12
    specialityStack.layer.borderColor = #colorLiteral(red: 0.7682896852, green: 0.7757481933, blue: 0.817332685, alpha: 1)
    specialityStack.layer.borderWidth = 2
    specialityStack.isLayoutMarginsRelativeArrangement = true
    specialityStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    specialityStack.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(lawyerImage)
    contentView.addSubview(lawyerNameLabel)
    contentView.addSubview(specialityStack)
    
    NSLayoutConstraint.activate([
      lawyerImage.topAnchor.constraint(equalTo: contentView.topAnchor),
      lawyerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      lawyerImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      lawyerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      lawyerNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      lawyerNameLabel.bottomAnchor.constraint(equalTo: specialityStack.topAnchor, constant: 2),
      specialityStack.topAnchor.constraint(equalTo: lawyerImage.bottomAnchor, constant: -25),
      specialityStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      specialityStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
    ])
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
