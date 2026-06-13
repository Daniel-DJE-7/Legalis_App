//
//  HomeClientCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 10/6/26.
//

import UIKit

class HomeClientCollectionViewCell: UICollectionViewCell {
   
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
    label.text = "Usuario"
    label.textAlignment = .left
    label.font = UIFont(name: "Inter-Regular_Bold", size: 34)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let appointmentImage = UIImageView()
  
  let nextAppointmentLabel: UILabel = {
    let label = UILabel()
    label.text = "PRÓXIMA CITA"
    label.textAlignment = .left
    label.backgroundColor = #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 0.3301176362)
    label.layer.cornerRadius = 4
    label.textColor = .white
    label.font = UIFont(name: "Inter-Regular_Bold", size: 10)
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  let consultationAppointmentLabel: UILabel = {
    let label = UILabel()
    label.text = "Consulta:"
    label.textAlignment = .left
    label.textColor = .white
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 17)
    label.widthAnchor.constraint(equalToConstant: 90).isActive = true
    label.translatesAutoresizingMaskIntoConstraints = false
      
      return label
  }()
  
  let lawTypeLabel: UILabel = {
    let label = UILabel()
    label.text = "Derecho civil"
    label.textColor = .white
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 17)
    label.translatesAutoresizingMaskIntoConstraints = false
      
    return label
  }()
  
  let dateAppointmentLabel: UILabel = {
    let label = UILabel()
    label.text = "Mañana a las 10:30 AM"
    label.textColor = #colorLiteral(red: 0.9999999404, green: 0.9999999404, blue: 1, alpha: 1)
    label.font = UIFont(name: "Inter", size: 12)
    label.translatesAutoresizingMaskIntoConstraints = false
      
    return label
  }()
  
  
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
    
    let userCheersStack = UIStackView(arrangedSubviews: [
      helloLabel,
      usernameLabel
    ])
    userCheersStack.axis = .horizontal
    userCheersStack.spacing = 1
    userCheersStack.translatesAutoresizingMaskIntoConstraints = false
    
    let consultingStack = UIStackView(arrangedSubviews: [
      consultationAppointmentLabel,
      lawTypeLabel
    ])
    consultingStack.axis = .horizontal
    consultingStack.spacing = 1
    
    let detailsAppointmentStack = UIStackView(arrangedSubviews: [
      consultingStack,
      dateAppointmentLabel
    ])
    detailsAppointmentStack.axis = .vertical
    detailsAppointmentStack.spacing = 1
    
    
    let wholeStack = UIStackView(arrangedSubviews: [
      nextAppointmentLabel,
      detailsAppointmentStack
    ])
    wholeStack.axis = .vertical
    wholeStack.isLayoutMarginsRelativeArrangement = true
    wholeStack.layoutMargins = UIEdgeInsets(top: 75, left: 20, bottom: 20, right: 20)
    wholeStack.translatesAutoresizingMaskIntoConstraints = false
    
    appointmentImage.addSubview(wholeStack)
    contentView.addSubview(welcomeLabel)
    contentView.addSubview(userCheersStack)

    contentView.addSubview(appointmentImage)
 
    
    NSLayoutConstraint.activate([
      //welcomeLabel
      welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
      welcomeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      welcomeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      
      //Hello label
      helloLabel.widthAnchor.constraint(equalToConstant: 85),
      userCheersStack.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
      userCheersStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      userCheersStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      
      //appointment image
      appointmentImage.topAnchor.constraint(equalTo: userCheersStack.bottomAnchor, constant: 15),
      appointmentImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      appointmentImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      appointmentImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
      appointmentImage.heightAnchor.constraint(equalToConstant: 160),

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
