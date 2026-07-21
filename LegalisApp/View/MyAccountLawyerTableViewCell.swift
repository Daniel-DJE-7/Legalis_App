//
//  MyAccountLawyerCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/7/26.
//

import UIKit

class MyAccountPhotoCollectionViewCell: UICollectionViewCell {

    static let identifier = "MyAccountLawyerCollectionViewCell"
  
  // lawyer image
  private let userImage: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(named: "f")
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    img.tintColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    img.widthAnchor.constraint(equalToConstant: 96).isActive = true
    img.heightAnchor.constraint(equalToConstant: 96).isActive = true
    img.layer.cornerRadius = 48
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  //lawyer name
  private let lawyerNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Pedro Martinez"
    label.numberOfLines = 1
    label.font = UIFont(name: "Inter-Regular_Bold", size: 34)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //lawyer category label
  private let lawyerMailLbl: UILabel = {
    let label = UILabel()
    label.text = "ralarcon@legalyasociados.com"
    label.numberOfLines = 0
    label.font = UIFont(name: "Inter-Regular", size: 15)
    label.textColor = #colorLiteral(red: 0.3842505217, green: 0.3839372396, blue: 0.4047031403, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let editImageBtn = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpEditBtn()
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpEditBtn() {
    Utilities.customButtonStyle(editImageBtn,
                                appearance: .plain(),
                                title: nil,
                                image: UIImage(named: "editBtn"),
                                imagePlacement: nil,
                                imagePadding: nil,
                                cornerRadius: 14,
                                cornerStyle: nil,
                                backgroundColor: nil,
                                baseForeground: nil,
                                width: 28,
                                height: 28,
                                target: self,
                                action: #selector(onEditPhotoBtnTapped))
    
    
    editImageBtn.translatesAutoresizingMaskIntoConstraints = false
  }
  
  @objc func onEditPhotoBtnTapped() {
    print("ok")
  }
  
  private func setUpUI() {
    
    let labelStack = UIStackView(arrangedSubviews: [
      lawyerNameLabel,
      lawyerMailLbl
    ])
    labelStack.axis = .vertical
    labelStack.alignment = .center
    labelStack.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(userImage)
    contentView.addSubview(editImageBtn)
    contentView.addSubview(labelStack)
    
    NSLayoutConstraint.activate([
      userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 44),
      userImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//      userImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -120),
      editImageBtn.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: -25),
      editImageBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 217),
      labelStack.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 16),
      labelStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
      labelStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
      labelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17)
      
    ])
  }

  
  
}
