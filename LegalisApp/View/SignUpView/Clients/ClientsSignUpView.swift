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
  
  //dividers
  let nameDivider = UIView()
  let documentNumberDivider = UIView()
  let phoneNumberDivider = UIView()
  let selectedSexDivider = UIView()
  let emailDivider = UIView()
  let passwordDivider = UIView()
  
  //left icons
  let iconNameTxtField = UIImage(systemName: "person.crop.square")
  let iconDocumentTxtField = UIImage(systemName: "person.text.rectangle.fill")
  let iconPhoneTxtField = UIImage(systemName: "iphone")
  let iconGenderTxtField = UIImage(named: "sexIcon")
  let iconEmailTxtField = UIImage(systemName: "envelope")
  let iconPasswordTxtField = UIImage(systemName: "key.viewfinder")
  
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
    Utilities.creatingImage(
      imageView: logoImage,
      image: UIImage(named: "logoHorizontal") ?? UIImage(),
      contentMode: .scaleAspectFit,
      clipsToBounds: true,
      tintColor: UIColor(
        red: 0,
        green: 0.1370561421,
        blue: 0.2949633002,
        alpha: 1),
      width: 113,
      height: 28)
   //113 w, 28 h
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
    Utilities.clientTextFieldStyle(
      nameTextField,
      placeholder: "Nombre completo",
      isSecureTextEntry: false,
      keyboardAppearance: .dark,
      clearButtonMode: .whileEditing,
      keyboardType: .alphabet,
      inputAccessoryView: nil,
      backgroundColor: nil,
      leftIcon: iconNameTxtField)
    
    //documentNumberTextField
    Utilities.clientTextFieldStyle(
      documentNumberTextField,
      placeholder: "Número de documento",
      isSecureTextEntry: false,
      keyboardAppearance: .dark,
      clearButtonMode: .whileEditing,
      keyboardType: .alphabet,
      inputAccessoryView: nil,
      backgroundColor: nil,
      leftIcon: iconDocumentTxtField)
    
    //phoneNumberTextField
    Utilities.clientTextFieldStyle(
      phoneNumberTextField,
      placeholder: "Número de celular",
      isSecureTextEntry: false,
      keyboardAppearance: .dark,
      clearButtonMode: .whileEditing,
      keyboardType: .alphabet,
      inputAccessoryView: nil,
      backgroundColor: nil,
      leftIcon: iconPhoneTxtField)
    
    //selectSexTextField
    Utilities.clientTextFieldStyle(
      selectSexTextField,
      placeholder: "seleccione sexo",
      isSecureTextEntry: false,
      keyboardAppearance: .dark,
      clearButtonMode: .whileEditing,
      keyboardType: .alphabet,
      inputAccessoryView: nil,
      backgroundColor: nil,
      leftIcon: iconGenderTxtField)
    
    //emailTextField
    Utilities.clientTextFieldStyle(
      emailTextField,
      placeholder: "ejemplo@legal.com",
      isSecureTextEntry: false,
      keyboardAppearance: .dark,
      clearButtonMode: .whileEditing,
      keyboardType: .alphabet,
      inputAccessoryView: nil,
      backgroundColor: nil,
      leftIcon: iconEmailTxtField)
    
    //passwordTextField
    Utilities.clientTextFieldStyle(
      passwordTextField,
      placeholder: "Contraseña",
      isSecureTextEntry: false,
      keyboardAppearance: .dark,
      clearButtonMode: .whileEditing,
      keyboardType: .alphabet,
      inputAccessoryView: nil,
      backgroundColor: nil,
      leftIcon: iconPasswordTxtField)
    
    //MARK: - Dividers
    Utilities.divider(nameDivider, backgroundColor: .systemGray6, height: 1.5)
    nameDivider.translatesAutoresizingMaskIntoConstraints = false
    Utilities.divider(documentNumberDivider, backgroundColor: .systemGray6, height: 1.5)
    documentNumberDivider.translatesAutoresizingMaskIntoConstraints = false
    Utilities.divider(phoneNumberDivider, backgroundColor: .systemGray6, height: 1.5)
    phoneNumberDivider.translatesAutoresizingMaskIntoConstraints = false
    Utilities.divider(selectedSexDivider, backgroundColor: .systemGray6, height: 1.5)
    selectedSexDivider.translatesAutoresizingMaskIntoConstraints = false
    Utilities.divider(emailDivider, backgroundColor: .systemGray6, height: 1.5)
    emailDivider.translatesAutoresizingMaskIntoConstraints = false
    Utilities.divider(passwordDivider, backgroundColor: .systemGray6, height: 1.5)
    passwordDivider.translatesAutoresizingMaskIntoConstraints = false
   
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
    
    //FIELDS STACKVIEWS
    
    let nameStack = UIStackView(arrangedSubviews: [
      nameTextField,
      nameDivider
    ])
    nameStack.axis = .vertical
    nameStack.alignment = .fill
    nameStack.translatesAutoresizingMaskIntoConstraints = false
    
    
    let docNumStack = UIStackView(arrangedSubviews: [
      documentNumberTextField,
      documentNumberDivider
    ])
    docNumStack.axis = .vertical
    docNumStack.alignment = .fill
    docNumStack.translatesAutoresizingMaskIntoConstraints = false
    
    let phoneNumStack = UIStackView(arrangedSubviews: [
      phoneNumberTextField,
      phoneNumberDivider
    ])
    phoneNumStack.axis = .vertical
    phoneNumStack.alignment = .fill
    phoneNumStack.translatesAutoresizingMaskIntoConstraints = false
    
    let genderStack = UIStackView(arrangedSubviews: [
      selectSexTextField,
      selectedSexDivider
    ])
    genderStack.axis = .vertical
    genderStack.alignment = .fill
    genderStack.translatesAutoresizingMaskIntoConstraints = false
    
    let emailStack = UIStackView(arrangedSubviews: [
      emailTextField,
      emailDivider
    ])
    emailStack.axis = .vertical
    emailStack.alignment = .fill
    emailStack.translatesAutoresizingMaskIntoConstraints = false
    
    let passwordStack = UIStackView(arrangedSubviews: [
    passwordTextField,
    passwordDivider
    ])
    passwordStack.axis = .vertical
    passwordStack.alignment = .fill
    passwordStack.translatesAutoresizingMaskIntoConstraints = false
 
    let fieldsGlobalStack = UIStackView(arrangedSubviews: [
      nameStack,
      docNumStack,
      phoneNumStack,
      genderStack,
      emailStack,
      passwordStack
    ])
    fieldsGlobalStack.axis = .vertical
    fieldsGlobalStack.distribution = .equalCentering
    fieldsGlobalStack.spacing = 0
    fieldsGlobalStack.backgroundColor = .white
    fieldsGlobalStack.layer.cornerRadius = 10

    //fieldsGlobalStack.isLayoutMarginsRelativeArrangement = true
    //fieldsGlobalStack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    fieldsGlobalStack.translatesAutoresizingMaskIntoConstraints = false

    addSubview(headerNavStack)
    addSubview(headerLabelStack)
    addSubview(headerSectionFormLabel)
    addSubview(fieldsGlobalStack)
    
    
  
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
      
      //fields global Stack
      fieldsGlobalStack.topAnchor.constraint(equalTo: headerSectionFormLabel.bottomAnchor,constant: 8),
      fieldsGlobalStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
      fieldsGlobalStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
      fieldsGlobalStack.heightAnchor.constraint(equalToConstant: 320)
    ])
  }
  
  //MARK: - ACTIONS
  
  @objc func onCloseNavClientBtnTapped() {
    delegate?.onCloseNavBtnTapped()
  }
  
}
