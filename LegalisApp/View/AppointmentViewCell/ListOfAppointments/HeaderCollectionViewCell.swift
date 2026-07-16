//
//  HeaderCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 16/7/26.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "HeaderCollectionReusableView"
  
  
  private let headerLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont(name: "Inter-Regular", size: 13)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let historyBtn = UIButton()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpBtn()
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpBtn() {
    Utilities.customButtonStyle(historyBtn,
                                appearance: .plain(),
                                title: nil,
                                image: nil,
                                imagePlacement: nil,
                                imagePadding: nil,
                                cornerRadius: nil,
                                cornerStyle: nil,
                                backgroundColor: nil,
                                baseForeground: #colorLiteral(red: 0, green: 0.1370561421, blue: 0.2949633002, alpha: 1),
                                width: 100,
                                height: 16,
                                target: self,
                                action: #selector(dipTapSeeHistoryTapped))

    historyBtn.translatesAutoresizingMaskIntoConstraints = false
    
    let attributes: [NSAttributedString.Key : Any] = [
      .font : UIFont(name: "Inter-Regular", size: 12) as Any
    ]
    
    let attributedTitle = NSAttributedString(string: "Ver historial",
                                             attributes: attributes)
    
    historyBtn.setAttributedTitle(attributedTitle, for: .normal)
    
   
  }
  
  private func setUpUI() {
    
    let headerStack = UIStackView(arrangedSubviews: [
      headerLabel,
      historyBtn
    ])
    headerStack.axis = .horizontal
    headerStack.spacing = 16
    headerStack.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(headerLabel)
    contentView.addSubview(historyBtn)
    
    NSLayoutConstraint.activate([
      headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
      
      historyBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      historyBtn.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
      historyBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      
    ])
      
      
      
     
  
    
  }
  

  
  
  @objc func dipTapSeeHistoryTapped() {
    print("ok")
  }
  
  func configure(with title: String) {
    headerLabel.text = title
  }
  
  
}

