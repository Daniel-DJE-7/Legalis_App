//
//  ProfileDataCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 22/6/26.
//

import UIKit

class ProfileDataCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "ProfileDataCollectionViewCell"
  
  private let iconMail: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(systemName: "envelope.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
    img.contentMode = .scaleAspectFit
    img.tintColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    img.widthAnchor.constraint(equalToConstant: 20).isActive = true
    img.heightAnchor.constraint(equalToConstant: 20).isActive = true
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private let mailLawyerLabel: UILabel = {
    let label = UILabel()
    label.text = "pedroMartinez@gmail.com"
    label.numberOfLines = 1
    label.font = UIFont(name: "Inter", size: 15)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.heightAnchor.constraint(equalToConstant: 20).isActive = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //price
  private let iconPrice: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(systemName: "dollarsign.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
    img.contentMode = .scaleAspectFit
    img.tintColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    img.widthAnchor.constraint(equalToConstant: 20).isActive = true
    img.heightAnchor.constraint(equalToConstant: 20).isActive = true
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  
  private let priceLawyerLabel: UILabel = {
    let label = UILabel()
    label.text = "$350.000 COP"
    label.numberOfLines = 1
    label.font = UIFont(name: "Inter-Regular_semibold", size: 15)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.heightAnchor.constraint(equalToConstant: 20).isActive = true
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
    
    
    let mailStack = UIStackView(arrangedSubviews: [
      iconMail,
      mailLawyerLabel
    ])
    mailStack.axis = .horizontal
    mailStack.spacing = 3
    mailStack.alignment = .center

    mailStack.translatesAutoresizingMaskIntoConstraints = false
    
    let priceStack = UIStackView(arrangedSubviews: [
      iconPrice,
      priceLawyerLabel
      
    ])
    priceStack.axis = .horizontal
    priceStack.spacing = 3
    priceStack.alignment = .center
    priceStack.translatesAutoresizingMaskIntoConstraints = false
    
    let globalStack = UIStackView(arrangedSubviews: [
      mailStack,
      priceStack
    ])
    globalStack.axis = .vertical
    globalStack.spacing = 5
    globalStack.backgroundColor = .white
    globalStack.layer.cornerRadius = 12
    globalStack.layer.borderColor = #colorLiteral(red: 0.7682896852, green: 0.7757481933, blue: 0.817332685, alpha: 1)
    globalStack.layer.borderWidth = 2
    globalStack.isLayoutMarginsRelativeArrangement = true
    globalStack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    globalStack.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(globalStack)
    
    NSLayoutConstraint.activate([
      globalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      globalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      globalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      globalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
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
