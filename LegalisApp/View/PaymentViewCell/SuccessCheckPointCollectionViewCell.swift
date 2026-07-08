//
//  SuccessCheckPointCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 6/7/26.
//

import UIKit

class SuccessCheckPointCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "SuccessCheckPointCollectionViewCell"
  
  private let successPaymentLbl: UILabel = {
    let label = UILabel()
    label.text = "Pago Exitoso"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular_Bold", size: 34)
    label.textColor = #colorLiteral(red: 0.002019579057, green: 0.05263461918, blue: 0.139893055, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionLbl: UILabel = {
    let label = UILabel()
    label.text = """
                Su transacción ha sido procesada
                correctamente y el servicio ha sido
                activado.
                """
    label.numberOfLines = 5
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular", size: 13)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let view: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.2039153278, green: 0.7828979492, blue: 0.3481944203, alpha: 0.1001456558)
    view.widthAnchor.constraint(equalToConstant: 80).isActive = true
    view.heightAnchor.constraint(equalToConstant: 80).isActive = true
    view.layer.cornerRadius = 40
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let checkImage: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(named: "checkGrenn")
    img.contentMode = .scaleAspectFit
    img.clipsToBounds = true
    img.backgroundColor = .white
    img.widthAnchor.constraint(equalToConstant: 52.4).isActive = true
    img.heightAnchor.constraint(equalToConstant: 52.4).isActive = true
    img.layer.cornerRadius = 26.2
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  private func setUpUI() {
    
    let successLblStack = UIStackView(arrangedSubviews: [
      view,
      successPaymentLbl,
      descriptionLbl
    ])
    successLblStack.axis = .vertical
    successLblStack.spacing = 8
    successLblStack.alignment = .center
    successLblStack.translatesAutoresizingMaskIntoConstraints = false
    
    
    view.addSubview(checkImage)
    
    contentView.addSubview(successLblStack)
    
    NSLayoutConstraint.activate([
      checkImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      checkImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
//      view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      successLblStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      successLblStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
     
      
    
      
    ])
    
    
    
  }
  
}
