//
//  AppointmentScheduleCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 24/6/26.
//

import UIKit

enum SectionTypeAppointment: Int, CaseIterable {
  case calendar = 0
  case hours = 1
  case modality = 2
  case continueBtn = 3
}

class AppointmentScheduleCollectionViewController: CoreCollectionViewController {

  var selectedDate: DateComponents?
  
  let hours: [String] = [
    "8:30 AM",
    "9:30 AM",
    "10:30 AM",
    "11:30 AM",
    "1:30 PM",
    "2:30 PM",
    "3:30 PM",
    "4:30 PM"
  ]
  
    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.backgroundColor = .systemGray6
      navigationItem.title = "Citas"
      navigationController?.navigationBar.prefersLargeTitles = true
      navigationItem.largeTitleDisplayMode = .always
      navigationController?.navigationBar.topItem?.backButtonTitle = "Volver"
      registerCells()
      configureLayout()
    }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  
  private func registerCells() {
    collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
    
    collectionView.register(HoursCollectionViewCell.self, forCellWithReuseIdentifier: HoursCollectionViewCell.identifier)
    
    collectionView.register(ModalityCollectionViewCell.self, forCellWithReuseIdentifier: ModalityCollectionViewCell.identifier)
    
    collectionView.register(ContinueButtonCollectionViewCell.self, forCellWithReuseIdentifier: ContinueButtonCollectionViewCell.identifier)
  }
  
  private func configureLayout() {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
      return self.createSection(section: sectionIndex)
    }
    collectionView.setCollectionViewLayout(layout, animated: false)
  }
  
  private func createSection(section: Int) -> NSCollectionLayoutSection {
   
    let header = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(22)),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .topLeading)
    ]
    
    switch section {
    //MARK: - CALENDAR SECTION
    case 0:
    //firstItem
      let firstItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(350)
        )
      )
    //firstGroup
      let firstGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: firstItem.layoutSize,
        subitems: [firstItem]
      )
      
    //firstSection
      let firstSection = NSCollectionLayoutSection(group: firstGroup)

      firstSection.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 17, bottom: 15, trailing: 0)
      return firstSection
      
      
    //MARK: - HOURS SECTION
    case 1:
      //secondItem
        let secondItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(45)
          )
        )
      secondItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
      
      //secondGroup
      
        let secondVerticalGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(45)
          ),
          subitem: secondItem,
          count: 1
        )
      
//      secondVerticalGroup.contentInsets = .init(top: 0, leading: 17, bottom: 0, trailing: 16)
      
      let secondHorizontalGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .absolute(45)
        ),
        subitem: secondVerticalGroup,
        count: 3
      )
      secondHorizontalGroup.contentInsets = .init(top: 0, leading: 17, bottom: 0, trailing: 16)
      
      //secondSection
        let secondSection = NSCollectionLayoutSection(group: secondHorizontalGroup)
            secondSection.interGroupSpacing = 5
       
        return secondSection
      
    //MARK: - MODALITY SECTION
    case 2:
      //thirdItem
        let thirdItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(105)
          )
        )
      
      //thirdGroup
        let thirdGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: thirdItem.layoutSize,
          subitem: thirdItem,
          count: 1
        )
      
      thirdGroup.interItemSpacing = .fixed(5)
      //thirdSection
        let thirdSection = NSCollectionLayoutSection(group: thirdGroup)
      thirdSection.contentInsets = .init(top: 16, leading: 17, bottom: 16, trailing: 16)
        return thirdSection
      
    //MARK: - btn
    case 3:
      let fourthtItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .absolute(54)
        )
      )
      //group
      let fourhtGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: fourthtItem.layoutSize,
        subitems: [fourthtItem]
      )
      fourhtGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
      //section
      let fourthSection = NSCollectionLayoutSection(group: fourhtGroup)
          
      return fourthSection
      
    //MARK: - DEFAULT SECTION
    default:
      //item
      let defautltItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .estimated(140),
          heightDimension: .absolute(200)
        )
      )
      //group
      let defaultGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: defautltItem.layoutSize,
        subitems: [defautltItem]
      )
      //section
      let defaultSection = NSCollectionLayoutSection(group: defaultGroup)
          
      return defaultSection
    }
  }

}

extension AppointmentScheduleCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionTypeAppointment.allCases.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let section = SectionTypeAppointment(rawValue: section) else { return 0 }
    
    switch section {
    case .calendar:
      return 1
    case .hours:
      return 8
    case .modality:
      return 1
    case .continueBtn:
      return 1
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let section = SectionTypeAppointment(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    switch section {
    case .calendar:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.delegate = self
      
      return cell
      
    case .hours:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HoursCollectionViewCell.identifier, for: indexPath) as? HoursCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.layer.cornerRadius = 8
      cell.layer.borderColor = #colorLiteral(red: 0.7212437391, green: 0.7287658453, blue: 0.7661984563, alpha: 1)
      cell.layer.borderWidth = 1
      cell.backgroundColor = .white
      cell.hourLabel.text = hours[indexPath.item]
      return cell
      
    case .modality:
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModalityCollectionViewCell.identifier, for: indexPath) as? ModalityCollectionViewCell else {
        return UICollectionViewCell()
      }
      
      return cell
    
    case .continueBtn:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContinueButtonCollectionViewCell.identifier, for: indexPath) as? ContinueButtonCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: Utilities().titleBtn)
      cell.delegate = self
      return cell
    }
  }
  
  
}

extension AppointmentScheduleCollectionViewController: CalendarCollectionViewCellDelegate {
  
  func calendar(cell: CalendarCollectionViewCell, didSelect date: DateComponents?) {
    print(date)
  }
}


extension AppointmentScheduleCollectionViewController: ContinueButtonCollectionViewCellDelegate {
 
  func onContinueBtnTapped() {
    let vc = PaymentSummaryCollectionViewController()
    let nav = UINavigationController(rootViewController: vc)
    
    nav.modalPresentationStyle = .pageSheet
    //get the sheet
    if let sheet = nav.sheetPresentationController{
      sheet.detents = [.custom { context in
        return context.maximumDetentValue * 0.8}
      ]
      sheet.prefersScrollingExpandsWhenScrolledToEdge = true
      sheet.prefersGrabberVisible = true
      sheet.preferredCornerRadius = 30
    }
    
    navigationController?.present(nav, animated: true)
  }
  
  
}
