//
//  ProfileLawyerCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 10/9/26.
//

import UIKit

class ProfileLawyerCoordinator: Coordinator {

  var navigationController: UINavigationController?
  let userID: Int
  
  init(navigationController: UINavigationController? = nil, userID: Int) {
    self.navigationController = navigationController
    self.userID = userID
  }
  
  func start() {
    guard let profileVC = navigationController?.viewControllers.first as? MyAccountLawyerTableViewController else {
      print("No se encontró la pantalla de perfil")
      return
    }
    
    profileVC.configure(userID: userID)
  }
  
}
