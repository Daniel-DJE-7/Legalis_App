//
//  HomeClientCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/9/26.
//

import UIKit

class HomeClientCoordinator: Coordinator {
  var navigationController: UINavigationController?
  
  
  init(navigationController: UINavigationController? = nil) {
    self.navigationController = navigationController
  }
  
  func start() {
//    let homeVC = HomeClientCollectionViewController()
//    homeVC.modalPresentationStyle = .fullScreen
//    homeVC.modalTransitionStyle = .crossDissolve
//    viewController?.present(homeVC, animated: true)
  }
  
  // Ejemplo de cómo navegarás en el futuro desde esta pestaña:
//   func goToDetails() {
//       let detailVC = UIViewController() // Tu vista secundaria real
//       navigationController?.pushViewController(detailVC, animated: true)
//   }
}
