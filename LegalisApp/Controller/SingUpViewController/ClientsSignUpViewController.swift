//
//  ClientsSignUpViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 5/5/26.
//

import UIKit
import SafariServices

class ClientsSignUpViewController: UIViewController {

  //Agregamos la referencia del coordinator
  weak var coordinator: ClientCoordinator?
  let clientsSignUpView = ClientsSignUpView()
  
    override func loadView() {
      super.loadView()
      view = clientsSignUpView
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .systemGray6
//      for family in UIFont.familyNames {
//        print(family)
//        for name in UIFont.fontNames(forFamilyName: family) {
//          print(name)
//        }
//      }
      configureDelegatesAndDataSource()
    }
    
  private func configureDelegatesAndDataSource() {
    //close nav btn delegate
    clientsSignUpView.delegate = self
    
    //html delegate
    clientsSignUpView.htmlTextView.delegate = self
  }
}

extension ClientsSignUpViewController: ClientsSignUpViewDelegate {

  //CLOSE NAVBAR BUTTON
  func onCloseNavBtnTapped() {
    self.dismiss(animated: true)
  }
  
  //NAME FIELD TOOLBAR ACTIONS
  func onDoneNameBtnTapped() {
    self.clientsSignUpView.nameTextField.endEditing(true)
  }
  
  func onCancelNameBtnTapped() {
    self.clientsSignUpView.nameTextField.text = nil
    self.clientsSignUpView.nameTextField.endEditing(true)
  }
  
  //DOCUMENT FIELD TOOLBAR ACTIONS
  func onDoneDocumentBtnTapped() {
    clientsSignUpView.idDocumentTextField.endEditing(true)
  }
  
  func onCancelDocumentBtnTapped() {
    clientsSignUpView.idDocumentTextField.text = nil
    clientsSignUpView.idDocumentTextField.endEditing(true)
  }
  
  //PHONE FIELD TOOLBAR ACTIONS
  func onDonePhoneBtnTapped() {
    clientsSignUpView.phoneNumberTextField.endEditing(true)
  }
  
  func onCancelPhoneBtnTapped() {
    clientsSignUpView.phoneNumberTextField.text = nil
    clientsSignUpView.phoneNumberTextField.endEditing(true)
  }
  
  //EMAIL FIELD TOOLBAR ACTIONS
  func onDoneEmailBtnTapped() {
    clientsSignUpView.emailTextField.endEditing(true)
  }
  
  func onCancelEmailBtnTapped() {
    clientsSignUpView.emailTextField.text = nil
    clientsSignUpView.emailTextField.endEditing(true)
  }
  
  //PASSWORD FIELD TOOLBAR ACTIONS
  func onDonePasswordBtnTapped() {
    clientsSignUpView.passwordTextField.endEditing(true)
  }
  
  func onCancelPasswordBtnTapped() {
    clientsSignUpView.passwordTextField.text = nil
    clientsSignUpView.passwordTextField.endEditing(true)
  }

  //MARK: - SIGN UP BTN
  func onSignUpBtnPressed(accepted: Bool, with userType: UserType) {
    
    // Primero verificamos la aceptación de términos
    guard accepted else {
      let acceptTermsAlert = Utilities.creatingAlerts(
        style: .default,
        titleAction: "Activar términos y condiciones",
        titleAlert: "ERROR, ACEPTAR TÉRMINOS",
        message: "Debes aceptar los términos y condiciones para poder ingresar.",
        preferredStyle: .alert)
      
      self.present(acceptTermsAlert, animated: true)
      return
    }
    
    // Extraemos la información del formulario
    let credentials = extractionOfCredentials()
    
    // Validamos los campos con los regex
    let validation = validateCredentials(credentials: credentials)
    
    guard validation == .success else {
          showValidationError(validation)
          return
      }
    
    // Registramos al cliente
    if userType == .client {
      registerClient(credentials: credentials, userType: userType)
    }
  }
  
  // MARK: - Extraction of credentials
  private func extractionOfCredentials() -> ExtractingCredentialsModel {

        let name = clientsSignUpView.nameTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let numberOfDocument = clientsSignUpView.idDocumentTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let mobileNumber = clientsSignUpView.phoneNumberTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let email = clientsSignUpView.emailTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let password = clientsSignUpView.passwordTextField.text ?? ""

        // Sexo opcional
        let selectedSex = clientsSignUpView.sexDropDownBtn.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let sex: Sex?

        switch selectedSex {
        case "Masculino":
            sex = .male

        case "Femenino":
            sex = .female

        default:
            // "Ninguno", campo vacío o sin selección
            sex = nil
        }

        return ExtractingCredentialsModel(
            name: name,
            numberOfDocument: numberOfDocument,
            mobileNumber: mobileNumber,
            email: email,
            password: password,
            sex: sex
        )
    }
  
  // MARK: - Validation
  private func validateCredentials(credentials: ExtractingCredentialsModel) -> TextFieldValidation {

      return CredentialsValidator.validateCredentials(credentials: credentials)
  }
  
  private func showValidationError(_ validation: TextFieldValidation) {
    let message: String
    
    switch validation {
      case .emptyFields:
          message = "Debes completar todos los campos obligatorios."

      case .invalidName:
          message = "El nombre no tiene un formato válido."

      case .invalidEmail:
          message = "El correo electrónico no tiene un formato válido."

      case .invalidPassword:
          message = "La contraseña debe tener mínimo 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial."

      case .invalidNumberOfDocument:
          message = "El número de documento no tiene un formato válido."

      case .invalidNumberOfCellPhone:
          message = "El número de celular no tiene un formato válido."

      case .success:
          return
    }
    
    let alert = Utilities.creatingAlerts(style: .default,
                                         titleAction: "Entendido",
                                         titleAlert: "Verifica tus datos",
                                         message: message,
                                         preferredStyle: .alert)
    
    present(alert, animated: true)
  
  }
  
}

extension ClientsSignUpViewController {
  
  // MARK: - Register client
  private func registerClient(credentials: ExtractingCredentialsModel, userType: UserType) {
    
    let sexValue: String?
    
    switch credentials.sex {
      case .male:
          sexValue = "male"

      case .female:
          sexValue = "female"

      case .none:
          sexValue = nil
    }
    
    let accountType = "client"
    
    let newClient = UserRegistrationModel(name: credentials.name,
                                          email: credentials.email,
                                          password: credentials.password,
                                          identityCard: credentials.numberOfDocument,
                                          phoneNumber: credentials.mobileNumber,
                                          sex: sexValue,
                                          accountType: accountType)
    
    Task {
      
      do {
        let registeredUser = try await APICaller.shared.registerUser(user: newClient)
        print("Cliente registrado correctamente")
        print("ID: \(registeredUser.id)")
        print("Nombre: \(registeredUser.name)")
        print("Correo: \(registeredUser.email)")
        await MainActor.run {
          self.coordinator?.userDidSingUpSuccessfully()
        }
  
      } catch {
        print("Error al registrar cliente: \(error.localizedDescription)")
        await MainActor.run {
          let alert = Utilities.creatingAlerts(style: .default,
                                               titleAction: "Entendido",
                                               titleAlert: "Error en el registro",
                                               message: error.localizedDescription,
                                               preferredStyle: .alert)
          self.present(alert, animated: true)
        }
      }
    }
  }
}

//MARK: - TEXTVIEW DELEGATE
extension ClientsSignUpViewController: UITextViewDelegate {
  
  func textView(_ textView: UITextView,
                shouldInteractWith URL: URL,
                in characterRange: NSRange,
                interaction: UITextItemInteraction) -> Bool {
   
    let safariVC = SFSafariViewController(url: URL)
    present(safariVC, animated: true)
    
    return false
  }
}
