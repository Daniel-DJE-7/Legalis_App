//
//  HomeLawyerCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 10/9/26.
//

import UIKit

class HomeLawyerCoordinator: Coordinator {
  
  var navigationController: UINavigationController?
  let userID: Int
  
  init(navigationController: UINavigationController? = nil, userID: Int) {
    self.navigationController = navigationController
    self.userID = userID
  }
  
  func start() {
    if let homeVC = navigationController?.viewControllers.first as? HomeLawyerViewController {
      // Enviamos el ID del abogado a su pantalla Home.
      homeVC.userID = userID
      print("ID enviado a HomeLawyerViewController: \(userID)")
    } else {
      print("No se encontró HomeLawyerViewController en el NavigationController")
    }
  }
  
}
