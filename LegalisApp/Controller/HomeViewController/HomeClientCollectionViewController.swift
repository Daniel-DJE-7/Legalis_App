//
//  HomeClientCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 9/6/26.
//

import UIKit

enum SectionType: Int, CaseIterable {
  case detailsOfappoinment
  case categories
}

class HomeClientCollectionViewController: CoreCollectionViewController {

  private let titleSecondSection = "ESPECIALIDADES"
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      configureNavBar()
      registerCells()
      configLayout()
      
    }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  
  //MARK: - Register cells
  func registerCells() {
    //first Section
    collectionView.register(TestClass.self, forCellWithReuseIdentifier: TestClass.identifier)
    //Second section
    collectionView.register(TestClass2.self, forCellWithReuseIdentifier: TestClass2.identifier)
    //Header of second Section
    collectionView.register(
      HeaderSecondSectionCollectionViewCell.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: HeaderSecondSectionCollectionViewCell.identifier)
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
    //navigationController?.navigationBar.backgroundColor = 
    
    
    NSLayoutConstraint.activate([
      logoImageNav.widthAnchor.constraint(equalToConstant: 120),
      logoImageNav.heightAnchor.constraint(equalToConstant: 40),
      rightBellBtn.widthAnchor.constraint(equalToConstant: 32),
      rightBellBtn.heightAnchor.constraint(equalToConstant: 32),
      
    ])
    }
  
  //MARK: - Collection Layout
  func configLayout() {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
      return self.createSectionLayout(section: sectionIndex)
    }
    collectionView.setCollectionViewLayout(layout, animated: false)
  }
  
  //MARK: - Sections of View
  func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
    
    //MARK: header
    let header = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .absolute(22)
        ),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .topLeading
      )
    ]
    
    switch section {
      
      //MARK: first section
      case 0:
        //item
        let firstItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(300))
        )
        
        //group
        let firstGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: firstItem.layoutSize,
          subitem: firstItem,
          count: 1
        )
        
        //Section
        let firstSection = NSCollectionLayoutSection(group: firstGroup)
        return firstSection
        
      //MARK: second section
      case 1:
        //item
        let secondItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(44 * 23))
        )
      secondItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0)
        
        //group
        let secondGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: secondItem.layoutSize,
          subitem: secondItem,
          count: 23
        )
      
        //section
        let secondSection = NSCollectionLayoutSection(group: secondGroup)
           secondSection.boundarySupplementaryItems = header
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
            defaultSection.boundarySupplementaryItems = header
        return defaultSection
      
    }//switch end
    
  }
  

  @objc private func onBellButtonTapped() {
    print("btn is working")
  }

}


extension HomeClientCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  //MARK: - Number of section
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionType.allCases.count
  }
  
  //MARK: - Number of items (cells) in section
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    
    guard let section = SectionType(rawValue: section) else { return 0 }
    
    switch section {
    case .detailsOfappoinment:
      return 1
    case .categories:
      return 23
    }
  }
  
  //MARK: - Creating cells
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let section = SectionType(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
     
    switch section {
      case .detailsOfappoinment:
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestClass.identifier, for: indexPath) as? TestClass else {
        return UICollectionViewCell()
      }
      cell.backgroundColor = .orange
      return cell
      
      case .categories:
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestClass.identifier, for: indexPath) as? TestClass else { return UICollectionViewCell()
      }
      cell.backgroundColor = .blue
      return cell
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    
    guard let header = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: HeaderSecondSectionCollectionViewCell.identifier,
      for: indexPath) as? HeaderSecondSectionCollectionViewCell, kind == UICollectionView.elementKindSectionHeader else {
      return UICollectionReusableView()
    }
    header.configure(with: titleSecondSection)
    return header
  }
  
  
}//Extension end





class TestClass: UICollectionViewCell {
  static let identifier = "testClass"
}

class TestClass2: UICollectionViewCell {
  static let identifier = "testClass2"
}
//diagramar las celdas con colores
//hacer header de second section
//aprender sobre la distribucion de la stackView
//averiguar porque no cambia el color del TabBar background
