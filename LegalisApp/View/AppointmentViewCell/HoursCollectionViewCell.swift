//
//  HoursCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 25/6/26.
//

import UIKit

class HoursCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "HoursCollectionViewCell"
  
  let hourLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular", size: 14)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private func setUpUI() {
    contentView.addSubview(hourLabel)
    
    NSLayoutConstraint.activate([
      hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      hourLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
    
  }
}
