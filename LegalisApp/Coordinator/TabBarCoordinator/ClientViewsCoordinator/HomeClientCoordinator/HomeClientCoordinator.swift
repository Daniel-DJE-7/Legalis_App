//
//  HomeClientCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/9/26.
//

import UIKit

class HomeClientCoordinator: Coordinator, BookingCoordinatorDelegate {
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController?
  weak var parentCoordinator: AppCoordinator?

  
  // Necesitamos una referencia al TabBar padre para poder cambiar de pestaña por código
  weak var tabBarController: MainTabBarItemNavigationController?
  
  init(navigationController: UINavigationController? = nil, tabBarController: MainTabBarItemNavigationController) {
    self.navigationController = navigationController
    self.tabBarController = tabBarController
    
  }
  
  func start() {
    
    if let homeVC = navigationController?.viewControllers.first as? HomeClientCollectionViewController {
      homeVC.coordinator = self
    }
    
  }
  
  //Este método es llamado cuando tocan una celda en la colección
  func didSelectLawCategory(_ category: CategoriesModel) {
    let bookingCoordinator = BookingCoordinator(navigationController: navigationController)
    
    bookingCoordinator.categorySelected = category
    bookingCoordinator.delegate = self
    childCoordinators.append(bookingCoordinator)
    bookingCoordinator.start()
  }
  
  // MARK: - BookingCoordinatorDelegate
  func bookingCoordinatorDidFinishWithSuccess(_ coordinator: BookingCoordinator) {
    // 1. Regresamos el Navigation de la pestaña Home a la vista principal (limpia el flujo de compra)
    navigationController?.popToRootViewController(animated: false)
    
    //2. cambia a la pestaña 2 en el array, que seria appointments
    tabBarController?.selectedIndex = 2
    
    childCoordinators.removeAll { $0 === coordinator }
    
  }

}
