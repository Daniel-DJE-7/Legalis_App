//
//  ClientsSignUpView.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 2/6/26.
//

import UIKit

protocol ClientsSignUpViewDelegate: AnyObject {
  func onCloseNavBtnTapped()
}


class ClientsSignUpView: UIView {
  
  //MARK: - Delegate
  weak var delegate: ClientsSignUpViewDelegate?
  
  //MARK: - NAV HEADER UI ELEMENTS
  private let logoImage = UIImageView()
  lazy var closeNavButton = UIButton()
  
  // MARK: - NAV LABELS UI ELEMENTS
  private let createAccountLabel: UILabel = {
    let label = UILabel()
    label.text = "Crear cuenta"
    label.textAlignment = .left
    label.font = UIFont(name: "Inter", size: 34)
    label.font = .systemFont(ofSize: 34, weight: .bold)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  
  private let messageLabel: UILabel = {
    let label = UILabel()
    label.text = "Complete sus datos para el registro legal."
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.textAlignment = .left
    label.font = .systemFont(ofSize: 15, weight: .regular)
    label.font = UIFont(name: "Inter", size: 15)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  //Header of fields
  private let headerSectionFormLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.numberOfLines = 0
    
    let attributedString = NSAttributedString(
      string: "INFORMACIÓN PERSONAL",
      attributes: [
        .kern : 0.65,
        .font : UIFont(name: "Inter", size: 13) as Any,
        .foregroundColor : #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
      ]
    )
    
    label.attributedText = attributedString
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //MARK: - Textfields
  
  let nameTextField = UITextField()
  let documentNumberTextField = UITextField()
  let phoneNumberTextField = UITextField()
  let selectSexTextField = UITextField()
  let emailTextField = UITextField()
  let passwordTextField = UITextField()
  
  let divider1 = UIView()
  let divider2 = UIView()
  let divider3 = UIView()
  let divider4 = UIView()
  let divider5 = UIView()
  let divider6 = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpStylesUIElements()
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: SET UP UI HEADER NAV ELEMENTS
  private func setUpStylesUIElements() {
  //Logo
    Utilities.creatingLogoImage(
      image: logoImage,
      img: UIImage(named: "logoHorizontal") ?? UIImage(),
      contentMode: .scaleAspectFit,
      clipsToBounds: true,
      color: UIColor(
        red: 0,
        green: 0.1370561421,
        blue: 0.2949633002,
        alpha: 1))
   
    //closeNavBtn
    Utilities.navBarBtn(closeNavButton,
                        appearance: .plain(),
                        image: UIImage(named: "closeSymbol"),
                        baseforegroundColor: UIColor(
                          red: 0.58236444,
                          green: 0.6418703198,
                          blue: 0.7210631967,
                          alpha: 1),
                        action: #selector(onCloseNavClientBtnTapped),
                        target: self)
    
    //MARK: - Textfields
    
    //nameTextField
    Utilities.clientTextFieldStyle(nameTextField, placeholder: "Nombre completo", isSecureTextEntry: false, keyboardAppearance: .dark, clearButtonMode: .whileEditing, keyboardType: .alphabet, inputAccessoryView: nil, backgroundColor: .systemRed)
    
    //documentNumberTextField
    Utilities.clientTextFieldStyle(documentNumberTextField, placeholder: "Nombre completo", isSecureTextEntry: false, keyboardAppearance: .dark, clearButtonMode: .whileEditing, keyboardType: .alphabet, inputAccessoryView: nil, backgroundColor: .systemBlue)
    
    //phoneNumberTextField
    Utilities.clientTextFieldStyle(phoneNumberTextField, placeholder: "Nombre completo", isSecureTextEntry: false, keyboardAppearance: .dark, clearButtonMode: .whileEditing, keyboardType: .alphabet, inputAccessoryView: nil, backgroundColor: .systemOrange)
    
    //selectSexTextField
    Utilities.clientTextFieldStyle(selectSexTextField, placeholder: "Nombre completo", isSecureTextEntry: false, keyboardAppearance: .dark, clearButtonMode: .whileEditing, keyboardType: .alphabet, inputAccessoryView: nil, backgroundColor: .purple)
    
    //emailTextField
    Utilities.clientTextFieldStyle(emailTextField, placeholder: "Nombre completo", isSecureTextEntry: false, keyboardAppearance: .dark, clearButtonMode: .whileEditing, keyboardType: .alphabet, inputAccessoryView: nil, backgroundColor: .yellow)
    
    //passwordTextField
    Utilities.clientTextFieldStyle(passwordTextField, placeholder: "Nombre completo", isSecureTextEntry: false, keyboardAppearance: .dark, clearButtonMode: .whileEditing, keyboardType: .alphabet, inputAccessoryView: nil, backgroundColor: .systemCyan)
    
   
  }
  
  
  private func setUpUI() {
    //HEADER NAV STACKVIEW
    let headerNavStack = UIStackView(arrangedSubviews: [
      logoImage, closeNavButton
    ])
    headerNavStack.axis = .horizontal
    headerNavStack.distribution = .equalSpacing
    headerNavStack.alignment = .center
    headerNavStack.backgroundColor = .white
    headerNavStack.layer.shadowColor = #colorLiteral(red: 0.8855352998, green: 0.9093011022, blue: 0.942697525, alpha: 1)
    headerNavStack.translatesAutoresizingMaskIntoConstraints = false
    headerNavStack.isLayoutMarginsRelativeArrangement = true
    headerNavStack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    //HEADER LABEL STACKVIEW
    let headerLabelStack = UIStackView(arrangedSubviews: [
      createAccountLabel, messageLabel
    ])
    headerLabelStack.axis = .vertical
    headerLabelStack.alignment = .leading
    headerLabelStack.distribution = .fillEqually
    headerLabelStack.spacing = 0
    headerLabelStack.translatesAutoresizingMaskIntoConstraints = false
    headerLabelStack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    headerLabelStack.isLayoutMarginsRelativeArrangement = true
    
    //HEADER AND FIELDS STACKVIEW
    let fieldsStack = UIStackView(arrangedSubviews: [
      nameTextField,
      divider1,
      documentNumberTextField,
      divider2,
      phoneNumberTextField,
      divider3,
      selectSexTextField,
      divider4,
      emailTextField,
      divider5,
      passwordTextField
    ])
    fieldsStack.axis = .vertical
    fieldsStack.spacing = 2
    fieldsStack.alignment = .fill
    fieldsStack.backgroundColor = .white
    fieldsStack.layer.cornerRadius = 10
    divider1.backgroundColor = .black
    divider2.backgroundColor = .black
    divider3.backgroundColor = .black
    divider4.backgroundColor = .black
    divider5.backgroundColor = .black
    
    fieldsStack.isLayoutMarginsRelativeArrangement = true
    fieldsStack.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    fieldsStack.translatesAutoresizingMaskIntoConstraints = false
    divider1.translatesAutoresizingMaskIntoConstraints = false
    divider2.translatesAutoresizingMaskIntoConstraints = false
    divider3.translatesAutoresizingMaskIntoConstraints = false
    divider4.translatesAutoresizingMaskIntoConstraints = false
    divider5.translatesAutoresizingMaskIntoConstraints = false

    divider1.heightAnchor.constraint(equalToConstant: 2).isActive = true
    divider2.heightAnchor.constraint(equalToConstant: 2).isActive = true
    divider3.heightAnchor.constraint(equalToConstant: 2).isActive = true
    divider4.heightAnchor.constraint(equalToConstant: 2).isActive = true
    divider5.heightAnchor.constraint(equalToConstant: 2).isActive = true
   
    fieldsStack.addArrangedSubview(divider1)
    fieldsStack.addArrangedSubview(divider2)
    fieldsStack.addArrangedSubview(divider3)
    fieldsStack.addArrangedSubview(divider4)
    fieldsStack.addArrangedSubview(divider5)
    
    
    addSubview(headerNavStack)
    addSubview(headerLabelStack)
    addSubview(headerSectionFormLabel)
    addSubview(fieldsStack)
    
    
  
    //MARK: - Constraints
    NSLayoutConstraint.activate([
      //HeaderNavStack
      headerNavStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      headerNavStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      headerNavStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      headerNavStack.heightAnchor.constraint(equalToConstant: 56),
      
      //HeaderLabelStack
      headerLabelStack.topAnchor.constraint(equalTo: headerNavStack.bottomAnchor, constant: 20),
      
      //Header of fields
      headerSectionFormLabel.topAnchor.constraint(equalTo: headerLabelStack.bottomAnchor, constant: 25),
      headerSectionFormLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
      
      //field Stack
      fieldsStack.topAnchor.constraint(equalTo: headerSectionFormLabel.bottomAnchor,constant: 8),
      fieldsStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
      fieldsStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15)
      
    ])
  }
  
  //MARK: - ACTIONS
  
  @objc func onCloseNavClientBtnTapped() {
    delegate?.onCloseNavBtnTapped()
  }
  
}
