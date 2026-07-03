//
//  MethodCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 1/7/26.
//

import UIKit

class MethodCollectionViewCell: UICollectionViewCell {
 
  static let identifier = "MethodCollectionViewCell"
  
  private let cardIcon: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(systemName: "creditcard.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24, weight: .medium))
    image.tintColor = #colorLiteral(red: 0.0003543474304, green: 0.133256197, blue: 0.2870040238, alpha: 1)
    image.contentMode = .scaleAspectFit
    image.clipsToBounds = true
    image.widthAnchor.constraint(equalToConstant: 24).isActive = true
//    image.heightAnchor.constraint(equalToConstant: 24).isActive = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  //Checkbox
  private lazy var checkboxBtn = UIButton(type: .custom)
  
  private let cardTypeLabel: UILabel = {
    let label = UILabel()
//    label.text = "Credito"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular", size: 17)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpCheckBox()
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpCheckBox() {
    checkboxBtn.setImage(UIImage(systemName: "circle"), for: .normal)
    checkboxBtn.setImage(UIImage(systemName: "record.circle"), for: .selected)
    checkboxBtn.addTarget(self, action: #selector(toogleCheckbox(_ :)), for: .touchUpInside)
    checkboxBtn.tintColor = #colorLiteral(red: 0.001187827205, green: 0.1258176565, blue: 0.2670794427, alpha: 1)
    
    checkboxBtn.translatesAutoresizingMaskIntoConstraints = false
  }
  
  //MARK: toogle of check box (update the UI)
  @objc func toogleCheckbox(_ sender: UIButton) {
    sender.isSelected.toggle()
  }
  
  private func setUpUI() {
    let cardTypeStack = UIStackView(arrangedSubviews: [
      checkboxBtn,
      cardIcon,
      cardTypeLabel
    ])
    cardTypeStack.axis = .horizontal
    cardTypeStack.spacing = 5
    cardTypeStack.translatesAutoresizingMaskIntoConstraints = false
    
//    let checkboxStack = UIStackView(arrangedSubviews: [
//      checkboxBtn,
//      cardTypeStack
//    ])
//    checkboxStack.axis = .horizontal
//    checkboxStack.spacing = 10
//    checkboxStack.alignment = .leading
//    checkboxStack.distribution = .fill
//    checkboxStack.translatesAutoresizingMaskIntoConstraints = false
    
   
    contentView.addSubview(cardTypeStack)
   // contentView.addSubview(cardTypeLabel)
    NSLayoutConstraint.activate([
      
      cardTypeStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),

      cardTypeStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      cardTypeStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
      
      
      
    ])
    
  }
  
  func configure(with text: String) {
    cardTypeLabel.text = text
  }
  
}
