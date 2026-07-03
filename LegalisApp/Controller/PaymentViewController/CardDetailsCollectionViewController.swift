//
//  CardDetailsCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 2/7/26.
//

import UIKit

class CardDetailsCollectionViewController: CoreCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.backgroundColor = .systemGray6
      
      setUpNavBar()
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


}
