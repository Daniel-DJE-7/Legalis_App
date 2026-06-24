//
//  ProfileLawyerCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 19/6/26.
//

import UIKit

enum SectionTypeProfile: Int, CaseIterable {
  case profileHeader = 0
  case professionalDescription = 1
  case contactPrice = 2
  case reviewsAndRatings = 3
  case appointment = 4
}

class ProfileLawyerCollectionViewController: CoreCollectionViewController {

  let rating = "4.9"
  let sectionTitles: [String] = ["PERFIL PROFESIONAL", "CONTACTO Y TARIFA", "RESEÑAS Y CALIFICACIONES"]
  var personalInformation: LawyersPersonalProfile?
  
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
    collectionView.register(ProfileLawyersCollectionViewCell.self, forCellWithReuseIdentifier: ProfileLawyersCollectionViewCell.identifier)
    
    collectionView.register(DescriptionCollectionViewCell.self, forCellWithReuseIdentifier: DescriptionCollectionViewCell.identifier)
    
    collectionView.register(ProfileDataCollectionViewCell.self, forCellWithReuseIdentifier: ProfileDataCollectionViewCell.identifier)
    
    collectionView.register(RatingCollectionViewCell.self, forCellWithReuseIdentifier: RatingCollectionViewCell.identifier)
    
    collectionView.register(AppointmentActionCollectionViewCell.self, forCellWithReuseIdentifier: AppointmentActionCollectionViewCell.identifier)
    
    collectionView.register(HeaderSecondSectionCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSecondSectionCollectionViewCell.identifier)
    
    collectionView.register(HeaderSectionsCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSectionsCollectionViewCell.identifier)
  }
  
  func configureLayout() {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
      return self.createSectionLayout(section: sectionIndex)
    }
    collectionView.setCollectionViewLayout(layout, animated: false)
    
  }
  
  func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
    
    let header = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(22)),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .topLeading)
    ]
    
    switch section {
      
      //MARK: - 1st Section
      case 0:
        //first Item
        let firstItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(460))
        )
      //group
      let firstGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: firstItem.layoutSize,
        subitems: [firstItem])
      
      let firstSection = NSCollectionLayoutSection(group: firstGroup)
      return firstSection
     
      //MARK: - 2nd section
      case 1:
      //item
      let secondtItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(200)
        )
      )
      //group
      let secondGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: secondtItem.layoutSize,
        subitems: [secondtItem]
      )
      //section
      let secondSection = NSCollectionLayoutSection(group: secondGroup)
      secondSection.boundarySupplementaryItems = header
      return secondSection
      
      //MARK: - 3rd section
      case 2:
      
      //item
      let thirdtItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .absolute(100)
        )
      )
      //group
      let thirdGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: thirdtItem.layoutSize,
        subitems: [thirdtItem]
      )
      //section
      let thirdSection = NSCollectionLayoutSection(group: thirdGroup)
      thirdSection.boundarySupplementaryItems = header
      return thirdSection
      
      //MARK: - 4th section
      case 3:
      //item
      let fourthItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(130)
        )
      )
      //group
      let fourthGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: fourthItem.layoutSize,
        subitems: [fourthItem]
      )
      fourthGroup.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
      
      //section
      let fourthSection = NSCollectionLayoutSection(group: fourthGroup)
      fourthSection.interGroupSpacing = 10
      fourthSection.boundarySupplementaryItems = header
      return fourthSection
      
      //MARK: - 5th section
      case 4:
      //item
      let fifthItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .absolute(87)
        )
      )
      //group
      let fifthGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: fifthItem.layoutSize,
        subitems: [fifthItem]
      )
     
//      fifthGroup.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
      
      //section
      let fifthSection = NSCollectionLayoutSection(group: fifthGroup)
      fifthSection.contentInsets = .init(top: 15, leading: 0, bottom: 0, trailing: 0)
      return fifthSection
      
      
      //MARK: - Default section
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
          subitem: defautltItem,
          count: 23
        )
        //section
        let defaultSection = NSCollectionLayoutSection(group: defaultGroup)
            
        return defaultSection
    }//End switch
    
  }
   
}//class ended


//MARK: DELEGATES

extension ProfileLawyerCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionTypeProfile.allCases.count
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    guard let section = SectionTypeProfile(rawValue: section) else { return 0 }
    
    switch section {
    case .profileHeader:
      return 1
    case .professionalDescription:
      return 1
    case .contactPrice:
      return 1
    case .reviewsAndRatings:
      return 2
    case .appointment:
      return 1
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let section = SectionTypeProfile(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    switch section {
    case .profileHeader:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileLawyersCollectionViewCell.identifier, for: indexPath) as? ProfileLawyersCollectionViewCell else {
        return UICollectionViewCell()
      }
      
      return cell
      
    case .professionalDescription:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DescriptionCollectionViewCell.identifier, for: indexPath) as? DescriptionCollectionViewCell else {
        return UICollectionViewCell()
      }
      return cell
      
    case .contactPrice:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileDataCollectionViewCell.identifier, for: indexPath) as? ProfileDataCollectionViewCell else {
        return UICollectionViewCell()
      }
      
      return cell
      
    case .reviewsAndRatings:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RatingCollectionViewCell.identifier, for: indexPath) as? RatingCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.layer.cornerRadius = 12
      cell.layer.borderColor = #colorLiteral(red: 0.7682896852, green: 0.7757481933, blue: 0.817332685, alpha: 1)
      cell.layer.borderWidth = 2
      cell.backgroundColor = .white
      return cell
      
    case .appointment:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppointmentActionCollectionViewCell.identifier, for: indexPath) as? AppointmentActionCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.backgroundColor = .white
      return cell
      
    }//end switch
  }//end func
  
  
  override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    guard let section = SectionTypeProfile(rawValue: indexPath.section) else {
      return UICollectionReusableView()
    }
    switch section {
    case .professionalDescription:
      
      guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSecondSectionCollectionViewCell.identifier, for: indexPath) as? HeaderSecondSectionCollectionViewCell, kind == UICollectionView.elementKindSectionHeader else {
        return UICollectionReusableView()
      }
      
      header.configure(with: sectionTitles[0])
      return header
      
    case .contactPrice:
      
      guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSecondSectionCollectionViewCell.identifier, for: indexPath) as? HeaderSecondSectionCollectionViewCell, kind == UICollectionView.elementKindSectionHeader else {
        return UICollectionReusableView()
      }
     
      header.configure(with: sectionTitles[1])
      return header
      
    case .reviewsAndRatings:
      guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSectionsCollectionViewCell.identifier, for: indexPath) as? HeaderSectionsCollectionViewCell, kind == UICollectionView.elementKindSectionHeader else {
        return UICollectionReusableView()
      }
      header.configure(with: sectionTitles[2], and: rating)
      
      return header
      
    default: return UICollectionReusableView()
    }
  }
  
}
