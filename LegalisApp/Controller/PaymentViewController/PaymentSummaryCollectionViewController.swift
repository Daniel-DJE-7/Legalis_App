//
//  PaymentSummaryCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 29/6/26.
//

import UIKit

private enum SectionSummaryPayment: Int, CaseIterable {
  case header
  case paymentSummary
  case continueBtn
}

class PaymentSummaryCollectionViewController: CoreCollectionViewController {

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
    let backBtnIcon = UIImage(named: "closeSymbol")
    
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
    let lockRightButton = UIImageView(image: UIImage(systemName: "lock.fill"))
    lockRightButton.contentMode = .scaleAspectFit
    lockRightButton.tintColor = UIColor(
      red: 0,
      green: 0.1063321754,
      blue: 0.2393084168,
      alpha: 1)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: lockRightButton)
  
  }
  
  @objc func backBtnTapped() {
    navigationController?.dismiss(animated: true)
    //navigationController?.popViewController(animated: true)
  }
  
  //MARK: - REGISTER CELLS
  func registerCells() {
    collectionView.register(PaymentHeaderCollectionViewCell.self, forCellWithReuseIdentifier: PaymentHeaderCollectionViewCell.identifier)
   
    collectionView.register(PaymentSummaryCollectionViewCell.self, forCellWithReuseIdentifier: PaymentSummaryCollectionViewCell.identifier)
    
    collectionView.register(ContinueButtonCollectionViewCell.self, forCellWithReuseIdentifier: ContinueButtonCollectionViewCell.identifier)
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
              heightDimension: .estimated(100)
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

extension PaymentSummaryCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionSummaryPayment.allCases.count
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    guard let section = SectionSummaryPayment(rawValue: section) else { return 0 }
    switch section {
    case .header:
     return 1
    case .paymentSummary:
     return 1
    case .continueBtn:
     return 1
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let section = SectionSummaryPayment(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    switch section {
    case .header:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentHeaderCollectionViewCell.identifier, for: indexPath) as? PaymentHeaderCollectionViewCell else {
        return UICollectionViewCell()
      }
      
      return cell
   
    case .paymentSummary:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentSummaryCollectionViewCell.identifier, for: indexPath) as? PaymentSummaryCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.backgroundColor = .white
      cell.layer.cornerRadius = 12
      cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
      cell.layer.borderWidth = 1
      return cell
    
    case .continueBtn:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContinueButtonCollectionViewCell.identifier, for: indexPath) as? ContinueButtonCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.delegate = self
      return cell
    }
  }
}

extension PaymentSummaryCollectionViewController: ContinueButtonCollectionViewCellDelegate {
 
  func onContinueBtnTapped() {
    
    let vc = PaymentMethodCollectionViewController()
    

    navigationController?.pushViewController(vc, animated: true)
  }
  
  
}
