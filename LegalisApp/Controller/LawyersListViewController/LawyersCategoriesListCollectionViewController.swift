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

   var categories: categoriesModel?
  
    
  override func viewDidLoad() {
        super.viewDidLoad()
    

    collectionView.backgroundColor = .systemGray6
    //configNavBar()
    registerCells()
    configureLayout()
    }

  override func viewDidLayoutSubviews() {
    super.viewDidLoad()
    collectionView.frame = view.bounds
   
  }
  
  
  //MARK: - REGISTER CELLS
  func registerCells() {
    collectionView.register(LawyersListCollectionViewCell.self, forCellWithReuseIdentifier: LawyersListCollectionViewCell.identifier)
    collectionView.register(TextClass2.self, forCellWithReuseIdentifier: TextClass2.identifier)
  }

  //MARK: - LAYOUT OF COLLECTION VIEW
  func configureLayout() {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
      return self.createSectionLayout(section: sectionIndex)
    }
    collectionView.setCollectionViewLayout(layout, animated: false)
    
  }
  
  func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
    
    switch section {
    //MARK: - first section
    case 0:
      //first Item
      let firstItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(200)
        )
      )
      
      let firstGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: firstItem.layoutSize,
        subitems: [firstItem])
      
      let firstSection = NSCollectionLayoutSection(group: firstGroup)
      return firstSection
      
    case 1:
      //first Item
      let secondItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .absolute(1344)
        )
      )
      
      let secondGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: secondItem.layoutSize,
        subitems: [secondItem]
      )
      
      let secondSection = NSCollectionLayoutSection(group: secondGroup)
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
      return 1
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let section = SectionLawyersList(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    switch section {
    case .firstSection:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LawyersListCollectionViewCell.identifier, for: indexPath) as? LawyersListCollectionViewCell else {
        return UICollectionViewCell()
      }
      //aqui pasamos el titulo de cada categoria al label
      if let category = categories {
        cell.configure(with: category)
      }
        
        return cell
      
    case .secondSection:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextClass2.identifier, for: indexPath) as? TextClass2 else {
      return UICollectionViewCell()
      }
        cell.backgroundColor = .purple
        return cell
      
    }//end switch
    
    
  }
  
  
}//end extension


class TestClass1: UICollectionViewCell {
  static let identifier = "testClass"
}

class TextClass2: UICollectionViewCell {
  static let identifier = "testClass2"
}
