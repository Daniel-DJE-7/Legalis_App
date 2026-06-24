//
//  CalendarCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 24/6/26.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "CalendarCollectionViewCell"
  
  let calendarView = UICalendarView()
  let gregorianCalendar = Calendar(identifier: .gregorian)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpCalendar() {
    calendarView.calendar = gregorianCalendar
    calendarView.locale = .current
    calendarView.fontDesign = .rounded
    calendarView.translatesAutoresizingMaskIntoConstraints = false
    
    
  }
  
  private func setUpUI() {
   
    contentView.addSubview(calendarView)
    
  }
  
}
