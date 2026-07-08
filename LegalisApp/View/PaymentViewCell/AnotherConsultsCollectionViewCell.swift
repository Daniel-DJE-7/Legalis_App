//
//  AnotherConsultsCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 6/7/26.
//

import UIKit

class AnotherConsultsCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "AnotherConsultsCollectionViewCell"
  weak var delegate: ContinueButtonCollectionViewCellDelegate?
  
  let downloadVoucher = UIButton()
  let myConsultsBtn = UIButton()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setUpBtn()
      setUpUI()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpBtn() {
      Utilities.customButtonStyle(downloadVoucher,
                                  appearance: .plain(),
                                  title: "Descargar comprobante",
                                  image: nil,
                                  imagePlacement: nil,
                                  imagePadding: nil,
                                  cornerRadius: 10,
                                  cornerStyle: nil,
                                  backgroundColor: .white,
                                  baseForeground: .black,
                                  width: nil,
                                  height: 52,
                                  target: self,
                                  action: #selector(dipTapDownloadVoucherTapped))
      downloadVoucher.translatesAutoresizingMaskIntoConstraints = false
      downloadVoucher.layer.borderColor = #colorLiteral(red: 0.7604464889, green: 0.7679048181, blue: 0.8094890118, alpha: 1)
      downloadVoucher.layer.borderWidth = 2
      
      Utilities.customButtonStyle(myConsultsBtn,
                                  appearance: .plain(),
                                  title: "Ir a mis consultas",
                                  image: nil,
                                  imagePlacement: nil,
                                  imagePadding: nil,
                                  cornerRadius: 10,
                                  cornerStyle: nil,
                                  backgroundColor: #colorLiteral(red: 0, green: 0.1063321754, blue: 0.2393084168, alpha: 1),
                                  baseForeground: .white,
                                  width: nil,
                                  height: 52,
                                  target: self,
                                  action: #selector(dipTapOtherConsultsTapped))
      
      myConsultsBtn.translatesAutoresizingMaskIntoConstraints = false
      
    }
    
  private func setUpUI() {
    
    let btnsStack = UIStackView(arrangedSubviews: [
      myConsultsBtn,
      downloadVoucher
    ])
    btnsStack.axis = .vertical
    btnsStack.spacing = 12
    btnsStack.distribution = .fill
    btnsStack.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(btnsStack)
   
    
    NSLayoutConstraint.activate([
      btnsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      btnsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      btnsStack.topAnchor.constraint(equalTo: contentView.topAnchor),
      btnsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      btnsStack.heightAnchor.constraint(equalToConstant: 116)
    ])
  }
  
  @objc func dipTapDownloadVoucherTapped() {
    
    print("voucher downloaded")
  }
  
  @objc func dipTapOtherConsultsTapped() {
    delegate?.onContinueBtnTapped()
  }
}
