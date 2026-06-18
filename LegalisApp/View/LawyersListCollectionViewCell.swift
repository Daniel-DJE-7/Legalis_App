//
//  LawyersListCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 18/6/26.
//

import UIKit

class LawyersListCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "LawyersListCollectionViewCell"
  
  // lawyer image
  let lawyerImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    
    return image
  }()
  
  //lawyer name
  private let lawyerNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Pedro Martinez"
    label.numberOfLines = 1
    label.font = UIFont(name: "Inter", size: 17)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //star icon
  private let starIcon: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(systemName: "star.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 11, weight: .medium))
    image.tintColor = #colorLiteral(red: 0.9603124261, green: 0.6186304092, blue: 0.0467768535, alpha: 1)
    image.contentMode = .scaleAspectFit
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  //qualification of lawyer
  private let qualificationLabel: UILabel = {
    let label = UILabel()
    label.text = "0.0"
    label.font = UIFont(name: "Inter-Regular_Bold", size: 12)
    label.textColor = #colorLiteral(red: 0.9603124261, green: 0.6186304092, blue: 0.0467768535, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //lawyer category label
  private let lawCategoryLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Inter-Regular", size: 13)
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //Favorite btn
  lazy var heartBtn: UIButton = {
    
    var config = UIButton.Configuration.plain()
    config.image = UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
    config.baseForegroundColor = .systemBackground
    
    let button = UIButton(configuration: config)
    button.addTarget(self, action: #selector(onFavoriteBtnTapped), for: .touchUpInside)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  //profile btn
  let lawyerProfileBtn = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpProfileBtn()
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpProfileBtn() {
    
    Utilities.customButtonStyle(lawyerProfileBtn,
                                appearance: .plain(),
                                title: "Ver perfil",
                                image: nil,
                                imagePlacement: nil,
                                imagePadding: nil,
                                cornerRadius: 10,
                                cornerStyle: nil,
                                backgroundColor: UIColor(
                                  red: 0,
                                  green: 0.09493184835,
                                  blue: 0.2154307365,
                                  alpha: 1),
                                baseForeground: .white,
                                width: nil,
                                height: 40,
                                target: self,
                                action: #selector(onProfileBtnTapped))
    
  }
  
  func setUpUI() {
    
    
    let qualificationStack = UIStackView(arrangedSubviews: [
      starIcon,
      qualificationLabel
    ])
    qualificationStack.axis = .horizontal
    qualificationStack.translatesAutoresizingMaskIntoConstraints = false
    
    let nameQualificationStack = UIStackView(arrangedSubviews: [
    lawyerNameLabel,
    qualificationStack
    ])
    nameQualificationStack.axis = .horizontal
    nameQualificationStack.spacing = 8
    
    nameQualificationStack.translatesAutoresizingMaskIntoConstraints = false
    
    let detailsStack = UIStackView(arrangedSubviews: [
      nameQualificationStack,
      lawCategoryLabel
    ])
    detailsStack.axis = .vertical
    detailsStack.spacing = 5
    detailsStack.translatesAutoresizingMaskIntoConstraints = false
    
    let fullDetailsStack = UIStackView(arrangedSubviews: [
      detailsStack,
      lawyerProfileBtn
    ])
    fullDetailsStack.axis = .vertical
    fullDetailsStack.spacing = 7
    fullDetailsStack.isLayoutMarginsRelativeArrangement = true
    fullDetailsStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    fullDetailsStack.translatesAutoresizingMaskIntoConstraints = false
    
    let globalStack = UIStackView(arrangedSubviews: [
      lawyerImage,
      fullDetailsStack
    ])
    globalStack.axis = .vertical
    globalStack.spacing = 5
    globalStack.distribution = .fill
    globalStack.backgroundColor = .white
    globalStack.layer.cornerRadius = 12
    globalStack.clipsToBounds = true
    globalStack.translatesAutoresizingMaskIntoConstraints = false
    
    lawyerImage.addSubview(heartBtn)
    lawyerImage.isUserInteractionEnabled = true
    
    contentView.addSubview(globalStack)
    
    NSLayoutConstraint.activate([

      globalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
      globalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      globalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      globalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      nameQualificationStack.heightAnchor.constraint(equalToConstant: 22),

      
      heartBtn.topAnchor.constraint(equalTo: lawyerImage.topAnchor, constant: 5),
      heartBtn.trailingAnchor.constraint(equalTo: lawyerImage.trailingAnchor, constant: -5),
     
    ])
  }
  
  
  func configure(with lawyersCard: LawyersCardsModel,
                 and category: CategoriesModel?) {
    
    lawCategoryLabel.text = category?.name//name of category selected
    lawyerImage.image = lawyersCard.profileImage
    lawyerNameLabel.text = lawyersCard.name
    qualificationLabel.text = lawyersCard.qualification
  }
  
  
  //MARK: - Actions
 @objc func onFavoriteBtnTapped() {
    print("You added this lwayer to your wishList")
  }
  
  @objc func onProfileBtnTapped() {
    print("You want to see the profile of the lawyer")
  }
  
}
/*
  Inter
  Inter-Regular
  Inter-Regular_Thin
  Inter-Regular_ExtraLight
  Inter-Regular_Light
  Inter-Regular_Medium
  Inter-Regular_SemiBold
  Inter-Regular_Bold
  Inter-Regular_ExtraBold
  Inter-Regular_Black
  */
