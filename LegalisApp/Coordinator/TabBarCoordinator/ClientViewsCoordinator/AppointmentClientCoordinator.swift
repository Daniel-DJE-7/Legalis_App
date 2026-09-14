//
//  AppointmentClientCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/9/26.
//

import UIKit

class AppointmentClientCoordinator: Coordinator {

  var navigationController: UINavigationController?
  
  
  init(navigationController: UINavigationController? = nil) {
    self.navigationController = navigationController
  }
  
  func start() {
//    let appointmentVC = AppointmentNavItemCollectionViewController()
//    navigationController?.setViewControllers([appointmentVC], animated: false)
  }
  
}
