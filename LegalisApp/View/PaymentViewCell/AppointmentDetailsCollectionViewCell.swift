//
//  AppointmentDetailsCollectionViewCell.swift
//  LegalisApp
//
//  Created by Memo Figueredo on 6/7/26.
//

import UIKit

class AppointmentDetailsCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "AppointmentDetailsCollectionViewCell"
 
  private let idTransactionLbl: UILabel = {
    let label = UILabel()
    label.text = "ID de Transacción"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular", size: 13)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let idCodeTransactionLbl: UILabel = {
    let label = UILabel()
    label.text = "T-982938"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular_Semibold", size: 17)
    label.textColor = #colorLiteral(red: 0.002019579057, green: 0.05263461918, blue: 0.139893055, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let dateTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Fecha y Hora"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular", size: 13)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.text = "10/04/2026"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 17)
    label.textColor = #colorLiteral(red: 0.002019579057, green: 0.05263461918, blue: 0.139893055, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let totalLabel: UILabel = {
    let label = UILabel()
    label.text = "Monto total"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular", size: 13)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let valueLabel: UILabel = {
    let label = UILabel()
    label.text = "$ 149.000 COP"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 17)
    label.textColor = #colorLiteral(red: 0.002019579057, green: 0.05263461918, blue: 0.139893055, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let horizontalDividerOne = UIView()
  let horizontalDividerTwo = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpDividers()
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpDividers() {
    Utilities.divider(horizontalDividerOne, backgroundColor: .systemGray6, height: 2)
    horizontalDividerOne.translatesAutoresizingMaskIntoConstraints = false
    
    Utilities.divider(horizontalDividerTwo, backgroundColor: .systemGray6, height: 2)
    horizontalDividerTwo.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setUpUI() {
    
    let transactionStack = UIStackView(arrangedSubviews: [
      idTransactionLbl,
      idCodeTransactionLbl
    ])
    transactionStack.axis = .horizontal
    transactionStack.spacing = 30
    transactionStack.isLayoutMarginsRelativeArrangement = true
    transactionStack.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    transactionStack.translatesAutoresizingMaskIntoConstraints = false

    
    let detailStack = UIStackView(arrangedSubviews: [
      dateTitleLabel,
      dateLabel
    ])
    detailStack.axis = .horizontal
    detailStack.spacing = 30
    detailStack.translatesAutoresizingMaskIntoConstraints = false
    
   
    let totalValueStack = UIStackView(arrangedSubviews: [
      totalLabel,
      valueLabel
    ])
    totalValueStack.axis = .horizontal
    totalValueStack.spacing = 30
    totalValueStack.isLayoutMarginsRelativeArrangement = true
    totalValueStack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
    totalValueStack.translatesAutoresizingMaskIntoConstraints = false
    
  
    
    let globalStack = UIStackView(arrangedSubviews: [
      transactionStack,
      horizontalDividerOne,
      detailStack,
      horizontalDividerTwo,
      totalValueStack
    ])
    globalStack.axis = .vertical
    globalStack.spacing = 10
    globalStack.backgroundColor = .white
    globalStack.layer.cornerRadius = 12
    globalStack.layer.borderWidth = 2
    globalStack.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    globalStack.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(globalStack)
    

    NSLayoutConstraint.activate([
      globalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
      globalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      globalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      globalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
    
  }
  
}
