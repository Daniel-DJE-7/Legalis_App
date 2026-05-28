//
//  LawyersSignUpViewController.swift
//  LegalisApp
//
//  Created by Memo Figueredo on 5/5/26.
//

import UIKit
import SafariServices

enum TextFieldValidation {
  case emptyFields
  case invalidName
  case invalidEmail
  case invalidPassword
  case invalidNumberOfDocument
  case invalidNumberOfCellPhone
  case success
}

class LawyersSignUpViewController: UIViewController {
    
  
  private let gendersOptions = ["Ninguno","Masculino", "Femenino"]
  private let practiceType = ["Ninguno","Independiente", "Bufete o Empresa"]
  let htmlText = """
                <div style="text-align: center;">
                    Al registrarte, aceptas nuestros <a href='https://legalis.com.co/terminos'>Términos de servicio</a> <br> y <a href='https:/legalis.com.co/privacidad'>Política de privacidad</a>.
                </div>
                """
  
  let lawyersSignUpView = LawyersSignUpView()
  
  override func loadView() {
    super.loadView()
    
    view = lawyersSignUpView
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .systemGray6
      
      
      configuringDelegatesAndDataSources()
      actionsTextFieldFiveToolBar()
      closeNavActionButton()
      setHTMLText()
    }

  //MARK: - Delegates & Data sources
  private func configuringDelegatesAndDataSources() {
    lawyersSignUpView.delegate = self
    
    //Pickers view
    lawyersSignUpView.sexPickerView.delegate = self
    lawyersSignUpView.sexPickerView.dataSource = self
    
    lawyersSignUpView.practiceTypePickerView.delegate = self
    lawyersSignUpView.practiceTypePickerView.dataSource = self
    
    // TextFields to block manual typing
    lawyersSignUpView.textFields[5].delegate = self
    lawyersSignUpView.textFields[6].delegate = self
    
    //html delegate
    lawyersSignUpView.htmlTextView.delegate = self
  }
    
    
  //MARK: - actionButton for close signUp view
  func closeNavActionButton() {
    lawyersSignUpView.onCloseNavBtnTapped = { [weak self] in
      self?.dismiss(animated: true)
    }
  }
  
  
  func setHTMLText() {
    lawyersSignUpView.sethtmlText(htmlText, fontFamily: "Inter", size: 12)
  }
  
  
  
  
}


//MARK: - delegates & data sources protocols' methods
extension LawyersSignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  //MARK: - DATA SOURCE
    //returns de columns that the pickerView should display
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  //Returns the numbers of rows that should be displayed in the columns
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == lawyersSignUpView.sexPickerView {
      return gendersOptions.count
    }
    return practiceType.count
  }
  
  //MARK: - DELEGATES
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //gendersOptions[row]
    if pickerView == lawyersSignUpView.sexPickerView {
      return gendersOptions[row]
    }
    return practiceType[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == lawyersSignUpView.sexPickerView {
      lawyersSignUpView.textFields[5].text = gendersOptions[row]
      
    }
    
    if pickerView == lawyersSignUpView.practiceTypePickerView {
      lawyersSignUpView.textFields[6].text = practiceType[row]
    }
  }
}


//MARK: - textField delegate
//method to prevent users to type in the textfield
extension LawyersSignUpViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return false
  }
}

//MARK: - TextView Delegate
extension LawyersSignUpViewController: UITextViewDelegate {
  
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    let safariVC = SFSafariViewController(url: URL)
    present(safariVC, animated: true)
    
    return false
  }
}

//MARK: - Actions for the toolbars in PickerViews
extension LawyersSignUpViewController: LawyersSignUpViewDelegate {
  
  func actionsTextFieldFiveToolBar() {
    
    lawyersSignUpView.onDoneTapped = { [weak self] in
      self?.lawyersSignUpView.textFields[5].endEditing(true)
    }
    
    lawyersSignUpView.onCancelTapped = { [weak self] in
      self?.lawyersSignUpView.textFields[5].text = nil
      self?.lawyersSignUpView.textFields[5].endEditing(true)
      
    }
  }
  
  //MARK: - Actions for the 6 pickerView
  func onDoneBtnSixthIndexPressed() {
    self.lawyersSignUpView.textFields[6].endEditing(true)
  }
  
  func onCancelBtnSixIndexPressed() {
    self.lawyersSignUpView.textFields[6].text = nil
    self.lawyersSignUpView.textFields[6].endEditing(true)
  }
 
  //MARK: - SignUp Btn
  func onSignUpBtnTapped() {
    //collectiong info of users
    //validation to push to homeViewController
      //validate that fields "name, document, mobile num, email, password are filled as obligation and they fulfill the format
        //validate that fields are not void
        //1) validate number of document is a number
        //2) validate mobile number is numbers
        //3) validate the email as test@test.com
        //4) validate the password as min 1 lowercase, 1 uppercase, one number, 1 special character, min 8 characters
      //validate optional field sex and typeOfpractice as optionals, there is not obligation to select them
    let credentialsExtracted = extractionOfCredentials()
    let credentialsValidation = validateCredentials(credentials: credentialsExtracted)
    
    switch credentialsValidation {
      case .emptyFields:
        print("empty fields")
      case .invalidName:
        print("Invalid name")
      case .invalidEmail:
        print("invalid email")
      case .invalidPassword:
        print("invalid password")
      case .invalidNumberOfDocument:
        print("invalid number of document")
      case .invalidNumberOfCellPhone:
        print("invalid mobile number")
      case.success:
        print("success")
      //push to homeviewcontroller
    }
  }
  
  //MARK: - Extracting credentials
  func extractionOfCredentials() -> ExtractingCredentialsModel {
    
    //collecting info of users
    let name = lawyersSignUpView.textFields[0].text ?? ""
    
    let documentNumber = lawyersSignUpView.textFields[1].text ?? ""
    let mobileNumber = lawyersSignUpView.textFields[2].text ?? ""
    let email = lawyersSignUpView.textFields[3].text ?? ""
        
    let password = lawyersSignUpView.textFields[4].text ?? ""
    
    let selectiongOfSex = lawyersSignUpView.sexPickerView.selectedRow(inComponent: 0)
    var sex: Sex? = nil
    
    
//    switch selectiongOfSex {
//    case 1:
//      sex = .male
//    case 2:
//      sex = .female
//    default:
//      sex = nil
//    }
    
    if selectiongOfSex == 0 {
      sex = nil
    } else if selectiongOfSex == 1 {
      sex = .male
    } else {
      sex = .female
    }
    
    let selectionOfpracticeType = lawyersSignUpView.practiceTypePickerView.selectedRow(inComponent: 0)
    
    var practiceType: PracticeType? = nil
    
    switch selectionOfpracticeType {
      case 0:
        practiceType = PracticeType.none
      case 1:
        practiceType = .independent
      case 2:
        practiceType = .employee
      default:
        practiceType = nil
    }
    
   return ExtractingCredentialsModel(name: name,
                                     numberOfDocument: documentNumber,
                                     mobileNumber: mobileNumber,
                                     email: email,
                                     password: password,
                                     sex: sex,
                                     practiceType: practiceType)
  }
  
  
  //MARK: - Validation of credentials
  func validateCredentials(credentials: ExtractingCredentialsModel) -> TextFieldValidation {
    
    let validateName = Utilities.isValidName(credentials.name)
    let validateEmail = Utilities.isValidEmail(credentials.email)
    let validatePassword = Utilities.isPasswordValid(credentials.password)
    let validateNumberOfDocument = Utilities.isValidNumber(credentials.numberOfDocument)
    let validateCellphoneNumber = Utilities.isValidNumber(credentials.mobileNumber)
    
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
