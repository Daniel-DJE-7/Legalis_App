//
//  ModalityCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 26/6/26.
//

import UIKit

class ModalityCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "ModalityCollectionViewCell"
  
  let virtualBtn = UIButton()
  let physicalBtn = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpBtn()
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpBtn() {
    Utilities.customButtonStyle(virtualBtn,
                                appearance: .plain(),
                                title: "Virtual",
                                image: UIImage(systemName: "video.fill"),
                                imagePlacement: .top,
                                imagePadding: 8,
                                cornerRadius: 12,
                                cornerStyle: nil,
                                backgroundColor: UIColor(red: 0, green: 0.1063321754, blue: 0.2393084168, alpha: 1),
                                baseForeground: .systemBackground,
                                width: nil,
                                height: 91,
                                target: self,
                                action: #selector(dipTapModalityAppointment))
    virtualBtn.translatesAutoresizingMaskIntoConstraints = false
    
    Utilities.customButtonStyle(physicalBtn,
                                appearance: .plain(),
                                title: "Presencial",
                                image: UIImage(systemName: "person.2.wave.2.fill"),
                                imagePlacement: .top,
                                imagePadding: 8,
                                cornerRadius: 12,
                                cornerStyle: nil,
                                backgroundColor: #colorLiteral(red: 0.8862124085, green: 0.8859043121, blue: 0.9066769481, alpha: 1),
                                baseForeground: .darkGray,
                                width: nil,
                                height: 91,
                                target: self,
                                action: #selector(dipTapModalityAppointment))
    
    physicalBtn.layer.borderColor = #colorLiteral(red: 0.7682896852, green: 0.7757481933, blue: 0.817332685, alpha: 1)
    physicalBtn.layer.borderWidth = 1
    
    
    physicalBtn.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setUpUI() {
    
    let btnStack = UIStackView(arrangedSubviews: [
      virtualBtn,
      physicalBtn
    ])
    btnStack.axis = .horizontal
    btnStack.spacing = 5
    btnStack.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(btnStack)
    
    NSLayoutConstraint.activate([
      btnStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      btnStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      btnStack.topAnchor.constraint(equalTo: contentView.topAnchor),
      btnStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
  
  @objc func dipTapModalityAppointment() {
    print("ok")
  }
  
}
