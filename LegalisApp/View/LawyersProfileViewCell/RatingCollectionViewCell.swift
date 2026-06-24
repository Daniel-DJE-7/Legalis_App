//
//  RatingCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 23/6/26.
//

import UIKit

class RatingCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "RatingCollectionViewCell"
  
  
  let commentLabel: UILabel = {
    let label = UILabel()
    label.text = """
                aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                """
    label.numberOfLines = 20
    label.textColor = #colorLiteral(red: 0.262216866, green: 0.2779523134, blue: 0.3071090579, alpha: 1)
    label.font = UIFont(name: "Inter", size: 17)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let userNameLabel: UILabel = {
    let label = UILabel()
    label.text = "María Sanchez"
    label.numberOfLines = 0
    label.textColor = #colorLiteral(red: 0.262216866, green: 0.2779523134, blue: 0.3071090579, alpha: 1)
    label.font = UIFont(name: "Inter-Regular_semibold", size: 15)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  private let userImage: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(named: "f")
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    img.tintColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    img.widthAnchor.constraint(equalToConstant: 44).isActive = true
    img.heightAnchor.constraint(equalToConstant: 44).isActive = true
    img.layer.cornerRadius = 22
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  lazy var readRatingBtn = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpUI() {
   
    //MARK: - Star stack
    let starStack = UIStackView()
    starStack.axis = .horizontal
    starStack.spacing = 2
    starStack.translatesAutoresizingMaskIntoConstraints = false
    
    for _ in 0..<5 {
      let starIcon = UIImageView()
      starIcon.image = UIImage(systemName: "star.fill")
      starIcon.tintColor = .systemYellow
      starIcon.contentMode = .scaleAspectFit
      starIcon.widthAnchor.constraint(equalToConstant: 12).isActive = true
      starIcon.heightAnchor.constraint(equalToConstant: 12).isActive = true
      starIcon.translatesAutoresizingMaskIntoConstraints = false
      starStack.addArrangedSubview(starIcon)
    }
    
    //User stack
    let userStack = UIStackView(arrangedSubviews: [
      userImage,
      userNameLabel,
    ])
    userStack.axis = .horizontal
    userStack.spacing = 3
    userStack.backgroundColor = .white
    userStack.translatesAutoresizingMaskIntoConstraints = false
    
    
    contentView.addSubview(userStack)
    contentView.addSubview(starStack)
    contentView.addSubview(commentLabel)
    
    NSLayoutConstraint.activate([
      userStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      userStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

      starStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      starStack.leadingAnchor.constraint(equalTo: userStack.trailingAnchor, constant: 80),
      starStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      commentLabel.topAnchor.constraint(equalTo: userStack.bottomAnchor, constant: 8),
      commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    
    ])
    
  }
  
  @objc func dipTapReadingRatings() {
    print("ok")
  }
}
