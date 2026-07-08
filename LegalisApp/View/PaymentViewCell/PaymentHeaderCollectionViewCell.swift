//
//  PaymentHeaderCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 29/6/26.
//

import UIKit

class PaymentHeaderCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "PaymentHeaderCollectionViewCell"
  
  private let titleHeader: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Inter-Regular_Bold", size: 34)
    label.numberOfLines = 0
    label.lineBreakMode = .byClipping
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionPageLabel: UILabel = {
    let label = UILabel()
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.numberOfLines = 0
    label.textAlignment = .left
    label.font = UIFont(name: "Inter-Regular", size: 15)
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
  
  
  func setUpUI() {
    
    let headerStack = UIStackView(arrangedSubviews: [
      titleHeader,
      descriptionPageLabel
    ])
    headerStack.axis = .vertical
    headerStack.alignment = .leading
    headerStack.spacing = 4
    headerStack.isLayoutMarginsRelativeArrangement = true
    headerStack.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 16, right: 5)
    headerStack.translatesAutoresizingMaskIntoConstraints = false
    
    
    contentView.addSubview(headerStack)
    
    NSLayoutConstraint.activate([
      titleHeader.widthAnchor.constraint(equalToConstant: 352),
    ])
   
  }
  
  func configure(with title: String, and subtitle: String) {
    titleHeader.text = title
    descriptionPageLabel.text = subtitle
  }
  
}
