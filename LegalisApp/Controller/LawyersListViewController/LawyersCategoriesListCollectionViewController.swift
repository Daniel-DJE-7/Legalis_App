//
//  LawyersCategoriesListCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 13/6/26.
//

import UIKit

enum SectionLawyersList: Int, CaseIterable {
  case firstSection
  case secondSection
}

class LawyersCategoriesListCollectionViewController: CoreCollectionViewController {

  var categories: CategoriesModel?
  var lawyersCard: [LawyersCardsModel] = []
  
    
  override func viewDidLoad() {
        super.viewDidLoad()
    

    collectionView.backgroundColor = .systemGray6
    //configNavBar()
    registerCells()
    configureLayout()
    configureItemsInCells()
    }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
   
  }
  
  
  //Delegates and DataSource
  func configureItemsInCells() {
    lawyersCard = [
      LawyersCardsModel(profileImage: UIImage(named: "abog"), name: "Abelardo de la Espriella", qualification: "4.5"),
      LawyersCardsModel(profileImage: UIImage(named: "abog"), name: "Matha Perez", qualification: "4.0"),
      LawyersCardsModel(profileImage: UIImage(named: "abog"), name: "James Rodriguez", qualification: "4.9"),
      LawyersCardsModel(profileImage: UIImage(named: "abog"), name: "Omar Rueda", qualification: "4.6"),
      
    ]
  }
  
  //MARK: - REGISTER CELLS
  func registerCells() {
    //Header Section
    collectionView.register(LawyersListHeaderCollectionViewCell.self, forCellWithReuseIdentifier: LawyersListHeaderCollectionViewCell.identifier)
    //cards List section
    collectionView.register(LawyersListCollectionViewCell.self, forCellWithReuseIdentifier: LawyersListCollectionViewCell.identifier)
    //Header segementedControl btns section
    collectionView.register(FilterSectionCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilterSectionCollectionViewCell.identifier)
  }

  //MARK: - LAYOUT OF COLLECTION VIEW
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
          heightDimension: .absolute(54)
        ),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .topLeading
      )
    ]
    
    switch section {
    //MARK: - first section
    case 0:
      //first Item
      let firstItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(135)
        )
      )
      //second gruop
      let firstGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: firstItem.layoutSize,
        subitems: [firstItem])
      
      //second section
      let firstSection = NSCollectionLayoutSection(group: firstGroup)
      return firstSection
      
    case 1:
      //second Item
      let secondItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .absolute(420)
        )
      )
      //second group
      let secondGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: secondItem.layoutSize,
        subitems: [secondItem]
      )
      //secondGroup.interItemSpacing = .fixed(15)
      secondGroup.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
      //second section
      let secondSection = NSCollectionLayoutSection(group: secondGroup)
          secondSection.boundarySupplementaryItems = header
          secondSection.interGroupSpacing = 20
      return secondSection
      
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
      
    }//end switch
    
   
    
  }//end func section
  
}//end class

extension LawyersCategoriesListCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionLawyersList.allCases.count
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    guard let section = SectionLawyersList(rawValue: section) else { return 0 }
    
    switch section {
    case .firstSection:
      return 1
    case .secondSection:
      return 4
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let section = SectionLawyersList(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    switch section {
    case .firstSection:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LawyersListHeaderCollectionViewCell.identifier, for: indexPath) as? LawyersListHeaderCollectionViewCell else {
        return UICollectionViewCell()
      }
      //aqui pasamos el titulo de cada categoria al label
      if let category = categories {
        cell.configure(with: category)
      }
        
        return cell
      
    case .secondSection:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: LawyersListCollectionViewCell.identifier,
        for: indexPath) as? LawyersListCollectionViewCell else {
      return UICollectionViewCell()
      }
        
      let cards = lawyersCard[indexPath.row]
     
      
      cell.configure(with: cards, and: categories)
      
        return cell
      
    }//end switch
    
  }//end cell ofr Item
  
  override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    
    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FilterSectionCollectionViewCell.identifier, for: indexPath) as? FilterSectionCollectionViewCell, kind == UICollectionView.elementKindSectionHeader else {
      return UICollectionReusableView()
    }
//    header.delegate = self
    return header
    
  }
  
  
}//end extension


extension LawyersCategoriesListCollectionViewController: FilterSectionCollectionViewCellDelegate {
  
  func onFilterLawyerListBtnTapped(_ filter: LawyersFilter) {
    
    switch filter {
    case .all:
      print("all")
    case .available:
      print("available")
    case .topRated:
      print("top rated")
    
    }
    collectionView.reloadSections(IndexSet(integer: 1))
  }
  
}


//class TestClass1: UICollectionViewCell {
//  static let identifier = "testClass"
//}
//
//class TextClass2: UICollectionViewCell {
//  static let identifier = "testClass2"
//}
