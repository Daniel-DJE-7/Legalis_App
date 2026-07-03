//
//  CardDetailsCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 3/7/26.
//

import UIKit

class CardDetailsCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "CardDetailsCollectionViewCell"
  
  let holderTxtfield = UITextField()
  let cardNumberTxtfield = UITextField()
  let expirationDateTxtfield = UITextField()
  let cvvTxtfield = UITextField()
  
  let holderLabel: UILabel = {
    let label = UILabel()
    label.text = "Titular"
    label.textAlignment = .left
    label.font = UIFont(name: "Inter-Regular", size: 17)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let cardNumberLabel: UILabel = {
    let label = UILabel()
    label.text = "Número de tarjeta"
    label.textAlignment = .left
    label.font = UIFont(name: "Inter-Regular", size: 17)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let expirationDateLabel: UILabel = {
    let label = UILabel()
    label.text = "Fecha de vencimiento"
    label.textAlignment = .left
    label.font = UIFont(name: "Inter-Regular", size: 17)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let cvvLabel: UILabel = {
    let label = UILabel()
    label.text = "CVV"
    label.textAlignment = .left
    label.font = UIFont(name: "Inter-Regular", size: 17)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  let verticalDivider = UIView()
  let horizontalDividerOne = UIView()
  let horizontalDividerTwo = UIView()
  
  let nameToolBar = UIToolbar()
  let cardNumberToolBar = UIToolbar()
  let expirationDateToolBar = UIToolbar()
  let cvvToolBar = UIToolbar()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpToolBarsForTextFields()
    setUpTxtField()
    setUpDividers()
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpTxtField() {
    Utilities.clientTextFieldStyle(holderTxtfield,
                                   placeholder: "NOMBRE COMO APARECE",
                                   isSecureTextEntry: false,
                                   keyboardAppearance: .default,
                                   clearButtonMode: .none,
                                   keyboardType: .alphabet,
                                   inputAccessoryView: nameToolBar,
                                   backgroundColor: .white,
                                   leftIcon: nil)
    holderTxtfield.translatesAutoresizingMaskIntoConstraints = false
    
    Utilities.clientTextFieldStyle(cardNumberTxtfield,
                                   placeholder: "0000 0000 0000 0000",
                                   isSecureTextEntry: false,
                                   keyboardAppearance: .default,
                                   clearButtonMode: .none,
                                   keyboardType: .alphabet,
                                   inputAccessoryView: cardNumberToolBar,
                                   backgroundColor: .white,
                                   leftIcon: nil)
    cardNumberTxtfield.translatesAutoresizingMaskIntoConstraints = false
    
    Utilities.clientTextFieldStyle(expirationDateTxtfield,
                                   placeholder: "MM/AA",
                                   isSecureTextEntry: false,
                                   keyboardAppearance: .default,
                                   clearButtonMode: .none,
                                   keyboardType: .alphabet,
                                   inputAccessoryView: expirationDateToolBar,
                                   backgroundColor: .white,
                                   leftIcon: nil)
    expirationDateTxtfield.translatesAutoresizingMaskIntoConstraints = false
    
    
    Utilities.clientTextFieldStyle(cvvTxtfield,
                                   placeholder: "123",
                                   isSecureTextEntry: false,
                                   keyboardAppearance: .default,
                                   clearButtonMode: .none,
                                   keyboardType: .alphabet,
                                   inputAccessoryView: cvvToolBar,
                                   backgroundColor: .white,
                                   leftIcon: nil)
    cvvTxtfield.translatesAutoresizingMaskIntoConstraints = false
    
  }
  
  //MARK: ToolBars
  private func setUpToolBarsForTextFields() {
    Utilities.creatingToolBar(nameToolBar, target: self, doneAction: #selector(onDoneNametapped), cancelAction: #selector(onCancelNameTapped))
    
    Utilities.creatingToolBar(cardNumberToolBar, target: self, doneAction: #selector(onDoneCardNumbertapped), cancelAction: #selector(onCancelCardNumberTapped))
    
    Utilities.creatingToolBar(expirationDateToolBar, target: self, doneAction: #selector(onDoneExpirationtapped), cancelAction: #selector(onCancelExpirationTapped))
    
    Utilities.creatingToolBar(cvvToolBar, target: self, doneAction: #selector(onDoneCVVtapped), cancelAction: #selector(onCancelCVVTapped))
  }
  
  //MARK: Dividers
  private func setUpDividers() {
    Utilities.divider(verticalDivider, backgroundColor: .red, height: 1)
    
    verticalDivider.translatesAutoresizingMaskIntoConstraints = false
    
    Utilities.divider(horizontalDividerOne, backgroundColor: .systemGray6, height: 2)
    horizontalDividerOne.translatesAutoresizingMaskIntoConstraints = false
    
    Utilities.divider(horizontalDividerTwo, backgroundColor: .systemGray6, height: 2)
    horizontalDividerTwo.translatesAutoresizingMaskIntoConstraints = false
  }
  
  //MARK: UI
  private func setUpUI() {
    
    let nameStack = UIStackView(arrangedSubviews: [
      holderLabel,
      holderTxtfield,
      horizontalDividerOne
    ])
    nameStack.axis = .vertical
//    nameStack.spacing = 2
    nameStack.isLayoutMarginsRelativeArrangement = true
    nameStack.layoutMargins = .init(top: 5, left: 5, bottom: 0, right: 0)
    nameStack.backgroundColor = .white
    nameStack.translatesAutoresizingMaskIntoConstraints = false
    
    let cardNumberStack = UIStackView(arrangedSubviews: [
      cardNumberLabel,
      cardNumberTxtfield,
      horizontalDividerTwo
    ])
    cardNumberStack.axis = .vertical
    cardNumberStack.spacing = 2
    cardNumberStack.isLayoutMarginsRelativeArrangement = true
    cardNumberStack.layoutMargins = .init(top: 0, left: 5, bottom: 0, right: 0)
    cardNumberStack.backgroundColor = .white
    cardNumberStack.translatesAutoresizingMaskIntoConstraints = false
    
    let expirationStack = UIStackView(arrangedSubviews: [
      expirationDateLabel,
      expirationDateTxtfield,
    ])
    expirationStack.axis = .vertical
    expirationStack.spacing = 2
    expirationStack.isLayoutMarginsRelativeArrangement = true
    expirationStack.layoutMargins = .init(top: 0, left: 5, bottom: 0, right: 0)
    expirationStack.backgroundColor = .white
    expirationStack.translatesAutoresizingMaskIntoConstraints = false
    
    let cvvStack = UIStackView(arrangedSubviews: [
      cvvLabel,
      cvvTxtfield
    ])
    cvvStack.axis = .vertical
    cvvStack.spacing = 2
    cvvStack.isLayoutMarginsRelativeArrangement = true
    cvvStack.layoutMargins = .init(top: 0, left: 5, bottom: 0, right: 0)
    cvvStack.backgroundColor = .white
    cvvStack.translatesAutoresizingMaskIntoConstraints = false
    
//    let cvvAndExpiStack = UIStackView(arrangedSubviews: [
//      expirationStack,
//      verticalDivider,
//      cvvStack
//    ])
//    cvvAndExpiStack.axis = .horizontal
//    cvvAndExpiStack.spacing = 2
//    cvvAndExpiStack.distribution = .fill
//    cvvAndExpiStack.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(nameStack)
    contentView.addSubview(cardNumberStack)
    contentView.addSubview(expirationStack)
    
    contentView.addSubview(cvvStack)
    
    NSLayoutConstraint.activate([
      nameStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      nameStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      nameStack.topAnchor.constraint(equalTo: contentView.topAnchor),
      
      cardNumberStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      cardNumberStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      cardNumberStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor),
     
      expirationStack.topAnchor.constraint(equalTo: cardNumberStack.bottomAnchor),
      expirationStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      expirationStack.widthAnchor.constraint(equalToConstant: 200),
      expirationStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      cvvStack.topAnchor.constraint(equalTo: cardNumberStack.bottomAnchor),
      cvvStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      cvvStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      cvvStack.widthAnchor.constraint(equalToConstant: 160.5)

      
      
     
    ])
    
    
  }
  
  @objc func onDoneNametapped() {
    print("h")
  }
  
  @objc func onDoneCardNumbertapped() {
    print("A")
  }
  
  @objc func onDoneExpirationtapped() {
    print("F")
  }
  
  @objc func onDoneCVVtapped() {
    print("Z")
  }
  
  @objc func onCancelNameTapped() {
    print("h")
  }
  
  @objc func onCancelCardNumberTapped() {
    print("A")
  }
  
  @objc func onCancelExpirationTapped() {
    print("F")
  }
  
  @objc func onCancelCVVTapped() {
    print("Z")
  }
  
}
