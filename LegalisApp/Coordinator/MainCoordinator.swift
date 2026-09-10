//
//  MainCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/7/26.
//

import UIKit

class MainCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = []
  var navigationController: UINavigationController?
  
  //inicializamos la var
  init(navigationController: UINavigationController?) {
    self.navigationController = navigationController
  }
  
  func start() {
    let welcomeVC = WelcomeViewController()
    welcomeVC.mainCoordinator = self
    navigationController?.pushViewController(welcomeVC, animated: true)
  }
  
  func switchToFlow(for userType: UserType) {
    //limpiamos memoria en el array
    childCoordinator.removeAll()
    
    let configureTabBar: MainTabBarItemNavigationController?
    
    switch userType {
    case .client:
      let clientTabBarCoordinator = MainClientTabBarCoordinator(navigationController: navigationController ?? UINavigationController())
      clientTabBarCoordinator.parentCoordinator = self
      childCoordinator.append(clientTabBarCoordinator)
      clientTabBarCoordinator.start()
    
      configureTabBar = clientTabBarCoordinator.tabBarController
      
    case .lawyer:
      let lawyerTabBarCoordinator = MainLawyerTabBarCoordinator(navigationController: navigationController ?? UINavigationController())
      lawyerTabBarCoordinator.parentCoordinator = self
      childCoordinator.append(lawyerTabBarCoordinator)
      lawyerTabBarCoordinator.start()
      
      configureTabBar = lawyerTabBarCoordinator.tabBarController
    }
    
    guard let tabBarToPresent = configureTabBar else { return }
    
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else { return }
    
    window.rootViewController = tabBarToPresent
    
    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
  }
  
  
}
