//
//  LawyerCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 7/9/26.
//

import UIKit

class LawyerCoordinator: Coordinator {
  var navigationController: UINavigationController?
  
  var viewController: UIViewController?
  
  init(viewController: UIViewController?) {
    self.viewController = viewController
  }
  
  func start() {
    let vc = LawyersSignUpViewController()
    vc.modalTransitionStyle = .flipHorizontal
    vc.modalPresentationStyle = .fullScreen
    viewController?.present(vc, animated: true)
  }
    
}
