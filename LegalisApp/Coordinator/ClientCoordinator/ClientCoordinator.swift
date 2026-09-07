//
//  ClientCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 7/9/26.
//

import UIKit

class ClientCoordinator: Coordinator {
  var navigationController: UINavigationController?
  
  
  var viewController: UIViewController?
  
  init(viewController: UIViewController? = nil) {
    self.viewController = viewController
  }
  
  func start() {
    let vc = ClientsSignUpViewController()
    vc.modalPresentationStyle = .fullScreen
    vc.modalTransitionStyle = .coverVertical
    viewController?.present(vc, animated: true)
  }
  
}
