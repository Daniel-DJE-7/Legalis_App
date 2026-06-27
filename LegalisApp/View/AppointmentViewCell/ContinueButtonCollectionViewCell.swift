//
//  ContinueButtonCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 26/6/26.
//

import UIKit

class ContinueButtonCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "ContinueButtonCollectionViewCell"
  
  let continueBtn = UIButton()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpBtn()
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpBtn() {
    Utilities.customButtonStyle(continueBtn,
                                appearance: .plain(),
                                title: "Continuar",
                                image: nil,
                                imagePlacement: nil,
                                imagePadding: nil,
                                cornerRadius: 12,
                                cornerStyle: nil,
                                backgroundColor: UIColor(red: 0, green: 0.1063321754, blue: 0.2393084168, alpha: 1),
                                baseForeground: .systemBackground,
                                width: nil,
                                height: 54,
                                target: self,
                                action: #selector(dipTapModalityAppointment))
    continueBtn.translatesAutoresizingMaskIntoConstraints = false
    
  }
  
  private func setUpUI() {
    
    contentView.addSubview(continueBtn)
    
    NSLayoutConstraint.activate([
      continueBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      continueBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      continueBtn.topAnchor.constraint(equalTo: contentView.topAnchor),
      continueBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
  
  @objc func dipTapModalityAppointment() {
    print("ok")
  }
  
}

  

