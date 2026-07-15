//
//  ListOfAppointmentsCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 15/7/26.
//

import UIKit

class ListOfAppointmentsCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "ListOfAppointmentsCollectionViewCell"
  
  private let userImage: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(named: "f")
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    img.tintColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    img.widthAnchor.constraint(equalToConstant: 60).isActive = true
    img.heightAnchor.constraint(equalToConstant: 60).isActive = true
    img.layer.cornerRadius = 30
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private let userNameLabel: UILabel = {
    let label = UILabel()
    label.text = "María Sanchez"
    label.numberOfLines = 0
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.font = UIFont(name: "Inter-Regular_SemiBold", size: 17)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let lawCategoryLabel: UILabel = {
    let label = UILabel()
    label.text = "Derecho civil"
    label.numberOfLines = 1
    label.font = UIFont(name: "Inter-Regular", size: 12)
    label.textColor = #colorLiteral(red: 0, green: 0.1370561421, blue: 0.2949633002, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let iconCalendar: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(named: "calendarGray")
    img.contentMode = .scaleAspectFit
    img.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    img.widthAnchor.constraint(equalToConstant: 13.5).isActive = true
    img.heightAnchor.constraint(equalToConstant: 15).isActive = true
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private let iconClock: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(systemName: "clock")
    img.contentMode = .scaleAspectFit
    img.tintColor = #colorLiteral(red: 0.3645370603, green: 0.3682664633, blue: 0.3890590072, alpha: 1)
    img.widthAnchor.constraint(equalToConstant: 15).isActive = true
    img.heightAnchor.constraint(equalToConstant: 15).isActive = true
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  lazy var menuBtn = UIButton()
  
  lazy var loginMeetBtn = UIButton()
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.text = "14/11/26"
    label.numberOfLines = 0
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.font = UIFont(name: "Inter-Regular", size: 17)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let timeLabel: UILabel = {
    let label = UILabel()
    label.text = "14:30 PM"
    label.numberOfLines = 0
    label.textColor = #colorLiteral(red: 0.1017038003, green: 0.1096047685, blue: 0.1221101061, alpha: 1)
    label.font = UIFont(name: "Inter-Regular", size: 17)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
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
    Utilities.customButtonStyle(loginMeetBtn,
                                appearance: .plain(),
                                title: "Unirse a Sesión",
                                image: nil,
                                imagePlacement: nil,
                                imagePadding: nil,
                                cornerRadius: 8,
                                cornerStyle: nil,
                                backgroundColor: #colorLiteral(red: 0, green: 0.1370561421, blue: 0.2949633002, alpha: 1),
                                baseForeground: .white,
                                width: nil,
                                height: nil,
                                target: self,
                                action: #selector(dipTapLoginVideoConference))
    loginMeetBtn.translatesAutoresizingMaskIntoConstraints = false
    
    Utilities.customButtonStyle(menuBtn,
                                appearance: .plain(),
                                title: nil,
                                image: UIImage(named: "menuPointIcon"),
                                imagePlacement: nil,
                                imagePadding: nil,
                                cornerRadius: 8,
                                cornerStyle: .capsule,
                                backgroundColor: nil,
                                baseForeground: nil,
                                width: 42,
                                height: 16,
                                target: self,
                                action: #selector(dipTapMenuTapped))
    menuBtn.layer.borderWidth = 1
    menuBtn.layer.borderColor = #colorLiteral(red: 0.7682896852, green: 0.7757481933, blue: 0.817332685, alpha: 1)
    menuBtn.translatesAutoresizingMaskIntoConstraints = false
    
  }
  
  private func setUpUI() {
    
    let nameScpecialityStack = UIStackView(arrangedSubviews: [
      userNameLabel,
      lawCategoryLabel
    ])
    nameScpecialityStack.axis = .vertical
    nameScpecialityStack.translatesAutoresizingMaskIntoConstraints = false
    
    let dateStack = UIStackView(arrangedSubviews: [
      iconCalendar,
      dateLabel
    ])
    dateStack.axis = .horizontal
    dateStack.spacing = 6
    dateStack.alignment = .center
    dateStack.translatesAutoresizingMaskIntoConstraints = false
    
    let timeStack = UIStackView(arrangedSubviews: [
      iconClock,
      timeLabel
    ])
    timeStack.axis = .horizontal
    timeStack.spacing = 6
    timeStack.alignment = .center
    timeStack.translatesAutoresizingMaskIntoConstraints = false
    
    let btnStack = UIStackView(arrangedSubviews: [
      loginMeetBtn,
      menuBtn
    ])
    btnStack.axis = .horizontal
    btnStack.spacing = 6
    btnStack.alignment = .center
    btnStack.translatesAutoresizingMaskIntoConstraints = false
    
    
    contentView.addSubview(userImage)
    contentView.addSubview(nameScpecialityStack)
    contentView.addSubview(dateStack)
    contentView.addSubview(timeStack)
    //contentView.addSubview(btnStack)
    contentView.addSubview(loginMeetBtn)
    contentView.addSubview(menuBtn)
    
    
    NSLayoutConstraint.activate([
      userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      
      
      nameScpecialityStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      nameScpecialityStack.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 16),
      nameScpecialityStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      
      dateStack.topAnchor.constraint(equalTo: nameScpecialityStack.bottomAnchor, constant: 20),
      dateStack.leadingAnchor.constraint(equalTo: userImage.leadingAnchor, constant: 75),
      
      
      timeStack.topAnchor.constraint(equalTo: nameScpecialityStack.bottomAnchor, constant: 20),
      timeStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      timeStack.leadingAnchor.constraint(equalTo: dateStack.trailingAnchor, constant: 16),
      
//      btnStack.topAnchor.constraint(equalTo: dateStack.bottomAnchor, constant: 20),
//      btnStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//      btnStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//      btnStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      
      loginMeetBtn.topAnchor.constraint(equalTo: dateStack.bottomAnchor, constant: 16),
      loginMeetBtn.trailingAnchor.constraint(equalTo: menuBtn.leadingAnchor, constant: -8),
      loginMeetBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      loginMeetBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      
      menuBtn.topAnchor.constraint(equalTo: dateStack.bottomAnchor, constant:16),
      menuBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      menuBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
      

    
    ])
  }
  
  @objc func dipTapLoginVideoConference() {
    print("ok")
  }
  
  @objc func dipTapMenuTapped() {
    print("ok")
  }
  
}
