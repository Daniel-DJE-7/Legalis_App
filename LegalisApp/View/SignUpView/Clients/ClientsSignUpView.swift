//
//  ClientsSignUpView.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 2/6/26.
//

import UIKit

protocol ClientsSignUpViewDelegate: AnyObject {
  func onCloseNavBtnTapped()
  func onDoneNameBtnTapped()
  func onCancelNameBtnTapped()
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
  let idDocumentTextField = UITextField()
  let phoneNumberTextField = UITextField()
  let selectSexTextField = UITextField()
  let emailTextField = UITextField()
  let passwordTextField = UITextField()
  
  //dividers
  let nameDivider = UIView()
  let idDocumentDivider = UIView()
  let phoneNumberDivider = UIView()
  let SexDivider = UIView()
  let emailDivider = UIView()
  let passwordDivider = UIView()
  
  //left icons
  let iconNameTxtField = UIImageView()
  let iconDocumentTxtField = UIImageView()
  let iconPhoneTxtField = UIImageView()
  let iconGenderTxtField = UIImageView()
  let iconEmailTxtField = UIImageView()
  let iconPasswordTxtField = UIImageView()
  /*
   let iconNameTxtField = UIImage(systemName: "person.crop.square")
   let iconDocumentTxtField = UIImage(systemName: "person.text.rectangle.fill")
   let iconPhoneTxtField = UIImage(systemName: "iphone")
   let iconGenderTxtField = UIImage(named: "sexIcon")
   let iconEmailTxtField = UIImage(systemName: "envelope")
   let iconPasswordTxtField = UIImage(systemName: "key.viewfinder")
   */
  
  // toolbars for the keyboards
  let nameToolBar = UIToolbar()
  let idDocumentToolBar = UIToolbar()
  let phoneToolBar = UIToolbar()
  let sexToolBar = UIToolbar()
  let emailToolBar = UIToolbar()
  let passwordToolBar = UIToolbar()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpToolBarsForTextFields()
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
      keyboardType: .default,
      inputAccessoryView: nameToolBar,
      backgroundColor: nil,
      leftIcon: nil)
    
    //documentNumberTextField
    Utilities.clientTextFieldStyle(
      idDocumentTextField,
      placeholder: "Número de documento",
      isSecureTextEntry: false,
      keyboardAppearance: .dark,
      clearButtonMode: .whileEditing,
      keyboardType: .numberPad,
      inputAccessoryView: idDocumentToolBar,
      backgroundColor: nil,
      leftIcon: nil)
    
    //phoneNumberTextField
    Utilities.clientTextFieldStyle(
      phoneNumberTextField,
      placeholder: "Número de celular",
      isSecureTextEntry: false,
      keyboardAppearance: .dark,
      clearButtonMode: .whileEditing,
      keyboardType: .asciiCapableNumberPad,
      inputAccessoryView: phoneToolBar,
      backgroundColor: nil,
      leftIcon: nil)
    
    //selectSexTextField
    Utilities.clientTextFieldStyle(
      selectSexTextField,
      placeholder: "Seleccione sexo",
      isSecureTextEntry: false,
      keyboardAppearance: .dark,
      clearButtonMode: nil,
      keyboardType: nil,
      inputAccessoryView: nil,
      backgroundColor: nil,
      leftIcon: nil)
    
    //emailTextField
    Utilities.clientTextFieldStyle(
      emailTextField,
      placeholder: "ejemplo@legal.com",
      isSecureTextEntry: false,
      keyboardAppearance: .dark,
      clearButtonMode: .whileEditing,
      keyboardType: .emailAddress,
      inputAccessoryView: emailToolBar,
      backgroundColor: nil,
      leftIcon: nil)
    
    //passwordTextField
    Utilities.clientTextFieldStyle(
      passwordTextField,
      placeholder: "Contraseña",
      isSecureTextEntry: false,
      keyboardAppearance: .dark,
      clearButtonMode: .whileEditing,
      keyboardType: .default,
      inputAccessoryView: passwordToolBar,
      backgroundColor: nil,
      leftIcon: nil)
    
    //MARK: - ICON IMAGE OF TEXTFIELD
    
    //name icon txt field
    Utilities.creatingImage(
      imageView: iconNameTxtField,
      image: UIImage(
        systemName: "person.crop.square")?.withRenderingMode(.alwaysTemplate) ?? UIImage(),
      contentMode: .scaleAspectFit,
      clipsToBounds: true,
      tintColor: UIColor(
        red: 0.2939614058,
        green: 0.2977539897,
        blue: 0.314393878,
        alpha: 1),
      width: 20,
      height: 20)
   
    //document id icon textfield
    Utilities.creatingImage(
      imageView: iconDocumentTxtField,
      image: UIImage(
        systemName: "person.text.rectangle.fill")?.withRenderingMode(.alwaysTemplate) ?? UIImage(),
      contentMode: .scaleAspectFit,
      clipsToBounds: true,
      tintColor: UIColor(
        red: 0.2939614058,
        green: 0.2977539897,
        blue: 0.314393878,
        alpha: 1),
      width: 20,
      height: 20)
    
    //phone number icon txtfield
    Utilities.creatingImage(
      imageView: iconPhoneTxtField,
      image: UIImage(systemName: "iphone")?.withRenderingMode(.alwaysTemplate) ?? UIImage(),
      contentMode: .scaleAspectFit,
      clipsToBounds: true,
      tintColor: UIColor(
        red: 0.2939614058,
        green: 0.2977539897,
        blue: 0.314393878,
        alpha: 1),
      width: 20,
      height: 20)
    
    //gender icon txt field
    Utilities.creatingImage(imageView: iconGenderTxtField, image: UIImage(named: "sexIcon")?.withRenderingMode(.alwaysTemplate) ?? UIImage(), contentMode: .scaleAspectFit, clipsToBounds: true, tintColor: UIColor(red: 0.2939614058, green: 0.2977539897, blue: 0.314393878, alpha: 1), width: 20, height: 20)
    
    //email icon txtfield
    Utilities.creatingImage(imageView: iconEmailTxtField, image: UIImage(systemName: "envelope")?.withRenderingMode(.alwaysTemplate) ?? UIImage(), contentMode: .scaleAspectFit, clipsToBounds: true, tintColor: UIColor(red: 0.2939614058, green: 0.2977539897, blue: 0.314393878, alpha: 1), width: 20, height: 20)
    
    //password Icon txt field
    Utilities.creatingImage(imageView: iconPasswordTxtField, image: UIImage(systemName: "key.viewfinder")?.withRenderingMode(.alwaysTemplate) ?? UIImage(), contentMode: .scaleAspectFit, clipsToBounds: true, tintColor: UIColor(red: 0.2939614058, green: 0.2977539897, blue: 0.314393878, alpha: 1), width: 20, height: 20)

    
    //MARK: - Dividers
    Utilities.divider(nameDivider, backgroundColor: .systemGray6, height: 1.5)
    nameDivider.translatesAutoresizingMaskIntoConstraints = false
    
    Utilities.divider(idDocumentDivider, backgroundColor: .systemGray6, height: 1.5)
    idDocumentDivider.translatesAutoresizingMaskIntoConstraints = false
    
    Utilities.divider(phoneNumberDivider, backgroundColor: .systemGray6, height: 1.5)
    phoneNumberDivider.translatesAutoresizingMaskIntoConstraints = false
   
    Utilities.divider(SexDivider, backgroundColor: .systemGray6, height: 1.5)
    SexDivider.translatesAutoresizingMaskIntoConstraints = false
    
    Utilities.divider(emailDivider, backgroundColor: .systemGray6, height: 1.5)
    emailDivider.translatesAutoresizingMaskIntoConstraints = false
    
    Utilities.divider(passwordDivider, backgroundColor: .systemGray6, height: 1.5)
    passwordDivider.translatesAutoresizingMaskIntoConstraints = false
   
    
    
    
  }
  
  //MARK: ToolBars
  private func setUpToolBarsForTextFields() {
    //name txtField + toolbar
    Utilities.creatingToolBar(nameToolBar, target: self, doneAction: #selector(onDoneNametapped), cancelAction: #selector(onCancelNameTapped))
  }
  
  
  private func setUpUI() {
    //MARK: - HEADER NAV STACKVIEW
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
    
    //MARK: - HEADER LABEL STACKVIEW
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
    
    //MARK: - FIELDS STACKVIEWS
    
    //name config
    let nameStack = UIStackView(arrangedSubviews: [
      iconNameTxtField,
      nameTextField,
      
    ])
    nameStack.axis = .horizontal
    nameStack.alignment = .center
    nameStack.spacing = 12
    nameStack.isLayoutMarginsRelativeArrangement = true
    nameStack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    nameStack.translatesAutoresizingMaskIntoConstraints = false
   
    let nameStackDivider = UIStackView(arrangedSubviews: [
      nameStack,
      nameDivider
    ])
    nameStackDivider.axis = .vertical
    nameStackDivider.alignment = .fill
    nameStackDivider.translatesAutoresizingMaskIntoConstraints = false
    
    //Id document config
    let docNumStack = UIStackView(arrangedSubviews: [
      iconDocumentTxtField,
      idDocumentTextField,
     
    ])
    docNumStack.axis = .horizontal
    docNumStack.alignment = .center
    docNumStack.spacing = 12
    docNumStack.isLayoutMarginsRelativeArrangement = true
    docNumStack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    docNumStack.translatesAutoresizingMaskIntoConstraints = false
    
    let documentStackDivider = UIStackView(arrangedSubviews: [
      docNumStack,
      idDocumentDivider
    ])
    documentStackDivider.axis = .vertical
    documentStackDivider.alignment = .fill
    documentStackDivider.translatesAutoresizingMaskIntoConstraints = false
    
    //phon number config
    let phoneNumStack = UIStackView(arrangedSubviews: [
      iconPhoneTxtField,
      phoneNumberTextField
    
    ])
    phoneNumStack.axis = .horizontal
    phoneNumStack.alignment = .center
    phoneNumStack.spacing = 12
    phoneNumStack.isLayoutMarginsRelativeArrangement = true
    phoneNumStack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    phoneNumStack.translatesAutoresizingMaskIntoConstraints = false
    
    
    let phoneStackDivider = UIStackView(arrangedSubviews: [
      phoneNumStack,
      phoneNumberDivider
    ])
    phoneStackDivider.axis = .vertical
    phoneStackDivider.alignment = .fill
    phoneStackDivider.translatesAutoresizingMaskIntoConstraints = false
    
    
    //gender tf config
    let genderStack = UIStackView(arrangedSubviews: [
      iconGenderTxtField,
      selectSexTextField
   
    ])
    genderStack.axis = .horizontal
    genderStack.alignment = .center
    genderStack.spacing = 12
    genderStack.isLayoutMarginsRelativeArrangement = true
    genderStack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    genderStack.translatesAutoresizingMaskIntoConstraints = false
    
    let genderStackDivider = UIStackView(arrangedSubviews: [
      genderStack,
      SexDivider
    ])
    genderStackDivider.axis = .vertical
    genderStackDivider.alignment = .fill
    genderStackDivider.translatesAutoresizingMaskIntoConstraints = false
    
    //Email config
    let emailStack = UIStackView(arrangedSubviews: [
      iconEmailTxtField,
      emailTextField
     
    ])
    emailStack.axis = .horizontal
    emailStack.alignment = .center
    emailStack.spacing = 12
    emailStack.isLayoutMarginsRelativeArrangement = true
    emailStack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    emailStack.translatesAutoresizingMaskIntoConstraints = false
    
    let emailStackDivider = UIStackView(arrangedSubviews: [
      emailStack,
      emailDivider
    ])
    emailStackDivider.axis = .vertical
    emailStackDivider.alignment = .fill
    emailStackDivider.translatesAutoresizingMaskIntoConstraints = false
    
    //password config
    let passwordStack = UIStackView(arrangedSubviews: [
      iconPasswordTxtField,
      passwordTextField
   
    ])
    passwordStack.axis = .horizontal
    passwordStack.alignment = .center
    passwordStack.spacing = 12
    passwordStack.isLayoutMarginsRelativeArrangement = true
    passwordStack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    passwordStack.translatesAutoresizingMaskIntoConstraints = false
 
    let passwordStackDivider = UIStackView(arrangedSubviews: [
      passwordStack,
      passwordDivider
    ])
    passwordStackDivider.axis = .vertical
    passwordStackDivider.alignment = .fill
    passwordStackDivider.translatesAutoresizingMaskIntoConstraints = false
    
    
    //global stack of textFields
    let fieldsGlobalStack = UIStackView(arrangedSubviews: [
      nameStackDivider,
      documentStackDivider,
      phoneStackDivider,
      genderStackDivider,
      emailStackDivider,
      passwordStackDivider
    ])
  
    fieldsGlobalStack.axis = .vertical
    fieldsGlobalStack.distribution = .fillEqually
    fieldsGlobalStack.spacing = 0
    fieldsGlobalStack.backgroundColor = .white
    fieldsGlobalStack.layer.cornerRadius = 10
    fieldsGlobalStack.clipsToBounds = true
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
  //NAV CLOSE BTN ACTION
  @objc func onCloseNavClientBtnTapped() {
    delegate?.onCloseNavBtnTapped()
  }
  
  //NAME TOOLBAR ACTIONS
  @objc func onDoneNametapped(){
    delegate?.onDoneNameBtnTapped()
  }
  
  @objc func onCancelNameTapped() {
    delegate?.onCancelNameBtnTapped()
  }
  
}
