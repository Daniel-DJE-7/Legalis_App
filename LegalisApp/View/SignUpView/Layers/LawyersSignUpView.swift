//
//  LawyersSignUp.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 5/5/26.
//

import UIKit

protocol LawyersSignUpViewDelegate: AnyObject {
 
  //name field
  func onDoneNameBtnPressed()
  func onCancelNameBtnPressed()
  
  //document's number field
  func onDoneDocumentBtnTapped()
  func onCancelDocumentBtnTapped()
  
  //phone number field
  func onDonePhoneNumberBtnTapped()
  func onCancelPhoneNumberBtnTapped()
  
  //phone email field
  func onDoneEmailBtnTapped()
  func onCancelEmailBtnTapped()
  
  //phone password field
  func onDonePasswordBtnTapped()
  func onCancelPasswordBtnTapped()
  
  //Type of practice
  func onDoneBtnTypeOfPracticePressed()
  func onCancelBtnTypeOfPracticePressed()
  
  //SignUpBtn
  func onSignUpBtnTapped()
}

class LawyersSignUpView: UIView {

  weak var delegate: LawyersSignUpViewDelegate?
  
  var fontFamily: String = "Inter"
  var fontSize: CGFloat = 12
  
  let fields: [RegisterModel] = [
    RegisterModel(leftImage: UIImage(systemName: "person"), placeholder: "Nombre Completo", rightImage: nil),
    RegisterModel(leftImage: UIImage(named: "id_card"), placeholder: "Número de documento", rightImage: nil),
    RegisterModel(leftImage: UIImage(systemName: "iphone"), placeholder: "Celular", rightImage: nil),
    RegisterModel(leftImage: UIImage(named: "email"), placeholder: "Correo", rightImage: nil),
    RegisterModel(leftImage: UIImage(systemName: "key.fill"), placeholder: "Contraseña", rightImage: nil),
    RegisterModel(leftImage: UIImage(named: "sexIcon"), placeholder: "Seleccione sexo", rightImage: UIImage(systemName: "chevron.down")),
    RegisterModel(leftImage: UIImage(named: "work_work_symbol"), placeholder: "Independiente o Dependiente", rightImage: UIImage(systemName: "chevron.down"))
  ]
  
  var textFields: [UITextField] = []
  
  var onDoneSelectingSexTapped: (() -> Void)?
  var onCancelSelectingSexTapped: (() -> Void)?
  var onCloseNavBtnTapped: (() -> Void)?
  
  //MARK: - PickerViews
  public let sexPickerView = UIPickerView()
  public let practiceTypePickerView = UIPickerView()
  
  
  
  //MARK: -UI NAV HEADER ELEMENTS
  public let imageLogo: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: "logoHorizontal")
    image.contentMode = .scaleAspectFit
    image.widthAnchor.constraint(equalToConstant: 113).isActive = true
    image.heightAnchor.constraint(equalToConstant: 28).isActive = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  lazy var closeButton: UIButton = {
    var config = UIButton.Configuration.plain()
    config.image = UIImage(named: "closeSymbol")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 18, weight: .medium))
    config.baseForegroundColor = #colorLiteral(red: 0, green: 0.1370561421, blue: 0.2949633002, alpha: 1)
    
    let button = UIButton(configuration: config)
    //action
    button.addAction(UIAction { [weak self] _ in
      self?.onCloseNavBtnTapped? ()
    }, for: .touchUpInside)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  
  //MARK: - UI HEADER ELEMENTS
  private let registerLabel: UILabel = {
    let label = UILabel()
    label.text = "Registro de Abogado"
    label.textAlignment = .left
    label.textColor = .black
    label.font = UIFont(name: "Inter", size: 34)
    label.font = .systemFont(ofSize: 34, weight: .bold)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let messageLabel: UILabel = {
    let label = UILabel()
    label.text = "Crea tu perfil profesional para unirte a la red \njurídica más prestigiosa"
    label.textColor = #colorLiteral(red: 0.3175835013, green: 0.3172684908, blue: 0.3380323052, alpha: 1)
    label.textAlignment = .left
    label.font = UIFont(name: "Inter", size: 15)
    label.font = .systemFont(ofSize: 15, weight: .regular)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //MARK: - UI TEXTFIELDS ELEMENTS

  //textFields Stack
  private let textFieldsStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 0
    stack.distribution = .fill
    stack.backgroundColor = .white
    stack.layer.cornerRadius = 10
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  //MARK: - TOOLBARS FOR PICKER VIEWS
  
  lazy var toolBarForName = UIToolbar()
  lazy var toolBarForDocument = UIToolbar()
  lazy var toolbarPhoneNumber = UIToolbar()
  lazy var toolbarEmail = UIToolbar()
  lazy var toolbarPassword = UIToolbar()
  
  lazy var toolBarForSelectSex: UIToolbar = {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    let doneSixBtn = Utilities.createBtnForThePickerView(title: nil, image: UIImage(systemName: "checkmark.square.fill"), target: self, action: #selector(doneSelectingSexCheckBtnTapped), color: #colorLiteral(red: 0.003979303874, green: 0.137050271, blue: 0.2949559987, alpha: 1))
    let spaceSixBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelSixBtn = Utilities.createBtnForThePickerView(title: nil, image: UIImage(systemName: "clear.fill"), target: self, action: #selector(oncancelSelectingSexClearBtnTapped), color: #colorLiteral(red: 0.7241197066, green: 0.1285783471, blue: 0, alpha: 1))
    toolbar.setItems([cancelSixBtn, spaceSixBtn, doneSixBtn], animated: false)
    toolbar.sizeToFit()
    
    return toolbar
  }()
  
  
  lazy var toolBarForTypeOfPractice: UIToolbar = {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    let doneSixBtn = Utilities.createBtnForThePickerView(title: "Hecho", image: nil, target: self, action: #selector(onDoneTypeOfPracticePressed), color: #colorLiteral(red: 0.003979303874, green: 0.137050271, blue: 0.2949559987, alpha: 1))
    let spaceSixBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelSixBtn = Utilities.createBtnForThePickerView(title: "Cancelar", image: nil, target: self, action: #selector(onCancelTypeOfPracticePressed), color: #colorLiteral(red: 0.7241197066, green: 0.1285783471, blue: 0, alpha: 1))
    toolbar.setItems([cancelSixBtn, spaceSixBtn, doneSixBtn], animated: false)
    toolbar.sizeToFit()
    
    return toolbar
  }()
  
  let color: UIColor = #colorLiteral(red: 0.9724870324, green: 0.9721793532, blue: 0.9929525256, alpha: 1)
  
  //MARK: - HTML TEXT VIEW
  let htmlTextView = UITextView()
  
  //MARK: - signUp button
  
  let signUpButton = UIButton()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUptoolbarsForKeyboardsInfields()
    setUpFields()
    setUpHTMLTextView()
    setUpSingUpBtn()
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Setting up the fields by index
  func setUpFields() {
    
    fields.enumerated().forEach { index, field in
      //creating icon
      let leftIcon = UIImageView(image: field.leftImage?.withRenderingMode(.alwaysTemplate))
      leftIcon.tintColor = #colorLiteral(red: 0.2939614058, green: 0.2977539897, blue: 0.314393878, alpha: 1)
      leftIcon.contentMode = .scaleAspectFit
      leftIcon.clipsToBounds = true
      leftIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
      leftIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
      leftIcon.translatesAutoresizingMaskIntoConstraints = false

      //creating and setting up the texfields
      let txtField = UITextField()
      txtField.placeholder = field.placeholder
      txtField.translatesAutoresizingMaskIntoConstraints = false
      Utilities.styleTextField(txtField)//agreagmos estilo utilities
      
      
      switch index {
      case 0:
        
        txtField.inputAccessoryView = toolBarForName
      case 1:
       
        txtField.inputAccessoryView = toolBarForDocument
      case 2:
        
        txtField.inputAccessoryView = toolbarPhoneNumber
      case 3:
        
        txtField.inputAccessoryView = toolbarEmail
      case 4:
       
        txtField.inputAccessoryView = toolbarPassword
      default:
        txtField.inputAccessoryView = .none
      }
      
      //setting the number's keyboard for txtField at index 1 and 2
      if index == 1 || index == 2 {
        txtField.keyboardType = .numberPad
        //txtField.keyboardAppearance = .dark
      }
      
      if index == 3 {
        txtField.keyboardType = .emailAddress
      }
      
      //setting secure text entry to the passwordTextfield
      if index == 4 {
        txtField.isSecureTextEntry = true
      }
      
      if [0,1,2,3,4].contains(index) {
        txtField.clearButtonMode = .whileEditing
        txtField.keyboardAppearance = .dark
      }
      
      //adding the pickerView to the textfield at index 5 and 6
      if index == 5 {
        txtField.tintColor = .clear//hide the cursor of the textfield
        txtField.inputView = sexPickerView
        txtField.inputAccessoryView = toolBarForSelectSex
      }
      
      if index == 6 {
        txtField.tintColor = .clear//hide the cursor of the textfield
        txtField.inputView = practiceTypePickerView
        txtField.inputAccessoryView = toolBarForTypeOfPractice
      }
      
      //adding the txtfield to the array of textfield
      textFields.append(txtField)
      
      //MARK: - Configuring right button for the pickerView
      var configRightBtn = UIButton.Configuration.plain()
      configRightBtn.baseForegroundColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
      
      let rightButton = UIButton(configuration: configRightBtn)
      
      if let image = field.rightImage?.withRenderingMode(.alwaysTemplate) {
        rightButton.setImage(image, for: .normal)
      }
      
      rightButton.imageView?.tintColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
      rightButton.imageView?.contentMode = .scaleAspectFit
      rightButton.imageView?.clipsToBounds = true
      rightButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
      rightButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
      rightButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
      rightButton.translatesAutoresizingMaskIntoConstraints = false
      
      
      if index == 5 || index == 6 {
        rightButton.addAction(UIAction(handler: { _ in
          txtField.becomeFirstResponder()
        }), for: .touchUpInside)
      }
      
      //stack icon + placeholder
      let iPStack = UIStackView(arrangedSubviews: [leftIcon, txtField, rightButton])
      iPStack.axis = .horizontal
      iPStack.spacing = 5
      iPStack.alignment = .center
      iPStack.isLayoutMarginsRelativeArrangement = true
      iPStack.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 20)
      iPStack.translatesAutoresizingMaskIntoConstraints = false

      //añadimos la IPStack a la textFieldsStack (vertical)
      textFieldsStack.addArrangedSubview(iPStack)
    }
  }
  
  
  private func setUptoolbarsForKeyboardsInfields() {
    
    //MARK: - name toolbar
   Utilities.creatingToolBar(toolBarForName, target: self, doneAction: #selector(onDoneNamePressed), cancelAction: #selector(onCancelNamePressed))
    
    Utilities.creatingToolBar(toolBarForDocument, target: self, doneAction: #selector(onDoneDocumentTapped), cancelAction: #selector(onCancelDocumentTapped))
    
    Utilities.creatingToolBar(toolbarPhoneNumber, target: self, doneAction: #selector(onDonePhoneNumberTapped), cancelAction: #selector(onCancelPhoneNumberTapped))
    
    Utilities.creatingToolBar(toolbarEmail, target: self, doneAction: #selector(onDoneEmailTapped), cancelAction: #selector(onCancelEmailTapped))
    
    Utilities.creatingToolBar(toolbarPassword, target: self, doneAction: #selector(onDonePasswordTapped), cancelAction: #selector(onCancelPasswordTapped))
    
  }
  
  func setUpHTMLTextView() {
    Utilities.creatingHTMLTextView(htmlTextView)
  }
  
  func setUpSingUpBtn() {
    
    Utilities.customButtonStyle(signUpButton, appearance: .plain(), title: "Registrarse", image: nil, imagePlacement: nil, imagePadding: nil, cornerRadius: 10, backgroundColor: #colorLiteral(red: 0.003979303874, green: 0.137050271, blue: 0.2949559987, alpha: 1), baseForeground: .white, width: 342, height: 54, target: self, action: #selector(onSignUpTapped))
  }
  
  
  func setUpUI() {
    
    //NavStack (logo + closeButton)
    let navStack = UIStackView(arrangedSubviews: [
      imageLogo,
      closeButton
    ])
    navStack.axis = .horizontal
    navStack.distribution = .equalSpacing
    navStack.alignment = .center
    navStack.backgroundColor = .white
    navStack.translatesAutoresizingMaskIntoConstraints = false
    //activamos margenes internos de la stack
    navStack.isLayoutMarginsRelativeArrangement = true
    //definimos espacio de las vistas de la stack
    navStack.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
    
    // header label
    let headerStack = UIStackView(arrangedSubviews: [
      registerLabel,
      messageLabel
    ])
    headerStack.axis = .vertical
    headerStack.alignment = .leading
    headerStack.distribution = .fillEqually
    headerStack.spacing = 5
    headerStack.translatesAutoresizingMaskIntoConstraints = false
    headerStack.isLayoutMarginsRelativeArrangement = true
    headerStack.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    
    
    //TextFields StackView
    addSubview(navStack)
    addSubview(headerStack)
    addSubview(textFieldsStack)
    addSubview(htmlTextView)
    addSubview(signUpButton)
     
    
    NSLayoutConstraint.activate([
      //MARK: - nav header
      navStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      navStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      navStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      navStack.heightAnchor.constraint(equalToConstant: 56),
      
      //header stack
      headerStack.topAnchor.constraint(equalTo: navStack.bottomAnchor, constant:20),
      
      //MARK: - TextFields Stack
      textFieldsStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 30),
      textFieldsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      textFieldsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      
      //MARK: - terms and privacy politics TextView
      htmlTextView.topAnchor.constraint(equalTo: textFieldsStack.bottomAnchor, constant: 20),
      htmlTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      htmlTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      
      //MARK: SignUp button
      signUpButton.topAnchor.constraint(equalTo: htmlTextView.bottomAnchor, constant: 15),
     // signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      //signUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
    
  }
  
  
  //MARK: - ACTIONS FOR BUTTONS
  
  //Close NavBar Header Btn
  func closeNavHeaderBtnTapped() {
    onCloseNavBtnTapped?()
  }
  
  //name field
  @objc private func onDoneNamePressed() {
    delegate?.onDoneNameBtnPressed()
    print("working")
  }
  
  @objc private func onCancelNamePressed() {
    delegate?.onCancelNameBtnPressed()
    print("cancel tapped")
  }
  
  //document's number field
  @objc private func onDoneDocumentTapped() {
    delegate?.onDoneDocumentBtnTapped()
  }
  
  @objc private func onCancelDocumentTapped() {
    delegate?.onCancelDocumentBtnTapped()
  }
  
  //phone number field
  @objc private func onDonePhoneNumberTapped() {
    delegate?.onDonePhoneNumberBtnTapped()
  }
  
  @objc private func onCancelPhoneNumberTapped() {
    delegate?.onCancelPhoneNumberBtnTapped()
  }
  
  //email field
  @objc private func onDoneEmailTapped() {
    delegate?.onDoneEmailBtnTapped()
  }
  
  @objc private func onCancelEmailTapped() {
    delegate?.onCancelEmailBtnTapped()
  }
  
  //password field
  @objc private func onDonePasswordTapped() {
    delegate?.onDonePasswordBtnTapped()
  }
  
  @objc private func onCancelPasswordTapped() {
    delegate?.onCancelPasswordBtnTapped()
  }
  
  //Selecting gender
  @objc func doneSelectingSexCheckBtnTapped() {
    onDoneSelectingSexTapped?()
  }
  
  @objc func oncancelSelectingSexClearBtnTapped() {
    onCancelSelectingSexTapped?()
  }
  
  //selecting type of practice
  @objc func onDoneTypeOfPracticePressed() {
    delegate?.onDoneBtnTypeOfPracticePressed()
  }
  
  @objc func onCancelTypeOfPracticePressed() {
    delegate?.onCancelBtnTypeOfPracticePressed()
  }
  
  //MARK: - SignUp btn
 @objc private func onSignUpTapped() {
   delegate?.onSignUpBtnTapped()
  }
  
  //MARK: - method to convert my html into a String
  func sethtmlText(_ htmlString: String, fontFamily: String, size: CGFloat) {
    self.fontFamily = fontFamily
    self.fontSize = size
    
    //convierte mi texto html en data binario "0010110",
    guard let data = htmlString.data(using: .utf8) else { return }
    //le decimos a swift como interpretar los datos, se dice: esto es texto html
    let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
      .documentType: NSAttributedString.DocumentType.html,
      .characterEncoding: String.Encoding.utf8.rawValue//el texto usa codigicacion utf8
    ]
    
    //toma el html y le aplica estilos
    if let baseAttributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
      let muttableAttributed = NSMutableAttributedString(attributedString: baseAttributedString)
      
      muttableAttributed.applyCustomFont(family: fontFamily, size: size)
      
      //mostramos el resultado en pantalla
      self.htmlTextView.attributedText = muttableAttributed
    }
  }
}
