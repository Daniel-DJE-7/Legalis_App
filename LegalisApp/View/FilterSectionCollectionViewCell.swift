//
//  FilterSectionCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 16/6/26.
//

import UIKit

protocol FilterSectionCollectionViewCellDelegate: AnyObject {
  func onFilterLawyerListBtnTapped(_ filter: LawyersFilter)
}

class FilterSectionCollectionViewCell: UICollectionReusableView {
    
  static let identifier = "FilterSectionCollectionViewCell"
  weak var delegate: FilterSectionCollectionViewCellDelegate?
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    createSegmentedControl()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func createSegmentedControl() {
    let items = [
      "Todos",
      "Disponibles hoy",
      "Mejor valorados"
    ]
    
    let segmentedControl = UISegmentedControl(items: items)
    
    segmentedControl.addTarget(self,
                               action: #selector(onFilterLawyers(_:)),
                               for: .valueChanged)
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0, green: 0.1370561421, blue: 0.2949633002, alpha: 1)
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    segmentedControl.backgroundColor = .white
    segmentedControl.layer.borderColor = #colorLiteral(red: 0.7682896852, green: 0.7757481933, blue: 0.817332685, alpha: 1)
    segmentedControl.layer.borderWidth = 1.5
    
    segmentedControl.setTitleTextAttributes([ .foregroundColor : #colorLiteral(red: 0.5043179121, green: 0.7661390446, blue: 1, alpha: 1)], for: .selected)
    segmentedControl.setTitleTextAttributes([.foregroundColor : #colorLiteral(red: 0.262216866, green: 0.2779523134, blue: 0.3071090579, alpha: 1)], for: .normal)
    
    
    addSubview(segmentedControl)
    
    NSLayoutConstraint.activate([
      segmentedControl.topAnchor.constraint(equalTo: topAnchor),
      segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
    ])
    
  }
  
  @objc func onFilterLawyers(_ segmentedControl: UISegmentedControl) {
    
    guard let filter = LawyersFilter(rawValue: segmentedControl.selectedSegmentIndex) else { return }
    
    delegate?.onFilterLawyerListBtnTapped(filter)
    }
  }
