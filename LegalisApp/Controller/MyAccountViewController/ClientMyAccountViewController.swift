//
//  ClientMyAccountViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 17/7/26.
//

import UIKit

class ClientMyAccountViewController: CoreCollectionViewController {

  
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
    
    NSLayoutConstraint.activate([
      logoImageNav.widthAnchor.constraint(equalToConstant: 120),
      logoImageNav.heightAnchor.constraint(equalToConstant: 40),
    ])
  }
  
  //MARK: - REGISTER CELLS
  func registerCells() {
    collectionView.register(MyAccountPhotoCollectionViewCell.self, forCellWithReuseIdentifier: MyAccountPhotoCollectionViewCell.identifier)
   
    collectionView.register(LawCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: LawCategoriesCollectionViewCell.identifier)
    
    collectionView.register(HeaderSecondSectionCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSecondSectionCollectionViewCell.identifier)
  }
  
  //MARK: - LAYOUT OF COLLECTION VIEW
  func configureLayout() {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
      return self.createSectionLayout(section: sectionIndex)
    }
    collectionView.setCollectionViewLayout(layout, animated: false)
    
  }
  
  func createMenuSection(itemCount: Int) -> NSCollectionLayoutSection {

      let item = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .absolute(44)
          )
      )

      let group = NSCollectionLayoutGroup.vertical(
          layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .absolute(CGFloat(itemCount) * 44)
          ),
          subitem: item,
          count: itemCount
      )

      group.contentInsets = NSDirectionalEdgeInsets(
          top: 0,
          leading: 15,
          bottom: 0,
          trailing: 15
      )

      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(
          top: 0,
          leading: 0,
          bottom: 20,
          trailing: 0
      )

      return section
  }
  
  
  func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
    
    let header = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .absolute(25)
        ),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .topLeading
      )
    ]
    
    guard let section = SectionMyAccount(rawValue: section) else {
      return createSectionLayout(section: 1)
    }
    
    switch section {
      
      //MARK: - Profile photo section
    case .profilePhoto:
        //firstItem
          let firstItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .estimated(240)
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
    
      //MARK: - Configuration Menu
    case .personalConfiguation:
      let section = createMenuSection(itemCount: 2)
      section.boundarySupplementaryItems = header
      
      return section
      //MARK: - configuration section
    case .settings:
        let section = createSectionLayout(section: 3)
      
      section.boundarySupplementaryItems = header
      return section
      //MARK: - logout section
    case .logout:

      let section =  createMenuSection(itemCount: 1)
      
      return section
      
    }//end switch
  }
  
}
   
//MARK: - DELEGATES
extension ClientMyAccountViewController: UICollectionViewDelegateFlowLayout {
  
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
      return 2
    case .settings:
      return 4
    case .logout:
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
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: MyAccountPhotoCollectionViewCell.identifier,
        for: indexPath) as? MyAccountPhotoCollectionViewCell else {
          return UICollectionViewCell()
      }
      
      return cell
   
    case .personalConfiguation, .settings, .logout:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: LawCategoriesCollectionViewCell.identifier,
        for: indexPath) as? LawCategoriesCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.backgroundColor = .white
      cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
      cell.layer.borderWidth = 1
      
    
      switch section {
      
      case .personalConfiguation:
        
        cell.configure(categories: person[indexPath.row])
        
      case .settings:

        cell.configure(categories: settings[indexPath.row])
        
      case .logout:
        
        cell.configure(categories: logout)
      
      case .profilePhoto:
        break
      }
      return cell
    }
    
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    
    guard let header = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: HeaderSecondSectionCollectionViewCell.identifier,
      for: indexPath) as? HeaderSecondSectionCollectionViewCell,
            kind == UICollectionView.elementKindSectionHeader else {
      return UICollectionReusableView()
    }
    guard let section = SectionMyAccount(rawValue: indexPath.section) else {
      return header
    }
    
    switch section {
      
    case .personalConfiguation:
      header.configure(with: titleHeaderMenu[0])
    case .settings:
      header.configure(with: titleHeaderMenu[1])
    default:
      break
    }
    return header
  }
  
}
