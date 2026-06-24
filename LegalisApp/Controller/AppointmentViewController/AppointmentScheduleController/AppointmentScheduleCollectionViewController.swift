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
}

class AppointmentScheduleCollectionViewController: CoreCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.backgroundColor = .systemGray6
      registerCells()
      configureLayout()
    }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  
  private func registerCells() {
    collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
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
          heightDimension: .estimated(500)
        )
      )
    //firstGroup
      let firstGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: firstItem.layoutSize,
        subitems: [firstItem]
      )
    //firstSection
      let firstSection = NSCollectionLayoutSection(group: firstGroup)
      return firstSection
      
      
    //MARK: - HOURS SECTION
    case 1:
      //secondItem
        let secondItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(500)
          )
        )
      //secondGroup
        let secondGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: secondItem.layoutSize,
          subitems: [secondItem]
        )
      //secondSection
        let secondSection = NSCollectionLayoutSection(group: secondGroup)
        return secondSection
      
    //MARK: - MODALITY SECTION
    case 2:
      //thirdItem
        let thirdItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(500)
          )
        )
      //thirdGroup
        let thirdGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: thirdItem.layoutSize,
          subitems: [thirdItem]
        )
      //thirdSection
        let thirdSection = NSCollectionLayoutSection(group: thirdGroup)
        return thirdSection
      
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
      return 1
    case .modality:
      return 1
    }
  }
}
