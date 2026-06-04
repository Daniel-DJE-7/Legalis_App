//
//  Utilities.swift
//  LegalisApp
//
//  Created by Memo Figueredo on 9/5/26.
//

import Foundation
import UIKit

class Utilities {
  
  //MARK: - func of textFields' styles
  static func styleTextField(_ textField: UITextField) {
    //removing borders
    textField.borderStyle = .none
    
    //creating bottom line
    let bottomLine = UIView()
    bottomLine.backgroundColor = #colorLiteral(red: 0.9332712293, green: 0.9329634309, blue: 0.9537363648, alpha: 1)
    bottomLine.translatesAutoresizingMaskIntoConstraints = false
    textField.translatesAutoresizingMaskIntoConstraints = false
    //agregamos bottomLine al textField
    textField.addSubview(bottomLine)
    
    //Constraints
    NSLayoutConstraint.activate([
      textField.heightAnchor.constraint(equalToConstant: 55),
      
      //linea
      bottomLine.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
      bottomLine.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
      bottomLine.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
      bottomLine.heightAnchor.constraint(equalToConstant: 1.5)//grosor de línea
    ])
  }
  
  
  //MARK: - customButton for PickerViews ToolBar
  static func createBtnForThePickerView(title: String?,
                                        image: UIImage?,
                                        target: Any?,
                                        action: Selector,
                                        color: UIColor) -> UIBarButtonItem {
    
    var config = UIButton.Configuration.plain()
    config.image = image
    config.image?.withTintColor(color)
    config.baseForegroundColor = color
    //config.baseBackgroundColor = color
    
    
    let button = UIButton(configuration: config)
    //button.backgroundColor = color
    button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    button.clipsToBounds = true
    //button.backgroundColor = #colorLiteral(red: 0.00586497318, green: 0.1180472597, blue: 0.2551576495, alpha: 1)
    button.setTitle(title, for: .normal)
    button.addTarget(target, action: action, for: .touchUpInside)
    
    return UIBarButtonItem(customView: button)
  }
  
  
  //MARK: - Custom toolBar
  static func creatingToolBar(_ toolBar: UIToolbar,
                              target: Any?,
                              doneAction: Selector,
                              cancelAction: Selector) {
    
    toolBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
    
    
    let doneBtn = createBtnForThePickerView(title: "Hecho", image: nil, target: target, action: doneAction, color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
    let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelBtn = createBtnForThePickerView(title: "Cancelar", image: nil, target: target, action: cancelAction, color: .systemPink)
    
    toolBar.setItems([cancelBtn, spaceBtn, doneBtn], animated: false)
    toolBar.sizeToFit()
    
  }
  //#colorLiteral(red: 0.003979303874, green: 0.137050271, blue: 0.2949559987, alpha: 1)
  
  //MARK: - button style
  static func customButtonStyle(_ button: UIButton,
                                appearance: UIButton.Configuration?,
                                title: String,
                                image: UIImage?,
                                imagePlacement: NSDirectionalRectEdge?,
                                imagePadding: CGFloat?,
                                cornerRadius: CGFloat,
                                backgroundColor: UIColor,
                                baseForeground: UIColor,
                                width: CGFloat,
                                height: CGFloat,
                                target: Any?,
                                action: Selector) {
   
    button.configuration = appearance
    button.configuration?.title = title
    button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
    button.titleLabel?.font = UIFont(name: "Inter", size: 17)
    button.configuration?.image = image
    button.configuration?.imagePlacement = imagePlacement ?? .leading
    button.configuration?.imagePadding = imagePadding ?? 0
    button.layer.cornerRadius = cornerRadius
    button.backgroundColor = backgroundColor
    button.configuration?.baseForegroundColor = baseForeground
    button.addTarget(target, action: action, for: .touchUpInside)
    button.widthAnchor.constraint(equalToConstant: width).isActive = true
    button.heightAnchor.constraint(equalToConstant: height).isActive = true
    
    button.translatesAutoresizingMaskIntoConstraints = false
  }
  
  //MARK: - HTML TextView
  static func creatingHTMLTextView(_ textView: UITextView) {
    textView.isEditable = false
    textView.isSelectable = true
    textView.isScrollEnabled = false
    textView.backgroundColor = .clear
    textView.textContainerInset = .zero
    textView.textContainer.lineFragmentPadding = 0
    textView.textAlignment = .center
    textView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  //MARK: - Validation format for the name TextField
  static func isValidName(_ name: String) -> Bool {
    let nameRegex = "^[A-Za-z ]{5,100}$"
    let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
    return namePredicate.evaluate(with: name)
  }
  
  //MARK: - Validation format for the password TextField
  static func isPasswordValid(_ password: String) -> Bool {
    let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$#!%*?&_\\-]).{8,}$"
    
    let passwordPredicate = NSPredicate(
      format: "SELF MATCHES %@",
      passwordRegex
    )
    
    return passwordPredicate.evaluate(with: password)
  }
  
  //MARK: - Validation format for the email textfield
  static func isValidEmail(_ email: String) -> Bool {
    
    let emailRegex = "^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}(\\.[a-z]{2,})?$"
    
    let emailPredicate = NSPredicate(format: "SELF MATCHES[C] %@", emailRegex)
    
    return emailPredicate.evaluate(with: email)
  }
  
  //MARK: - Validation format for the numbers' textfield (doc and phone)
  static func isValidNumber(_ number: String) -> Bool {
    let numberRegex = "^[0-9]{10,20}$"//o -> "\\d{10,20}$"
   
    let numberPredicate = NSPredicate(format: "SELF MATCHES[C] %@", numberRegex)
    
    return numberPredicate.evaluate(with: number)
  }
  
  // MARK: - Alerts
  static func creatingAlerts(
    style: UIAlertAction.Style,
    titleAction: String?,
    titleAlert: String?,
    message: String?,
    preferredStyle: UIAlertController.Style) -> UIAlertController {
    
      let alert = UIAlertController(
        title: titleAlert,
        message: message,
        preferredStyle: preferredStyle)
      
      let action =  UIAlertAction(
        title: titleAction,
        style: style)
      
      action.setValue(
        UIColor.systemPink,
        forKey: "titleTextColor")
      
      alert.addAction(action)
     
      return alert

  }
  
  static func creatingImage(imageView: UIImageView,
                                image: UIImage,
                                contentMode: UIView.ContentMode,
                                clipsToBounds: Bool,
                                tintColor: UIColor?,
                                width: CGFloat,
                                height: CGFloat) {
    imageView.image = image
    imageView.contentMode = contentMode
    imageView.tintColor = tintColor
    imageView.clipsToBounds = clipsToBounds
    imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  static func navBarBtn(_ button: UIButton,
                        appearance: UIButton.Configuration?,
                        image: UIImage?,
                        baseforegroundColor: UIColor?,
                        action: Selector,
                        target: Any?
                        ) {
    
    button.configuration = appearance
    button.configuration?.baseForegroundColor = baseforegroundColor
    button.setImage(image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)), for: .normal)
    button.addTarget(target, action: action, for: .touchUpInside)
    
    button.translatesAutoresizingMaskIntoConstraints = false
  }
  
  //Clients view TextField + left Icon
  static func clientTextFieldStyle(_ textField: UITextField,
                                   placeholder: String,
                                   isSecureTextEntry: Bool,
                                   keyboardAppearance: UIKeyboardAppearance,
                                   clearButtonMode: UITextField.ViewMode,
                                   keyboardType: UIKeyboardType,
                                   inputAccessoryView: UIView?,
                                   backgroundColor: UIColor?,
                                   leftIcon: UIImage?) {
    
    textField.borderStyle = .none
    textField.placeholder = placeholder
    textField.isSecureTextEntry = isSecureTextEntry
    textField.keyboardAppearance = keyboardAppearance
    textField.clearButtonMode = clearButtonMode
    textField.keyboardType = keyboardType
    textField.inputAccessoryView = inputAccessoryView
    textField.backgroundColor = backgroundColor
    textField.translatesAutoresizingMaskIntoConstraints = false
   
    //container to contain the left icon
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 26))
    let leftIcon = UIImageView(image: leftIcon?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)))
    leftIcon.tintColor = #colorLiteral(red: 0.2939614058, green: 0.2977539897, blue: 0.314393878, alpha: 1)
    leftIcon.frame = CGRect(x: 16, y: 2, width: 20, height: 20)
    
    
    container.addSubview(leftIcon)
    textField.leftView = container//added de container an img to txtfield
    textField.leftViewMode = .always
    //UIImageView(image: "", highlightedImage: "")
    
    NSLayoutConstraint.activate([
      textField.heightAnchor.constraint(equalToConstant: 48),
      //textField.widthAnchor.constraint(equalToConstant: 245)
      
    ])
  }
  
  static func divider(_ divider: UIView,
                      backgroundColor: UIColor,
                      height: CGFloat) {
   
    divider.backgroundColor = backgroundColor
    divider.heightAnchor.constraint(equalToConstant: height).isActive = true
    divider.translatesAutoresizingMaskIntoConstraints = false
  }
  
}

