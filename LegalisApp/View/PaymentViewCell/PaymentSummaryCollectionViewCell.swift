//
//  PaymentSummaryCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 30/6/26.
//

import UIKit

class PaymentSummaryCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "PaymentSummaryCollectionViewCell"
  
  
  private let counsilLabel: UILabel = {
    let label = UILabel()
    label.text = "Consulta:"
    label.textAlignment = .left
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 17)
    label.textColor = #colorLiteral(red: 0.002019579057, green: 0.05263461918, blue: 0.139893055, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //lawyer category label
  private let lawCategoryLabel: UILabel = {
    let label = UILabel()
    label.text = "Derecho Civil"
    label.font = UIFont(name: "Inter-Regular", size: 12)
    label.textAlignment = .center
    label.textColor = #colorLiteral(red: 0, green: 0.1063321754, blue: 0.2393084168, alpha: 1)
    label.backgroundColor = #colorLiteral(red: 0.8413734436, green: 0.892358005, blue: 0.9964202046, alpha: 1)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let lawyerImage: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(named: "abog")
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    img.tintColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    img.widthAnchor.constraint(equalToConstant: 88).isActive = true
    img.heightAnchor.constraint(equalToConstant: 88).isActive = true
    img.layer.cornerRadius = 44
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private let personIcon: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(systemName: "person")
    img.contentMode = .scaleAspectFit
    img.clipsToBounds = true
    img.tintColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    img.backgroundColor = #colorLiteral(red: 0.870526135, green: 0.870217979, blue: 0.8909905553, alpha: 1)
    img.layer.cornerRadius = 4
    img.widthAnchor.constraint(equalToConstant: 24).isActive = true
    img.heightAnchor.constraint(equalToConstant: 24).isActive = true
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private let timerIcon: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(systemName: "timer")
    img.contentMode = .scaleAspectFit
    img.clipsToBounds = true
    img.tintColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    img.backgroundColor = #colorLiteral(red: 0.870526135, green: 0.870217979, blue: 0.8909905553, alpha: 1)
    img.layer.cornerRadius = 4
    img.widthAnchor.constraint(equalToConstant: 24).isActive = true
    img.heightAnchor.constraint(equalToConstant: 24).isActive = true
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  
  private let professionalLabel: UILabel = {
    let label = UILabel()
    label.text = "PROFESIONAL"
    label.font = UIFont(name: "Inter-Regular", size: 12)
    label.textAlignment = .left
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let lawyerNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Pedro Martinez"
    label.numberOfLines = 1
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 17)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let timeLabel: UILabel = {
    let label = UILabel()
    label.text = "DURACIÓN"
    label.font = UIFont(name: "Inter-Regular", size: 12)
    label.textAlignment = .left
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let hoursLabel: UILabel = {
    let label = UILabel()
    label.text = "120"
    label.numberOfLines = 0
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 17)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.heightAnchor.constraint(equalToConstant: 22).isActive = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let minutesLabel: UILabel = {
    let label = UILabel()
    label.text = "minutos"
    label.numberOfLines = 1
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 17)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  private let totalLabel: UILabel = {
    let label = UILabel()
    label.text = "TOTAL"
    label.font = UIFont(name: "Inter-Regular", size: 12)
    label.textAlignment = .left
    label.textColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let currencySymbolLabel: UILabel = {
    let label = UILabel()
    label.text = "$"
    label.numberOfLines = 0
    label.font = UIFont(name: "Inter-Regular_Bold", size: 34)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.heightAnchor.constraint(equalToConstant: 41).isActive = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.text = "150000"
    label.numberOfLines = 0
    label.font = UIFont(name: "Inter-Regular_Bold", size: 34)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.heightAnchor.constraint(equalToConstant: 41).isActive = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let currencyTypeLabel: UILabel = {
    let label = UILabel()
    label.text = "COP"
    label.numberOfLines = 0
    label.font = UIFont(name: "Inter-Regular_Bold", size: 34)
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.heightAnchor.constraint(equalToConstant: 41).isActive = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let divider = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpUI() {
    
    Utilities.divider(divider,
                      backgroundColor: #colorLiteral(
                        red: 0.7682896852,
                        green: 0.7757481933,
                        blue: 0.817332685,
                        alpha: 1),
                      height: 1)
    
    
    let categoryStack = UIStackView(arrangedSubviews: [
      counsilLabel,
      lawCategoryLabel
    ])
    categoryStack.axis = .vertical
    categoryStack.spacing = 5
    categoryStack.translatesAutoresizingMaskIntoConstraints = false
    
    let categoryPhotoStack = UIStackView(arrangedSubviews: [
      categoryStack,
      lawCategoryLabel
    ])
    categoryPhotoStack.axis = .horizontal
    categoryPhotoStack.translatesAutoresizingMaskIntoConstraints = false
    
    //MARK: - PROFESSIONAL STACKVIEW
    let professionalStack = UIStackView(arrangedSubviews: [
      professionalLabel,
      lawyerNameLabel
    ])
    professionalStack.axis = .vertical
    professionalStack.translatesAutoresizingMaskIntoConstraints = false
    
  
    
    //MARK: - TIME STACKVIEW
    let hourStack = UIStackView(arrangedSubviews: [
      hoursLabel,
      minutesLabel
    ])
    hourStack.axis = .horizontal
    hourStack.spacing = 3
    hourStack.translatesAutoresizingMaskIntoConstraints = false
    
    
    let timeStack = UIStackView(arrangedSubviews: [
      timeLabel,
      hourStack
    ])
    timeStack.axis = .vertical
    timeStack.translatesAutoresizingMaskIntoConstraints = false
  
    
    let priceStack = UIStackView(arrangedSubviews: [
      priceLabel,
      currencyTypeLabel
    ])
    priceStack.axis = .horizontal

    priceStack.translatesAutoresizingMaskIntoConstraints = false
    
   
    
   
    
    contentView.addSubview(categoryStack)
    contentView.addSubview(lawyerImage)
    contentView.addSubview(personIcon)
    contentView.addSubview(professionalStack)
    contentView.addSubview(timerIcon)
    contentView.addSubview(timeStack)
    contentView.addSubview(divider)
    contentView.addSubview(priceStack)
    
    
    NSLayoutConstraint.activate([
      
      categoryStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
      categoryStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
      
      lawyerImage.leadingAnchor.constraint(equalTo: categoryStack.trailingAnchor, constant: 10),
      lawyerImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
      lawyerImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
     
      lawCategoryLabel.heightAnchor.constraint(equalToConstant: 24),
      
      personIcon.topAnchor.constraint(equalTo: categoryStack.bottomAnchor, constant: 72),
      personIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
      
      professionalStack.topAnchor.constraint(equalTo: categoryStack.bottomAnchor, constant: 68),
      professionalStack.leadingAnchor.constraint(equalTo: personIcon.trailingAnchor, constant: 10),
      professionalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
      
      timerIcon.topAnchor.constraint(equalTo: personIcon.bottomAnchor, constant: 40),
      timerIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
      
      timeStack.topAnchor.constraint(equalTo: professionalStack.bottomAnchor, constant: 28),
      timeStack.leadingAnchor.constraint(equalTo: timerIcon.trailingAnchor, constant: 10),
      timeStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
     
      
      divider.topAnchor.constraint(equalTo: timeStack.bottomAnchor, constant: 40),
      divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
      divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
      
      priceStack.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 24),
      priceStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
      priceStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
      
    ])
  }
  
  
  
}
