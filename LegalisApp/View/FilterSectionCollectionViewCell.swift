//
//  FilterSectionCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 16/6/26.
//

import UIKit

class FilterSectionCollectionViewCell: UICollectionReusableView {
    
  static let identifier = "FilterSectionCollectionViewCell"
  
  lazy var allLawyersBtn = UIButton()
  lazy var availableBtn = UIButton()
  lazy var topRatedBtn = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpUI()
    setUpBtnTitles()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setUpUI() {
    Utilities.customButtonStyle(
      allLawyersBtn,
      appearance: .plain(),
      title: "Todos",
      image: nil,
      imagePlacement: nil,
      imagePadding: nil,
      cornerRadius: 15,
      cornerStyle: .capsule,
      backgroundColor: .white,
      baseForeground: #colorLiteral(red: 0.262216866,
                                    green: 0.2779523134,
                                    blue: 0.3071090579,
                                    alpha: 1),
      width: 67.28,
      height: 30,
      target: self,
      action: #selector(onAllLayersBtnPressed))
    
    allLawyersBtn.layer.borderColor = #colorLiteral(red: 0.7682896852, green: 0.7757481933, blue: 0.817332685, alpha: 1)
    allLawyersBtn.layer.borderWidth = 1
    
    
    Utilities.customButtonStyle(
      availableBtn,
      appearance: .plain(),
      title: "Disponibles hoy",
      image: nil,
      imagePlacement: nil,
      imagePadding: nil,
      cornerRadius: 15,
      cornerStyle: .capsule,
      backgroundColor: .white,
      baseForeground: #colorLiteral(red: 0.262216866,
                                    green: 0.2779523134,
                                    blue: 0.3071090579,
                                    alpha: 1),
      width: 125.36,
      height: 30,
      target: self,
      action: #selector(onAvailableLawyersBtnPressed))
    availableBtn.layer.borderColor = #colorLiteral(red: 0.7682896852, green: 0.7757481933, blue: 0.817332685, alpha: 1)
    availableBtn.layer.borderWidth = 1
    
    Utilities.customButtonStyle(
      topRatedBtn,
      appearance: .plain(),
      title: "Mejor valorados",
      image: nil,
      imagePlacement: nil,
      imagePadding: nil,
      cornerRadius: 15,
      cornerStyle: .capsule,
      backgroundColor: .white,
      baseForeground: #colorLiteral(red: 0.262216866,
                                    green: 0.2779523134,
                                    blue: 0.3071090579,
                                    alpha: 1),
      width: 126.55,
      height: 30,
      target: self,
      action: #selector(onTopRatedBtnPressed))
    
    topRatedBtn.layer.borderColor = #colorLiteral(red: 0.7682896852, green: 0.7757481933, blue: 0.817332685, alpha: 1)
    topRatedBtn.layer.borderWidth = 1
    
    allLawyersBtn.translatesAutoresizingMaskIntoConstraints = false
    availableBtn.translatesAutoresizingMaskIntoConstraints = false
    topRatedBtn.translatesAutoresizingMaskIntoConstraints = false
    
    
    let filterBtnStack = UIStackView(arrangedSubviews: [
      allLawyersBtn,
      availableBtn,
      topRatedBtn
    ])
    filterBtnStack.axis = .horizontal
    filterBtnStack.spacing = 8
    filterBtnStack.alignment = .leading
    filterBtnStack.isLayoutMarginsRelativeArrangement = true
    filterBtnStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16)
    filterBtnStack.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(filterBtnStack)
    
  }
  
  
  private func setUpBtnTitles() {
    var container = AttributeContainer()
    container.font = UIFont(name: "Inter-Regular_Medium", size: 12) ?? UIFont(name: "Inter", size: 10)
    
    allLawyersBtn.configuration?.attributedTitle = AttributedString(
      "Todos",
      attributes: container
    )

    availableBtn.configuration?.attributedTitle = AttributedString(
      "Disponibles hoy",
      attributes: container
    )
    
    topRatedBtn.configuration?.attributedTitle = AttributedString(
        "Mejor valorados",
        attributes: container
    )
    
    
    
    
  }
  
  // MARK: - ACTIONS
  @objc func onAllLayersBtnPressed() {
    print("All lawyers is working")
  }
  
  @objc func onAvailableLawyersBtnPressed() {
    print("Available lawyers is working")
  }
 
  @objc func onTopRatedBtnPressed() {
    print("Top Rated lawyers is working")
  }
  
  
}
