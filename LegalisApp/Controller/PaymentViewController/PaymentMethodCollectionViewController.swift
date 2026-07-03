//
//  PaymentMethodCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 1/7/26.
//

import UIKit

private enum SectionPayment: Int, CaseIterable {
  case header
  case paymentMethod
  case continueBtn
}

class PaymentMethodCollectionViewController: CoreCollectionViewController {

  private let titleMethodPayment = "MÉTODOS DE PAGO"
  private let methods = ["Crédito", "Débito"]
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
    
    //lock img
    let closeRightButton =  UIImage(named: "closeSymbol")
    
    let closeBtn = UIBarButtonItem(image: closeRightButton,
                                   style: .plain,
                                   target: self,
                                   action: #selector(closeBtnTapped))
   
    closeBtn.tintColor = UIColor(
      red: 0,
      green: 0.1063321754,
      blue: 0.2393084168,
      alpha: 1)
    
    navigationItem.rightBarButtonItem = closeBtn
  
  }
  
  @objc func backBtnTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func closeBtnTapped() {
    dismiss(animated: true)
  }
  
  
  //MARK: - REGISTER CELLS
  func registerCells() {
    collectionView.register(PaymentHeaderMethodCollectionViewCell.self, forCellWithReuseIdentifier: PaymentHeaderMethodCollectionViewCell.identifier)
   
    collectionView.register(MethodCollectionViewCell.self, forCellWithReuseIdentifier: MethodCollectionViewCell.identifier)
    
    collectionView.register(PaymentButtonsCollectionViewCell.self, forCellWithReuseIdentifier: PaymentButtonsCollectionViewCell.identifier)
    
    collectionView.register(HeaderSecondSectionCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSecondSectionCollectionViewCell.identifier)
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
          heightDimension: .absolute(20)
        ),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .topLeading
      )
    ]

    switch section {
        
      //MARK: - Header section
      case 0:
        //firstItem
          let firstItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .estimated(200)
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
    
      //MARK: - Payment method section
      case 1:
        //second Item
        let secondItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40)
          )
        )
        //second group
        let secondGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: secondItem.layoutSize,
          subitems: [secondItem]
        )
        
        //second section
        let secondSection = NSCollectionLayoutSection(group: secondGroup)
            secondSection.boundarySupplementaryItems = header
        return secondSection
     
      //MARK: - Button section
      case 2:
        //second Item
        let thirdItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(180)
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

extension PaymentMethodCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionPayment.allCases.count
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    guard let section = SectionPayment(rawValue: section) else { return 0 }
   
    switch section {
    case .header:
     return 1
    case .paymentMethod:
     return 2
    case .continueBtn:
     return 1
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let section = SectionPayment(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    
    switch section {
    
    case .header:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PaymentHeaderMethodCollectionViewCell.identifier,
        for: indexPath) as? PaymentHeaderMethodCollectionViewCell else {
        return UICollectionViewCell()
      }

      return cell
   
    case .paymentMethod:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: MethodCollectionViewCell.identifier,
        for: indexPath) as? MethodCollectionViewCell else {
        return UICollectionViewCell()
      }
      
      cell.configure(with: methods[indexPath.row])
      return cell
    
    case .continueBtn:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PaymentButtonsCollectionViewCell.identifier,
        for: indexPath) as? PaymentButtonsCollectionViewCell else {
        return UICollectionViewCell()
      }
      
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
      for: indexPath) as? HeaderSecondSectionCollectionViewCell, kind == UICollectionView.elementKindSectionHeader else {
      return UICollectionReusableView()
    }
    header.configure(with: titleMethodPayment)
    return header
  }
  
}

extension PaymentMethodCollectionViewController: PaymentButtonsCollectionViewCellDelegate {
  
  func onVirtualPaymentPressed() {
    
    let vc = CardDetailsCollectionViewController()
    let nav = UINavigationController(rootViewController: vc)
    
    nav.modalPresentationStyle = .fullScreen
    if let sheet = nav.sheetPresentationController {
      sheet.detents = [.custom { context in
        return context.maximumDetentValue * 1 }
      ]
      sheet.prefersGrabberVisible = true
    }
    
    navigationController?.present(nav, animated: true)
  }
  
  func onPhysicalPaymentPressed() {
    let vc = SuccessAppointmentCollectionViewController()
    
    navigationController?.pushViewController(vc, animated: true)
  }
  
  
}
