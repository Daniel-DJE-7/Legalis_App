//
//  ProfileLawyersViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/7/26.
//

import UIKit

private enum SectionMyAccount: Int, CaseIterable {
  case profilePhoto
  case personalConfiguation
}


class MyAccountLawyerTableViewController: CoreCollectionViewController {

 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .systemGray6
    
    setUpNavBar()
    registerCells()
    configureLayout()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  
  //MARK: - SET UP NAVIGATION BAR
  private func setUpNavBar() {
   
    //Left btn
    let logoImageNav = UIImageView(image: UIImage(named: "logoHorizontal"))
    logoImageNav.contentMode = .scaleAspectFit
    logoImageNav.translatesAutoresizingMaskIntoConstraints = false
    
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoImageNav)
    
    let rightBellBtn = UIButton(type: .system)
    rightBellBtn.setImage(UIImage(named: "personGray"), for: .normal)
    rightBellBtn.imageView?.contentMode = .scaleAspectFit
    rightBellBtn.addTarget(self, action: #selector(onPersonBtnTapped), for: .touchUpInside)
    rightBellBtn.translatesAutoresizingMaskIntoConstraints = false
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBellBtn)
    //navigationController?.navigationBar.backgroundColor =
    
    
    NSLayoutConstraint.activate([
      logoImageNav.widthAnchor.constraint(equalToConstant: 120),
      logoImageNav.heightAnchor.constraint(equalToConstant: 40),
      rightBellBtn.widthAnchor.constraint(equalToConstant: 32),
      rightBellBtn.heightAnchor.constraint(equalToConstant: 32),
      
    ])
    }
  
  @objc func onPersonBtnTapped() {
    print("ok")
  }
  
  //MARK: - REGISTER CELLS
  func registerCells() {
    collectionView.register(MyAccountLawyerCollectionViewCell.self, forCellWithReuseIdentifier: MyAccountLawyerCollectionViewCell.identifier)
   
    collectionView.register(LawCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: LawCategoriesCollectionViewCell.identifier)
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
      
      //MARK: - Header section
      case 0:
        //firstItem
          let firstItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .estimated(300)
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
    
      //MARK: - Payment summary section
      case 1:
        //second Item
        let secondItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(370)
          )
        )
        //second group
        let secondGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: secondItem.layoutSize,
          subitems: [secondItem]
        )
        
        secondGroup.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
        //second section
        let secondSection = NSCollectionLayoutSection(group: secondGroup)
        return secondSection
     
      //MARK: - Button section
      case 2:
        //second Item
        let thirdItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(54)
          )
        )
        //second group
        let thirdGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: thirdItem.layoutSize,
          subitems: [thirdItem]
        )
  
        //second section
        let thirdSection = NSCollectionLayoutSection(group: thirdGroup)
            thirdSection.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
        return thirdSection
      
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
  }
  
}


  


extension MyAccountLawyerTableViewController: UICollectionViewDelegateFlowLayout {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionMyAccount.allCases.count
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    guard let section = SectionMyAccount(rawValue: section) else { return 0 }
    switch section {
    case .profilePhoto:
     return 1
    case .personalConfiguation:
     return 1
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let section = SectionMyAccount(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    switch section {
    case .profilePhoto:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyAccountLawyerCollectionViewCell.identifier, for: indexPath) as? MyAccountLawyerCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.backgroundColor = .systemGray3
      return cell
   
    case .personalConfiguation:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LawCategoriesCollectionViewCell.identifier, for: indexPath) as? LawCategoriesCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.backgroundColor = .white
      cell.layer.cornerRadius = 12
      cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
      cell.layer.borderWidth = 1
      return cell
    
    }
  }
}





