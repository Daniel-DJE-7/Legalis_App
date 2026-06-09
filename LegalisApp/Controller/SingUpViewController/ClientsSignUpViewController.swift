//
//  ClientsSignUpViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 5/5/26.
//

import UIKit
import SafariServices

class ClientsSignUpViewController: UIViewController {

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

  //SIGN UP BTN
  func onSignUpBtnPressed(accepted: Bool, with userType: UserType) {
    if accepted && userType == .client {
      let mainTabBar = MainTabBarItemNavigationController()
      mainTabBar.updateUserType(.client)
      mainTabBar.modalPresentationStyle = .fullScreen
      mainTabBar.modalTransitionStyle = .crossDissolve
      present(mainTabBar, animated: true)
    } else {
      
      let acceptTermsAlert = Utilities.creatingAlerts(
        style: .default,
        titleAction: "Activar términos y condiciones",
        titleAlert: "ERROR, ACEPTAR TÉRMINOS",
        message: "Debes aceptar los términos y condiciones para poder ingresar.",
        preferredStyle: .alert)
      
      self.present(acceptTermsAlert, animated: true)
    }
  }
  
  
}

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
