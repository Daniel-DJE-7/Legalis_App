//
//  PaymentButtonsCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 2/7/26.
//

import UIKit

protocol PaymentButtonsCollectionViewCellDelegate: AnyObject {
  func onVirtualPaymentPressed()
  func onPhysicalPaymentPressed()
}

class PaymentButtonsCollectionViewCell: UICollectionViewCell {
      
  static let identifier = "PaymentButtonsCollectionViewCell"
   
  weak var delegate: PaymentButtonsCollectionViewCellDelegate?
  
  let virtualPayBtn = UIButton()
  let physicalPayBtn = UIButton()
  
  private let poweredLabel: UILabel = {
    let label = UILabel()
    label.text = "Powered by"
    label.numberOfLines = 0
    label.textAlignment = .left
    label.font = UIFont(name: "Inter-Regular", size: 11)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let nuveiLogo: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(named: "nuveiLogo")
    img.contentMode = .scaleAspectFill
    img.widthAnchor.constraint(equalToConstant: 39).isActive = true
    img.heightAnchor.constraint(equalToConstant: 13).isActive = true
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setUpBtn()
      setUpUI()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpBtn() {
      Utilities.customButtonStyle(virtualPayBtn,
                                  appearance: .plain(),
                                  title: "Pagar Virtual",
                                  image: UIImage(systemName: "creditcard"),
                                  imagePlacement: .trailing,
                                  imagePadding: 200,
                                  cornerRadius: 8,
                                  cornerStyle: nil,
                                  backgroundColor: UIColor(red: 0, green: 0.1063321754, blue: 0.2393084168, alpha: 1),
                                  baseForeground: .systemBackground,
                                  width: nil,
                                  height: 52,
                                  target: self,
                                  action: #selector(dipTapVirtualPaymentBtn))
      virtualPayBtn.translatesAutoresizingMaskIntoConstraints = false
      
      Utilities.customButtonStyle(physicalPayBtn,
                                  appearance: .plain(),
                                  title: "Pagar en Efectivo",
                                  image: UIImage(named: "cash"),
                                  imagePlacement: .trailing,
                                  imagePadding: 170,
                                  cornerRadius: 8,
                                  cornerStyle: nil,
                                  backgroundColor: UIColor(red: 0.9411144257, green: 0.9408066869, blue: 0.9615796208, alpha: 1),
                                  baseForeground: UIColor(red: 0.002019579057, green: 0.05263461918, blue: 0.139893055, alpha: 1),
                                  width: nil,
                                  height: 52,
                                  target: self,
                                  action: #selector(dipTapPhysicalPaymentBtn))
      
      physicalPayBtn.layer.borderColor = #colorLiteral(red: 0.002019579057, green: 0.05263461918, blue: 0.139893055, alpha: 1)
      physicalPayBtn.layer.borderWidth = 2
      physicalPayBtn.translatesAutoresizingMaskIntoConstraints = false
      
      
    }
    
    private func setUpUI() {
      
      
      let nuveiStack = UIStackView(arrangedSubviews: [
        poweredLabel,
        nuveiLogo
      ])
      nuveiStack.axis = .horizontal
      nuveiStack.spacing = 5
      nuveiStack.alignment = .center
      nuveiStack.distribution = .fill
      nuveiStack.translatesAutoresizingMaskIntoConstraints = false
      
      
      let btnsStack = UIStackView(arrangedSubviews: [
        virtualPayBtn,
        physicalPayBtn
      ])
      btnsStack.axis = .vertical
      btnsStack.spacing = 12
      btnsStack.distribution = .fill
      

      btnsStack.translatesAutoresizingMaskIntoConstraints = false
      
      contentView.addSubview(btnsStack)
      contentView.addSubview(nuveiStack)
      
      NSLayoutConstraint.activate([
        btnsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        btnsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        btnsStack.topAnchor.constraint(equalTo: contentView.topAnchor),
        btnsStack.bottomAnchor.constraint(equalTo: nuveiStack.topAnchor, constant: -12),
        nuveiStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        
        nuveiStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      ])
    }
  
  
  @objc func dipTapVirtualPaymentBtn() {
    delegate?.onVirtualPaymentPressed()
    
  }
  
  @objc func dipTapPhysicalPaymentBtn() {
    delegate?.onPhysicalPaymentPressed()
    
  }
}
