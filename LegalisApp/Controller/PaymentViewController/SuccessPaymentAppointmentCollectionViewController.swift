//
//  SuccessAppointmentCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 2/7/26.
//

import UIKit



class SuccessPaymentAppointmentCollectionViewController: CoreCollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .systemGray6
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }

}
