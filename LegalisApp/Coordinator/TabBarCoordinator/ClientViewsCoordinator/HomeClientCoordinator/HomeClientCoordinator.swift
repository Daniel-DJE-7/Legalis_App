//
//  HomeClientCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/9/26.
//

import UIKit

protocol HomeClientCoordinatorDelegate: AnyObject {
  func homeCoordinatorDidRequestAppointmentsTab(_ coordinator: HomeClientCoordinator)
}

class HomeClientCoordinator: Coordinator, BookingCoordinatorDelegate {
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController?
  weak var parentCoordinator: AppCoordinator?

  weak var tabBarDelegate: HomeClientCoordinatorDelegate?
  
  // Necesitamos una referencia al TabBar padre para poder cambiar de pestaña por código
  weak var tabBarController: MainTabBarItemNavigationController?
  
  let userID: Int
  
  init(navigationController: UINavigationController? = nil,
       tabBarController: MainTabBarItemNavigationController,
       userID: Int) {
    self.navigationController = navigationController
    self.tabBarController = tabBarController
    self.userID = userID
  }
  
  func start() {
    
    if let homeVC = navigationController?.viewControllers.first as? HomeClientCollectionViewController {
      homeVC.coordinator = self
      homeVC.userID = userID
    }
    
  }
  
  //Este método es llamado cuando tocan una celda en la colección
  func didSelectLawCategory(_ category: CategoriesModel) {
    let bookingCoordinator = BookingCoordinator(navigationController: navigationController)
    
    bookingCoordinator.categorySelected = category
    bookingCoordinator.delegate = self
    
    self.childCoordinators.append(bookingCoordinator)
    bookingCoordinator.start()
  }
  
  // MARK: - BookingCoordinatorDelegate
  func bookingCoordinatorDidFinishWithSuccess(_ coordinator: BookingCoordinator) {
    
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      
      self.tabBarDelegate?.homeCoordinatorDidRequestAppointmentsTab(self)
      self.childCoordinators.removeAll { $0 === coordinator }
    }
  }
}

