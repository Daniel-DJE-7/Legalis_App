//
//  PaymentHeaderMethodCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 1/7/26.
//

import UIKit

class PaymentHeaderMethodCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "PaymentMethodCollectionViewCell"
  
  private let appointmentLabel: UILabel = {
    let label = UILabel()
    label.text = "Cita"
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular_Bold", size: 34)
    label.textColor = #colorLiteral(red: 0.002019579057, green: 0.05263461918, blue: 0.139893055, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let codeLabel: UILabel = {
    let label = UILabel()
    label.text = "#JL-1024"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular", size: 17)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let totalPriceLabel: UILabel = {
    let label = UILabel()
    label.text = "Precio Total"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 24)
    label.textColor = #colorLiteral(red: 0.002019579057, green: 0.05263461918, blue: 0.139893055, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.text = "150000"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular", size: 17)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.heightAnchor.constraint(equalToConstant: 41).isActive = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpUI() {
    let headerStack = UIStackView(arrangedSubviews: [
      appointmentLabel,
      codeLabel
    ])
    headerStack.axis = .vertical
    headerStack.spacing = 5
    headerStack.translatesAutoresizingMaskIntoConstraints = false
    
    
    let priceStack = UIStackView(arrangedSubviews: [
      totalPriceLabel,
      priceLabel
    ])
    priceStack.axis = .vertical
    priceStack.spacing = 5
    priceStack.translatesAutoresizingMaskIntoConstraints = false
    
    
    let globalStack = UIStackView(arrangedSubviews: [
      headerStack,
      priceStack
    ])
    globalStack.axis = .vertical
    globalStack.spacing = 10
    globalStack.translatesAutoresizingMaskIntoConstraints = false
    
    
    contentView.addSubview(globalStack)
    
    NSLayoutConstraint.activate([
      globalStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      globalStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
      
    ])
    
    
  }
}
