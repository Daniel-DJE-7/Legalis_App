//
//  SuccessAppointmentCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 2/7/26.
//

import UIKit

private enum SectionSuccessDetails: Int, CaseIterable {
  case successPayment
  case appointmentDetails
  case btns
}

class SuccessPaymentAppointmentCollectionViewController: CoreCollectionViewController {

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
    navigationController?.popViewController(animated: true)
  }

  private func registerCells() {
    collectionView.register(SuccessCheckPointCollectionViewCell.self, forCellWithReuseIdentifier: SuccessCheckPointCollectionViewCell.identifier)
    
    collectionView.register(AppointmentDetailsCollectionViewCell.self, forCellWithReuseIdentifier: AppointmentDetailsCollectionViewCell.identifier)
    
    collectionView.register(AnotherConsultsCollectionViewCell.self, forCellWithReuseIdentifier: AnotherConsultsCollectionViewCell.identifier)
    
  }
  
  private func configureLayout() {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
      return self.createSection(section: sectionIndex)
    }
    collectionView.setCollectionViewLayout(layout, animated: false)
  }
  
  private func createSection(section: Int) -> NSCollectionLayoutSection {
    
    switch section {
    //MARK: - HEADER PAGE
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
      
      
    //MARK: - APPOINTMENT DETAILS
    case 1:
      //second Item
      let secondItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(144)
        )
      )
      //second group
      let secondGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: secondItem.layoutSize,
        subitems: [secondItem]
      )
      secondGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
      
      //second section
      let secondSection = NSCollectionLayoutSection(group: secondGroup)
      return secondSection
      
    //MARK: - btn
    case 2:
      let thirdtItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(130)
        )
      )
      //group
      let thirdtGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: thirdtItem.layoutSize,
        subitems: [thirdtItem]
      )
//      
      //section
      let thirdSection = NSCollectionLayoutSection(group: thirdtGroup)
      thirdSection.contentInsets = .init(top: 30, leading: 16, bottom: 0, trailing: 16)
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

extension SuccessPaymentAppointmentCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionSuccessDetails.allCases.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let section = SectionSuccessDetails(rawValue: section) else { return 0 }
    
    switch section {
    case .successPayment:
      return 1
    case .appointmentDetails:
      return 1
    case .btns:
      return 1
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
    guard let section = SectionSuccessDetails(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    
    switch section {
    
    case .successPayment:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuccessCheckPointCollectionViewCell.identifier, for: indexPath) as? SuccessCheckPointCollectionViewCell else {
        return UICollectionViewCell()
      }
     
      return cell
      
    case .appointmentDetails:
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppointmentDetailsCollectionViewCell.identifier, for: indexPath) as? AppointmentDetailsCollectionViewCell else {
        return UICollectionViewCell()
      }
      
      
      return cell
    
    case .btns:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnotherConsultsCollectionViewCell.identifier, for: indexPath) as? AnotherConsultsCollectionViewCell else {
        return UICollectionViewCell()
      }
     
      return cell
    }
  }
  
 
  
}
