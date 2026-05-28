//
//  LawyersSignUp.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 5/5/26.
//

import UIKit

protocol LawyersSignUpViewDelegate: AnyObject {
  func onDoneBtnSixthIndexPressed()
  func onCancelBtnSixIndexPressed()
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
  
  var onDoneTapped: (() -> Void)?
  var onCancelTapped: (() -> Void)?
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
  
  lazy var toolBarForFiveIndex: UIToolbar = {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    let doneSixBtn = Utilities.createBtnForThePickerView(title: nil, image: UIImage(systemName: "checkmark.square.fill"), target: self, action: #selector(doneCheckBtnTapped), color: #colorLiteral(red: 0.003979303874, green: 0.137050271, blue: 0.2949559987, alpha: 1))
    let spaceSixBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelSixBtn = Utilities.createBtnForThePickerView(title: nil, image: UIImage(systemName: "clear.fill"), target: self, action: #selector(cancelClearBtnTapped), color: #colorLiteral(red: 0.7241197066, green: 0.1285783471, blue: 0, alpha: 1))
    toolbar.setItems([cancelSixBtn, spaceSixBtn, doneSixBtn], animated: false)
    toolbar.sizeToFit()
    
    return toolbar
  }()
  
  
  lazy var toolBarForSixIndex: UIToolbar = {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    let doneSixBtn = Utilities.createBtnForThePickerView(title: "Hecho", image: nil, target: self, action: #selector(onDonePressed), color: #colorLiteral(red: 0.003979303874, green: 0.137050271, blue: 0.2949559987, alpha: 1))
    let spaceSixBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelSixBtn = Utilities.createBtnForThePickerView(title: "Cancelar", image: nil, target: self, action: #selector(onCancelPressed), color: #colorLiteral(red: 0.7241197066, green: 0.1285783471, blue: 0, alpha: 1))
    toolbar.setItems([cancelSixBtn, spaceSixBtn, doneSixBtn], animated: false)
    toolbar.sizeToFit()
    
    return toolbar
  }()
  
  

  
  //MARK: - HTML TEXT VIEW
  let htmlTextView = UITextView()
  
  //MARK: - signUp button
  
  let signUpButton = UIButton()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
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
      
      
      //setting the number's keyboard for txtField at index 1 and 2
      if index == 1 || index == 2 {
        txtField.keyboardType = .phonePad
        txtField.keyboardAppearance = .dark
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
      }
      
      //adding the pickerView to the textfield at index 5 and 6
      if index == 5 {
        txtField.tintColor = .clear//hide the cursor of the textfield
        txtField.inputView = sexPickerView
        txtField.inputAccessoryView = toolBarForFiveIndex
      }
      
      if index == 6 {
        txtField.tintColor = .clear//hide the cursor of the textfield
        txtField.inputView = practiceTypePickerView
        txtField.inputAccessoryView = toolBarForSixIndex
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
  
  func closeNavHeaderBtnTapped() {
    onCloseNavBtnTapped?()
  }
  
  @objc func doneCheckBtnTapped() {
    onDoneTapped?()
  }
  
  @objc func cancelClearBtnTapped() {
    onCancelTapped?()
  }
  
  @objc func onDonePressed() {
    print("done pressed")
    delegate?.onDoneBtnSixthIndexPressed()
  }
  
  @objc func onCancelPressed() {
    print("cancel pressed")
    delegate?.onCancelBtnSixIndexPressed()
  }
  
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
