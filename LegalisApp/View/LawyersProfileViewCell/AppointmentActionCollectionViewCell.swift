//
//  AppointmentActionCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 23/6/26.
//

import UIKit

protocol AppointmentActionCollectionViewCellDelegate: AnyObject {
  func onAppointmentBtnTapped()
}

class AppointmentActionCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "AppointmentActionCollectionViewCell"
  weak var delegate: AppointmentActionCollectionViewCellDelegate?
  
  let appointmentBtn = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setUpUI() {
    Utilities.customButtonStyle(appointmentBtn,
                                appearance: .plain(),
                                title: "Agendar Cita",
                                image: UIImage(named: "calendarWhite"),
                                imagePlacement: .leading,
                                imagePadding: 5,
                                cornerRadius: 12,
                                cornerStyle: nil,
                                backgroundColor: #colorLiteral(
                                  red: 0,
                                  green: 0.1370561421,
                                  blue: 0.2949633002,
                                  alpha: 1),
                                baseForeground: .white,
                                width: nil,
                                height: nil,
                                target: self,
                                action: #selector(dipTapAppointment))
    
    
 
    contentView.addSubview(appointmentBtn)
    appointmentBtn.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 17, right: 16))
  }
  
  
  @objc
  func dipTapAppointment() {
    delegate?.onAppointmentBtnTapped()
  }
  
}
