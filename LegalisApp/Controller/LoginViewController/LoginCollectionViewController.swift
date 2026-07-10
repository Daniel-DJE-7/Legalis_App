//
//  LoginCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 10/7/26.
//

import UIKit



class LoginCollectionViewController: CoreCollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .systemGray6
    collectionView.isScrollEnabled = false
    registerCells()
    configureLayout()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
    
  }

  //MARK: - REGISTER CELLS
  func registerCells() {
    collectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: LoginCollectionViewCell.identifier)
  }

  //MARK: - LAYOUT OF COLLECTION VIEW
  func configureLayout() {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
      return self.createSectionLayout(section: sectionIndex)
    }
    collectionView.setCollectionViewLayout(layout, animated: false)
    
  }
  
  func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
    
        //firstItem
          let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .fractionalHeight(1)
            )
          )
        //firstGroup
          let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: item.layoutSize,
            subitems: [item]
          )
          
        //firstSection
          let section = NSCollectionLayoutSection(group: group)
          return section
    
  
  }
  
}

extension LoginCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
   return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginCollectionViewCell.identifier, for: indexPath) as? LoginCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.backgroundColor = .orange
    return cell
  }
}

