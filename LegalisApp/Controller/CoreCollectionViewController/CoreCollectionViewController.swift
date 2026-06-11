//
//  CoreCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 11/5/26.
//

import UIKit

class CoreCollectionViewController: UICollectionViewController {

  //creamos collectionView Reusable
  init() {
    super.init(collectionViewLayout: UICollectionViewLayout())
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
