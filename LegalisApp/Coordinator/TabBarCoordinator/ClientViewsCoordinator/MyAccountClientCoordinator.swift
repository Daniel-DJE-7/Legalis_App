//
//  MyAccountClientCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/9/26.
//

import UIKit

class MyAccountClientCoordinator: Coordinator {

  var navigationController: UINavigationController?
  let userID: Int
  
  init(navigationController: UINavigationController? = nil, userID: Int) {
    self.navigationController = navigationController
    self.userID = userID
  }
  
  func start() {
    guard let myAccountVC = navigationController?.viewControllers.first as? ClientMyAccountViewController else {
      print("No se encontró la pantalla de perfil")
      return
    }
    
    myAccountVC.configure(userID: userID)
  }
   
}
