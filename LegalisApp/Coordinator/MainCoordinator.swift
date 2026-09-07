//
//  MainCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/7/26.
//

import UIKit

class MainCoordinator: Coordinator {
  var navigationController: UINavigationController?
  
  //inicializamos la var
  init(navigationController: UINavigationController? = nil) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = WelcomeViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func eventOccured(with type: Event) {
    
  }
  
  
}
