//
//  CredentialsValidator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 11/11/26.
//

import UIKit

class CredentialsValidator {
  
  //MARK: - Validation of credentials
  static func validateCredentials(credentials: ExtractingCredentialsModel) -> TextFieldValidation {
    
    let validateName = RegexParametersValidation.isValidName(credentials.name)
    let validateEmail = RegexParametersValidation.isValidEmail(credentials.email)
    let validatePassword = RegexParametersValidation.isPasswordValid(credentials.password)
    let validateNumberOfDocument = RegexParametersValidation.isValidNumber(credentials.numberOfDocument)
    let validateCellphoneNumber = RegexParametersValidation.isValidNumber(credentials.mobileNumber)
    
    //MARK: - Empty fields
    
    if credentials.name.isEmpty || credentials.numberOfDocument.isEmpty || credentials.mobileNumber.isEmpty || credentials.email.isEmpty || credentials.password.isEmpty {
      return .emptyFields
    }
    
    //MARK: - Name validation
    if !validateName {
      return .invalidName
    }
    
    //MARK: - Email validation
    
    if !validateEmail {
      return .invalidEmail
    }
    
    //MARK: - Password validation
    if !validatePassword {
      return .invalidPassword
    }
    
    //MARK: - Number of document validation
    if !validateNumberOfDocument {
      return .invalidNumberOfDocument
    }
    
    //MARK: - cellphone number validation
    if !validateCellphoneNumber {
      return .invalidNumberOfCellPhone
    }
    
    return .success
  }
  
}
