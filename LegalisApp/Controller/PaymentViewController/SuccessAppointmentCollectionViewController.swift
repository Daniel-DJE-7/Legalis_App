//
//  SuccessAppointmentCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 2/7/26.
//

import UIKit



class SuccessAppointmentCollectionViewController: CoreCollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .systemCyan
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }

}
