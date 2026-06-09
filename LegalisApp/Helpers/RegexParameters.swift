//
//  RegexParameters.swift
//  LegalisApp
//
//  Created by Memo Figueredo on 9/6/26.
//

import UIKit

class RegexParameters {
  
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
  
}
