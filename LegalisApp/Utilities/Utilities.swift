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
    //bottomLine.frame = CGRect(x: 0, y: 0, width: 306, height: Int(Double(0.5)))
    //agregamos bottomLine al textField
    textField.addSubview(bottomLine)
    
    //Constraints
    NSLayoutConstraint.activate([
      textField.heightAnchor.constraint(equalToConstant: 55),
      
      //linea
      bottomLine.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
      bottomLine.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
      bottomLine.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
      bottomLine.heightAnchor.constraint(equalToConstant: 1.0)//grosor de línea
    ])
  }
  
  
  //MARK: - customButton for PickerViews ToolBar
  static func createBtnForThePickerView(title: String?, image: UIImage?, target: Any?, action: Selector, color: UIColor) -> UIBarButtonItem {
    var config = UIButton.Configuration.plain()
    config.image = image
    config.image?.withTintColor(color)
    config.baseForegroundColor = color
    //config.baseBackgroundColor = color
    
    
    let button = UIButton(configuration: config)
    //button.backgroundColor = color
    button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    //button.layer.cornerRadius = 10
    button.clipsToBounds = true
    //button.backgroundColor = #colorLiteral(red: 0.00586497318, green: 0.1180472597, blue: 0.2551576495, alpha: 1)
    button.setTitle(title, for: .normal)
    button.addTarget(target, action: action, for: .touchUpInside)
    
    return UIBarButtonItem(customView: button)
  }
  
  
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
  
  
  //MARK: - Validation format for the password TextField
  static func isPasswordValid(_ password: String) -> Bool {
    let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$#!%*?&]).{8,}$"
    
    let passwordPredicate = NSPredicate(
      format: "SELF MATCHES %@",
      passwordRegex
    )
    
    return passwordPredicate.evaluate(with: password)
  }
  
  
  
  
}
