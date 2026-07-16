//
//  HomeClientCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 9/6/26.
//

import UIKit

private enum SectionType: Int, CaseIterable {
  case detailsOfappoinment
  case categories
}

class HomeClientCollectionViewController: CoreCollectionViewController {

  private let titleSecondSection = "ESPECIALIDADES"
  
  var categories: [CategoriesModel] = []
  let rightImage = "chevronGray"
  
    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.backgroundColor = .systemGray6
      configureNavBar()
      registerCells()
      configLayout()
      configureItemsInCells()
      
    }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  
  //MARK: - Array of cells
  func configureItemsInCells() {
    
    categories = [
      CategoriesModel(leftIcon: UIImage(named: "maso"), name: "Derecho Civil"),
      CategoriesModel(leftIcon: UIImage(named: "criminalLaw"), name: "Derecho Penal"),
      CategoriesModel(leftIcon: UIImage(named: "laborLaw"), name: "Derecho Laboral"),
      CategoriesModel(leftIcon: UIImage(named: "commercialLaw"), name: "Derecho Comercial"),
      CategoriesModel(leftIcon: UIImage(named: "familyLaw"), name: "Derecho de Familia"),
      CategoriesModel(leftIcon: UIImage(named: "administrativeLaw"), name: "Derecho Administrativo"),
      CategoriesModel(leftIcon: UIImage(named: "constitutionalLaw"), name: "Derecho Constitucional"),
      CategoriesModel(leftIcon: UIImage(named: "environmentalLaw"), name: "Derecho Ambiental"),
      CategoriesModel(leftIcon: UIImage(named: "technologyLaw"), name: "Derecho Digital"),
      CategoriesModel(leftIcon: UIImage(named: "intellectualPropertyLaw"), name: "Propiedad Intelectual"),
      CategoriesModel(leftIcon: UIImage(named: "balance"), name: "DDHH Y DIH")
      ,
      CategoriesModel(leftIcon: UIImage(named: "transportLaw"), name: "Derecho del Transporte"),
      CategoriesModel(leftIcon: UIImage(named: "fintechLaw"), name: "Derecho FINTECH y Bursátil")
      ,
      CategoriesModel(leftIcon: UIImage(named: "economicLaw"), name: "Derecho Económico"),
      CategoriesModel(leftIcon: UIImage(named: "administrativeLaw"), name: "Derecho público")
      ,
      CategoriesModel(leftIcon: UIImage(named: "medicalLaw"), name: "Derecho Médico"),
      CategoriesModel(leftIcon: UIImage(named: "customsLaw"), name: "Derecho Aduanero")
      ,
      CategoriesModel(leftIcon: UIImage(named: "securityLaw"), name: "Derecho de seguros"),
      CategoriesModel(leftIcon: UIImage(named: "socialSecurityLaw"), name: "Derecho de seguridad social")
    ]
    
  }
  
  //MARK: - Register cells
  func registerCells() {
    //first Section
    collectionView.register(HomeClientCollectionViewCell.self, forCellWithReuseIdentifier: HomeClientCollectionViewCell.identifier)
    //Second section
    collectionView.register(LawCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: LawCategoriesCollectionViewCell.identifier)
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
            heightDimension: .estimated(280))
        )
        
        //group
        let firstGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: firstItem.layoutSize,
          subitem: firstItem,
          count: 1
        )
        
        //Section
        let firstSection = NSCollectionLayoutSection(group: firstGroup)
      
      firstSection.interGroupSpacing = 10
        return firstSection
        
      //MARK: second section
      case 1:
        //item
        let secondItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(44))
        )
        
        //group
        let secondGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: secondItem.layoutSize,
          subitem: secondItem,
          count: 1
        )
      secondGroup.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        //section
        let secondSection = NSCollectionLayoutSection(group: secondGroup)
          secondSection.interGroupSpacing = 2
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

// MARK: - PROTOCOL COLLECTION VIEW DELEGATE
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
      return 19
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
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeClientCollectionViewCell.identifier, for: indexPath) as? HomeClientCollectionViewCell else {
        return UICollectionViewCell()
      }
      
      return cell
      
      case .categories:
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LawCategoriesCollectionViewCell.identifier, for: indexPath) as? LawCategoriesCollectionViewCell else { return UICollectionViewCell()
      }
      
      cell.backgroundColor = .white
      cell.configure(categories: categories[indexPath.row])
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
  
  
  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    let categories = categories[indexPath.row]
    let vc = LawyersCategoriesListCollectionViewController()
    //vc.navigationItem.title = categories.name
    vc.categories = categories
    
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
}//Extension end

