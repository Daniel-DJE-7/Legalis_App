//
//  LoginCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 10/7/26.
//

import UIKit

class LoginCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "LoginCollectionViewCell"
  
  // background image
  private let backgroundImage: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: "loginBackgroundImg")
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private let logoImage: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: "legalisLogo")
    image.contentMode = .scaleAspectFit
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    image.widthAnchor.constraint(equalToConstant: 150).isActive = true
    image.heightAnchor.constraint(equalToConstant: 150).isActive = true
    return image
  }()
  
  let emailTxtField = UITextField()
  let passwordTxtField = UITextField()
  
  let loginBtn = UIButton()
  let changePasswordBtn = UIButton()
  
  //Header of fields
  private let userFormLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.numberOfLines = 0
    
    let attributedString = NSAttributedString(
      string: "USUARIO",
      attributes: [
        .kern : 1.3,
        .font : UIFont(name: "Inter-Regular", size: 13) as Any,
        .foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      ]
    )
    
    label.attributedText = attributedString
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //Header of fields
  private let passwordFormLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.numberOfLines = 0
    
    let attributedString = NSAttributedString(
      string: "CONTRASEÑA",
      attributes: [
        .kern : 1.3,
        .font : UIFont(name: "Inter-Regular", size: 13) as Any,
        .foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      ]
    )
    
    label.attributedText = attributedString
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //Header of fields
  private let appDescriptionLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.numberOfLines = 0
    
    let attributedString = NSAttributedString(
      string: "SISTEMA DE GESTIÓN JURIDICA",
      attributes: [
        .kern : -0.32,
        .font : UIFont(name: "Inter-Regular", size: 13) as Any,
        .foregroundColor : #colorLiteral(red: 0.9921569228, green: 0.9921568036, blue: 0.9921569228, alpha: 0.7)
      ]
    )
    
    label.attributedText = attributedString
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let emailToolBar = UIToolbar()
  private let passwordToolBar = UIToolbar()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpTxtField()
    setUpBtn()
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpTxtField() {
    
    let paddingEmail = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 45))
    let paddingPassword = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 45))

    
    //emailTextField
    Utilities.clientTextFieldStyle(
      emailTxtField,
      placeholder: "Correo electrónico",
      isSecureTextEntry: false,
      keyboardAppearance: .dark,
      clearButtonMode: .whileEditing,
      keyboardType: .emailAddress,
      inputAccessoryView: emailToolBar,
      backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3),
      leftIcon: nil)
    
    emailTxtField.layer.cornerRadius = 12
    emailTxtField.layer.shadowRadius = 10
    emailTxtField.textColor = .white
    emailTxtField.translatesAutoresizingMaskIntoConstraints = false
    
    emailTxtField.leftView = paddingEmail
    emailTxtField.leftViewMode = .always
    
    emailTxtField.attributedPlaceholder = NSAttributedString(
        string: "Correo electrónico",
        attributes: [
          .foregroundColor: UIColor.white,
            .font: UIFont(name: "Inter-Regular", size: 16) as Any
        ]
    )
    
    //passwordTextField
    Utilities.clientTextFieldStyle(
      passwordTxtField,
      placeholder: "Contraseña",
      isSecureTextEntry: true,
      keyboardAppearance: .dark,
      clearButtonMode: .whileEditing,
      keyboardType: .default,
      inputAccessoryView: passwordToolBar,
      backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3),
      leftIcon: nil)
    
    passwordTxtField.layer.cornerRadius = 12
    passwordTxtField.layer.shadowRadius = 10
    passwordTxtField.textColor = .white
    passwordTxtField.translatesAutoresizingMaskIntoConstraints = false
    
    passwordTxtField.attributedPlaceholder = NSAttributedString(
        string: "Contraseña",
        attributes: [
          .foregroundColor: UIColor.white,
            .font: UIFont(name: "Inter-Regular", size: 16) as Any
        ]
    )
    
    passwordTxtField.leftView = paddingPassword
    passwordTxtField.leftViewMode = .always
    
  }
  
  private func setUpBtn() {
    Utilities.customButtonStyle(loginBtn,
                                appearance: .plain(),
                                title: "Ingresar",
                                image: UIImage(
                                  named: "logingBlue"),
                                imagePlacement: .trailing,
                                imagePadding: 10,
                                cornerRadius: 12,
                                cornerStyle: nil,
                                backgroundColor: #colorLiteral(
                                  red: 1,
                                  green: 1,
                                  blue: 1,
                                  alpha: 1),
                                baseForeground: #colorLiteral(
                                  red: 0.02250555344,
                                  green: 0.1571424603,
                                  blue: 0.3066731691,
                                  alpha: 1),
                                width: nil,
                                height: nil,
                                target: self,
                                action: #selector(dipTapLoginBtn))

    loginBtn.translatesAutoresizingMaskIntoConstraints = false
    
    Utilities.customButtonStyle(changePasswordBtn,
                                appearance: .plain(),
                                title: "Cambiar contraseña",
                                image: nil,
                                imagePlacement: nil,
                                imagePadding: nil,
                                cornerRadius: 0,
                                cornerStyle: nil,
                                backgroundColor: nil,
                                baseForeground: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                                width: nil,
                                height: nil,
                                target: self,
                                action: #selector(diptapChangePasswordBtn))

    changePasswordBtn.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setUpUI() {
    
   let emailStack = UIStackView(arrangedSubviews: [
    userFormLabel,
    emailTxtField
   ])
    emailStack.axis = .vertical
    emailStack.spacing = 8
    emailStack.translatesAutoresizingMaskIntoConstraints = false

    let passwordStack = UIStackView(arrangedSubviews: [
     passwordFormLabel,
     passwordTxtField
    ])
    passwordStack.axis = .vertical
    passwordStack.spacing = 8
    passwordStack.translatesAutoresizingMaskIntoConstraints = false

    let buttonStack = UIStackView(arrangedSubviews: [
      loginBtn,
      changePasswordBtn
    ])
    buttonStack.axis = .vertical
    buttonStack.spacing = 16
    buttonStack.distribution = .fill
    buttonStack.translatesAutoresizingMaskIntoConstraints = false

    contentView.addSubview(backgroundImage)
    contentView.addSubview(logoImage)
    contentView.addSubview(appDescriptionLabel)
    contentView.addSubview(emailStack)
    contentView.addSubview(passwordStack)
//    contentView.addSubview(passwordFormLabel)
//    contentView.addSubview(passwordTxtField)
    contentView.addSubview(buttonStack)
//
    NSLayoutConstraint.activate([
      //background image
      backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
      backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    //logo
      logoImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 100),
      logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
    //app description
      appDescriptionLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: -25),
      appDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      //emailStack
      emailStack.topAnchor.constraint(equalTo: appDescriptionLabel.bottomAnchor, constant: 48),
      emailStack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      emailStack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      emailStack.heightAnchor.constraint(equalToConstant: 70),
      //passwordStack
      passwordStack.topAnchor.constraint(equalTo: emailStack.bottomAnchor, constant: 20),
      passwordStack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      passwordStack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      passwordStack.heightAnchor.constraint(equalToConstant: 70),
      //buttonStack
      buttonStack.topAnchor.constraint(equalTo: passwordStack.bottomAnchor, constant: 40),
      buttonStack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      buttonStack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      buttonStack.heightAnchor.constraint(equalToConstant: 100),
    ])
  }
  
  @objc func dipTapLoginBtn() {
    print("ok")
  }
  
  
  @objc func diptapChangePasswordBtn() {
    print("oki")
  }
}
