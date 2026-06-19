//
//  FavoriteCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 19/6/26.
//

import UIKit



class FavoriteCollectionViewController: CoreCollectionViewController {

  fileprivate let searchBarController = UISearchController(searchResultsController: nil)
  
  var categories: CategoriesModel?
  var lawyersCard: [LawyersCardsModel] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.backgroundColor = .systemGray6
      setUpSearchBar()
      configureLayout()
      resgisterCells()
      configureItemsInCells()
    }
  
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  
  func resgisterCells() {
    
    collectionView.register(LawyersListCollectionViewCell.self, forCellWithReuseIdentifier: LawyersListCollectionViewCell.identifier)
    
  }
  
  func configureItemsInCells() {
    lawyersCard = [
      LawyersCardsModel(profileImage: UIImage(named: "abog"), name: "Abelardo de la Espriella", qualification: "4.5"),
      LawyersCardsModel(profileImage: UIImage(named: "abog"), name: "Matha Perez", qualification: "4.0"),
      LawyersCardsModel(profileImage: UIImage(named: "abog"), name: "James Rodriguez", qualification: "4.9"),
      LawyersCardsModel(profileImage: UIImage(named: "abog"), name: "Omar Rueda", qualification: "4.6"),
      
    ]
  }
  
  
  private func configureLayout() {
    let layout = UICollectionViewCompositionalLayout {sectionIndex, _ -> NSCollectionLayoutSection in
      return self.createSectionLayout()
    }
    collectionView.setCollectionViewLayout(layout, animated: false)
  }
  
  func createSectionLayout() -> NSCollectionLayoutSection {
    //Item
    let item = NSCollectionLayoutItem(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .absolute(420)
      )
    )
    //group
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: item.layoutSize,
      subitems: [item]
    )
    //secondGroup.interItemSpacing = .fixed(15)
    group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
    //second section
    let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
    return section
  }
}

extension FavoriteCollectionViewController: UISearchBarDelegate {
  
  func setUpSearchBar() {
    definesPresentationContext = true
    navigationItem.searchController = searchBarController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchBarController.searchBar.placeholder = "Buscar"
  
    searchBarController.searchBar.searchTextField.clearButtonMode = .whileEditing
    searchBarController.obscuresBackgroundDuringPresentation = false
    searchBarController.searchBar.delegate = self
  }
}


extension FavoriteCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return lawyersCard.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LawyersListCollectionViewCell.identifier, for: indexPath) as? LawyersListCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    let cards = lawyersCard[indexPath.row]
    cell.configure(with: cards, and: categories)
    return cell
  }
  
}

