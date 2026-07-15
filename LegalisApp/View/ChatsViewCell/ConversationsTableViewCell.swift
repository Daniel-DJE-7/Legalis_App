//
//  ConversationsTableViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 13/7/26.
//

import UIKit

class ConversationsTableViewCell: UITableViewCell {

  static let identifier = "ConversationsTableViewCell"

  private let userImage: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(named: "f")
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    img.tintColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    img.widthAnchor.constraint(equalToConstant: 44).isActive = true
    img.heightAnchor.constraint(equalToConstant: 44).isActive = true
    img.layer.cornerRadius = 22
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private let userNameLabel: UILabel = {
    let label = UILabel()
    label.text = "María Sanchez"
    label.numberOfLines = 0
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 17)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let timeLabel: UILabel = {
    let label = UILabel()
    label.text = "10:24 AM"
    label.numberOfLines = 0
    label.textColor = #colorLiteral(red: 0, green: 0.1370561421, blue: 0.2949633002, alpha: 1)
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 12)
    label.widthAnchor.constraint(equalToConstant: 59).isActive = true
    
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let messageLabel: UILabel = {
    let label = UILabel()
    label.text = """
                 He revisado el contrato de arrendamiento.
                 Necesitamos ajustar la cláusula 4.2 antes de firmar.
                 """
    label.numberOfLines = 0
    label.textColor = #colorLiteral(red: 0.262216866, green: 0.2779523134, blue: 0.3071090579, alpha: 1)
    label.font = UIFont(name: "Inter-Regular", size: 15)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let spacing = UIView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.backgroundColor = .white.withAlphaComponent(0.1)
    
    setUPUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUPUI() {
    
    let nameHourStack = UIStackView(arrangedSubviews: [
      userNameLabel,
      timeLabel
    ])
    nameHourStack.axis = .horizontal
    nameHourStack.spacing = 33
    nameHourStack.distribution = .fill
    nameHourStack.translatesAutoresizingMaskIntoConstraints = false
    
    let labelStack = UIStackView(arrangedSubviews: [
      nameHourStack,
      messageLabel
    ])
    labelStack.axis = .vertical
    labelStack.spacing = 2
    labelStack.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(userImage)
    contentView.addSubview(labelStack)
    
    NSLayoutConstraint.activate([
      
      userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      
      spacing.widthAnchor.constraint(equalToConstant: 10),

      labelStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      labelStack.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 20),
      labelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      labelStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      
      
    ])
    
  }
  
}

/*
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
 */
