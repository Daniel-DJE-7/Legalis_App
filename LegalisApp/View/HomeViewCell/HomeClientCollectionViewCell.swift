//
//  HomeClientCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 10/6/26.
//

import UIKit

class HomeClientCollectionViewCell: UICollectionViewCell {
   
  static let identifier = "HomeClientCollectionViewCell"
  
  private let cheersLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false

    let text = "Bienvenido de nuevo, \n Hola, Usuario"
    
    let attributedString = NSMutableAttributedString(string: text)
    
    let welcomeRange = (text as NSString).range(of: "Bienvenido de nuevo,")
    
    attributedString.addAttributes([
      .foregroundColor : #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1),
      .font : UIFont(name: "Inter-regular", size: 15) as Any
    ], range: welcomeRange)
    
    let cheersRange = (text as NSString).range(of: "Hola, Usuario")
    
    attributedString.addAttributes([
      .foregroundColor : #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1),
      .font : UIFont(name: "Inter-Regular_Bold", size: 34) as Any
    ], range: cheersRange)
    
    label.attributedText = attributedString
    
    return label
  }()
  
  let appointmentImage = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpUIElements()
    setUpUI()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setUpUIElements() {
  
    appointmentImage.image = UIImage(named: "appointmentSection")
    appointmentImage.contentMode = .scaleAspectFill
    appointmentImage.clipsToBounds = true
    appointmentImage.translatesAutoresizingMaskIntoConstraints = false
  }

  func setUpUI() {
    

    contentView.addSubview(cheersLabel)
    contentView.addSubview(appointmentImage)
 
    
    NSLayoutConstraint.activate([
      cheersLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
      cheersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      cheersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      
      appointmentImage.topAnchor.constraint(equalTo: cheersLabel.bottomAnchor, constant: 15),
      appointmentImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      appointmentImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      appointmentImage.heightAnchor.constraint(equalToConstant: 160)

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
