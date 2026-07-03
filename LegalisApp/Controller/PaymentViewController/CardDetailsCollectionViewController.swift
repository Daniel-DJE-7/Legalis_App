//
//  CardDetailsCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 2/7/26.
//

import UIKit


private enum SectionCardDetails: Int, CaseIterable {
  case header
  case cardDetails
  case payBtn
}

class CardDetailsCollectionViewController: CoreCollectionViewController {

  private let titleHeader: String = "Checkout"
  private let descriptionPage: String = """
                                        Complete su pago para procesar los servicios \nlegales solicitados.
                                        """
  let titleBtn = "Pagar Ahora"
  let titleHeaderCardDetails = "DETALLES DE LA TARJETA"
  
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
   
    //title
    navigationItem.title = "Legalis"
    navigationController?.navigationBar.titleTextAttributes = [
      .font : UIFont(name: "Inter-Regular_SemiBold", size: 17) ?? UIFont(),
      .kern : -0.43,
      .foregroundColor : #colorLiteral(red: 0.002019579057, green: 0.05263461918, blue: 0.139893055, alpha: 1),
    ]
    
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.topItem?.backButtonTitle = nil
    
    //Back Btn
    let backBtnIcon = UIImage(systemName: "arrow.backward")
    
    let backBtn = UIBarButtonItem(image: backBtnIcon,
                                  style: .plain,
                                  target: self,
                                  action: #selector(backBtnTapped))
   
    backBtn.tintColor = UIColor(
      red: 0,
      green: 0.1063321754,
      blue: 0.2393084168,
      alpha: 1)
   
    navigationItem.leftBarButtonItem = backBtn
  
  }
  
  @objc func backBtnTapped() {
    dismiss(animated: true)
  }

  private func registerCells() {
    collectionView.register(PaymentHeaderCollectionViewCell.self, forCellWithReuseIdentifier: PaymentHeaderCollectionViewCell.identifier)
    
    collectionView.register(CardDetailsCollectionViewCell.self, forCellWithReuseIdentifier: CardDetailsCollectionViewCell.identifier)
    
    collectionView.register(ContinueButtonCollectionViewCell.self, forCellWithReuseIdentifier: ContinueButtonCollectionViewCell.identifier)
    
    collectionView.register(HeaderSecondSectionCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSecondSectionCollectionViewCell.identifier)
  }
  
  private func configureLayout() {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
      return self.createSection(section: sectionIndex)
    }
    collectionView.setCollectionViewLayout(layout, animated: false)
  }
  
  private func createSection(section: Int) -> NSCollectionLayoutSection {
   
    let header = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(22)),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .topLeading)
    ]
    
    switch section {
    //MARK: - HEADER PAGE
    case 0:
    //firstItem
      let firstItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(130)
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
      
      
    //MARK: - CARD DETAILS
    case 1:
      //second Item
      let secondItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .absolute(250)
        )
      )
      //second group
      let secondGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: secondItem.layoutSize,
        subitems: [secondItem]
      )
      secondGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
      
      //second section
      let secondSection = NSCollectionLayoutSection(group: secondGroup)
          secondSection.boundarySupplementaryItems = header
      return secondSection
      
    //MARK: - btn
    case 2:
      let thirdtItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(54)
        )
      )
      //group
      let thirdtGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: thirdtItem.layoutSize,
        subitems: [thirdtItem]
      )
      thirdtGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
      //section
      let thirdSection = NSCollectionLayoutSection(group: thirdtGroup)
      thirdSection.contentInsets = .init(top: 30, leading: 0, bottom: 0, trailing: 0)
      return thirdSection
      
    //MARK: - DEFAULT SECTION
    default:
      //item
      let defautltItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .estimated(1),
          heightDimension: .absolute(10)
        )
      )
      //group
      let defaultGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: defautltItem.layoutSize,
        subitems: [defautltItem]
      )
      //section
      let defaultSection = NSCollectionLayoutSection(group: defaultGroup)
          
      return defaultSection
    }
  }

}

extension CardDetailsCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionCardDetails.allCases.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let section = SectionCardDetails(rawValue: section) else { return 0 }
    
    switch section {
    case .header:
      return 1
    case .cardDetails:
      return 1
    case .payBtn:
      return 1
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
    guard let section = SectionCardDetails(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    
    switch section {
    
    case .header:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentHeaderCollectionViewCell.identifier, for: indexPath) as? PaymentHeaderCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: titleHeader, and: descriptionPage)
      
      return cell
      
    case .cardDetails:
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardDetailsCollectionViewCell.identifier, for: indexPath) as? CardDetailsCollectionViewCell else {
        return UICollectionViewCell()
      }
      
      cell.layer.borderWidth = 1
      cell.layer.borderColor = UIColor.systemGray.cgColor
      
      return cell
    
    case .payBtn:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContinueButtonCollectionViewCell.identifier, for: indexPath) as? ContinueButtonCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: titleBtn)
      cell.delegate = self
      return cell
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: HeaderSecondSectionCollectionViewCell.identifier,
      for: indexPath
    ) as? HeaderSecondSectionCollectionViewCell, kind == UICollectionView.elementKindSectionHeader else {
      return UICollectionReusableView()
    }
    header.configure(with: titleHeaderCardDetails)
    return header
  }
  
}

extension CardDetailsCollectionViewController: ContinueButtonCollectionViewCellDelegate {
  
  func onContinueBtnTapped() {
    let vc = SuccessPaymentAppointmentCollectionViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  
}
