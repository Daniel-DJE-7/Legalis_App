//
//  HomeClientCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 9/6/26.
//

import UIKit


class HomeClientCollectionViewController: CoreCollectionViewController {

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
    collectionView.register(TestClass.self, forCellWithReuseIdentifier: "cell")
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
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(250))
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
          widthDimension: .fractionalWidth(0.9),
          heightDimension: .absolute(475))
        )
        
        //group
        let secondGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: secondItem.layoutSize,
          subitems: [secondItem])
        
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
          count: 1
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

class TestClass: UICollectionViewCell {
  static let identifier = "testClass"
}


//diagramar las celdas con colores
//hacer header de second section
//aprender sobre la distribucion de la stackView
//averiguar porque no cambia el color del TabBar background
