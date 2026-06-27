//
//  CalendarCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 24/6/26.
//

import UIKit

protocol CalendarCollectionViewCellDelegate: AnyObject {
  func calendar(cell: CalendarCollectionViewCell, didSelect date: DateComponents?)
}

class CalendarCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "CalendarCollectionViewCell"
  
  weak var delegate: CalendarCollectionViewCellDelegate?
  
  var selectedDate: DateComponents?
  let calendarView = UICalendarView()
  let gregorianCalendar = Calendar(identifier: .gregorian)
  let view = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpCalendar()
    setUpUI()
    configureSelection()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpCalendar() {
    calendarView.calendar = gregorianCalendar
    calendarView.locale = .current
    calendarView.fontDesign = .rounded
    calendarView.tintColor = #colorLiteral(red: 0, green: 0.1370561421, blue: 0.2949633002, alpha: 1)
    
    calendarView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setUpUI() {
   
    view.backgroundColor = .white
    view.layer.cornerRadius = 12
    view.layer.borderColor = #colorLiteral(red: 0.7212437391, green: 0.7287658453, blue: 0.7661984563, alpha: 1)
    view.layer.borderWidth = 1
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(calendarView)
    
    contentView.addSubview(view)
    
    NSLayoutConstraint.activate([
      calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
      calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
      calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      view.widthAnchor.constraint(equalToConstant: 358)
    ])
  }
  
  func configureSelection() {
    
    let selection = UICalendarSelectionSingleDate(delegate: self)
    calendarView.selectionBehavior = selection
  }
  
}


extension CalendarCollectionViewCell: UICalendarSelectionSingleDateDelegate {
  func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
    selectedDate = dateComponents
    delegate?.calendar(cell: self, didSelect: dateComponents)
    
    calendarView.reloadDecorations(forDateComponents: [dateComponents!], animated: true)
  }
  
  
}
