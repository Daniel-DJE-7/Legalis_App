//
//  GreetingsHeaderCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 16/7/26.
//

import UIKit

class GreetingsHeaderCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "HomeClientCollectionViewCell"
  
  private let welcomeLabel: UILabel = {
    let label = UILabel()
    label.text = "Bienvenido de nuevo,"
    label.font = UIFont(name: "Inter-regular", size: 15)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let helloLabel: UILabel = {
    let label = UILabel()
    label.text = "Hola,"
    label.textAlignment = .left
    label.font = UIFont(name: "Inter-Regular_Bold", size: 34)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.text = "Abogado"
    label.textAlignment = .left
    label.font = UIFont(name: "Inter-Regular_Bold", size: 34)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
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
    
    let userCheersStack = UIStackView(arrangedSubviews: [
      helloLabel,
      usernameLabel
    ])
    userCheersStack.axis = .horizontal
    userCheersStack.spacing = 1
    userCheersStack.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(welcomeLabel)
    contentView.addSubview(userCheersStack)
    
    
    NSLayoutConstraint.activate([
      //welcomeLabel
      welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
      welcomeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      welcomeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      
      //Hello label
      helloLabel.widthAnchor.constraint(equalToConstant: 85),
      userCheersStack.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
      userCheersStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      userCheersStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
    ])
  }
  

  
}
