//
//  AppointmentCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 24/6/26.
//

import UIKit

private enum SectionAppointment: Int, CaseIterable {
  case calendar
  case appointments
}

class AppointmentNavItemCollectionViewController: CoreCollectionViewController {

  //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
      
      collectionView.backgroundColor = .systemGray6
      configureNavBar()
      registerCells()
      configureLayout()
    }
  
  
  //MARK: - ViewDidLayoutSubviews
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }

  //MARK: - Configuration of NAVBAR
  func configureNavBar() {
    //Left btn
    let logoImageNav = UIImageView(image: UIImage(named: "logoHorizontal"))
    logoImageNav.contentMode = .scaleAspectFit
    logoImageNav.translatesAutoresizingMaskIntoConstraints = false
    
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoImageNav)
    
    let rightBellBtn = UIButton(type: .system)
    rightBellBtn.setImage(UIImage(named: "bellBlue"), for: .normal)
    rightBellBtn.imageView?.contentMode = .scaleAspectFit
    rightBellBtn.addTarget(self, action: #selector(onBellButtonTapped), for: .touchUpInside)
    rightBellBtn.translatesAutoresizingMaskIntoConstraints = false
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBellBtn)
    
    
    NSLayoutConstraint.activate([
      logoImageNav.widthAnchor.constraint(equalToConstant: 120),
      logoImageNav.heightAnchor.constraint(equalToConstant: 40),
      rightBellBtn.widthAnchor.constraint(equalToConstant: 32),
      rightBellBtn.heightAnchor.constraint(equalToConstant: 32),
      
    ])
  }
  
  //MARK: - Bell btn action
  @objc private func onBellButtonTapped() {
    print("btn is working")
  }
  
  
  //MARK: - Register cells
  private func registerCells() {
    collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
    
    collectionView.register(ListOfAppointmentsCollectionViewCell.self, forCellWithReuseIdentifier: ListOfAppointmentsCollectionViewCell.identifier)
    
  }
  
  //MARK: - ConfigureLayout
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
      
      
    //MARK: - APPOINTMENT SECTION
    case 1:
      //secondItem
        let secondItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(154)
          )
        )
//      secondItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
      
      //secondGroup
      
        let secondVerticalGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: secondItem.layoutSize,
          subitem: secondItem,
          count: 1
        )
      
      secondVerticalGroup.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
     
      
      //secondSection
        let secondSection = NSCollectionLayoutSection(group: secondVerticalGroup)
            secondSection.interGroupSpacing = 10
       
        return secondSection
      
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

extension AppointmentNavItemCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionAppointment.allCases.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    guard let section = SectionAppointment(rawValue: section) else { return 0 }
    
    switch section {
    case .calendar:
      return 1
    case .appointments:
      return 3
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let section = SectionAppointment(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    switch section {
    case .calendar:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else {
        return UICollectionViewCell()
      }
      
      return cell
      
    case .appointments:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListOfAppointmentsCollectionViewCell.identifier, for: indexPath) as? ListOfAppointmentsCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.layer.cornerRadius = 12
      cell.layer.borderColor = #colorLiteral(red: 0.7682896852, green: 0.7757481933, blue: 0.817332685, alpha: 1)
      cell.layer.borderWidth = 1
      cell.backgroundColor = .white
      return cell
    }
  }
  
  
}
