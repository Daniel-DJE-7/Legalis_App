//
//  LawyersSignUpViewController.swift
//  LegalisApp
//
//  Created by Memo Figueredo on 5/5/26.
//

import UIKit
import SafariServices


class LawyersSignUpViewController: UIViewController {
    
  
  private let gendersOptions = ["Masculino", "Femenino"]
  private let practiceType = ["Independiente", "Bufete o Empresa"]
  let htmlText = """
                <div style="text-align: center;">
                    Al registrarte, aceptas nuestros <a href='https://tuapp.com/terminos'>Términos de servicio</a> <br> y <a href='https://tuapp.com/privacidad'>Política de privacidad</a>.
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
      actionsSixTextFieldToolBar()
      closeNavActionButton()
      setHTMLText()
    }

  //MARK: - Delegates & Data sources
  private func configuringDelegatesAndDataSources() {
    
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
  
  
  func actionsTextFieldFiveToolBar() {
    
    lawyersSignUpView.onDoneTapped = { [weak self] in
      self?.lawyersSignUpView.textFields[5].endEditing(true)
    }
    
    lawyersSignUpView.onCancelTapped = { [weak self] in
      self?.lawyersSignUpView.textFields[5].text = nil
      self?.lawyersSignUpView.textFields[5].endEditing(true)
      
    }
  }
    
    
    func actionsSixTextFieldToolBar() {
//      lawyersSignUpView.onDoneTapped = { [weak self] in
//        self?.lawyersSignUpView.textFields[6].endEditing(true)
//      }
      
//      lawyersSignUpView.onCancelTapped = { [weak self] in
//        self?.lawyersSignUpView.textFields[6].text = nil
//        self?.lawyersSignUpView.textFields[6].endEditing(true)
//
//      }
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

extension LawyersSignUpViewController: UITextViewDelegate {
  
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    let safariVC = SFSafariViewController(url: URL)
    present(safariVC, animated: true)
    
    return false
  }
}

