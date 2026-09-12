//
//  MainCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/7/26.
//

import UIKit

// the root coordinator that manages the app’s initial flow
class AppCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
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
  
  //MARK: - Switching the tabBar according to user's role
  func switchToFlow(for userType: UserType) {
    //limpiamos memoria en el array
    childCoordinators.removeAll()
    
    let configureTabBar: MainTabBarItemNavigationController?
    
    switch userType {
      
    case .client:
      let clientTabBarCoordinator = MainClientTabBarCoordinator(navigationController: navigationController ?? UINavigationController())
      clientTabBarCoordinator.parentCoordinator = self
      childCoordinators.append(clientTabBarCoordinator)
      clientTabBarCoordinator.start()
      
      //asignamos la tabBar que verá el cliente
      configureTabBar = clientTabBarCoordinator.tabBarController
      
    case .lawyer:
      let lawyerTabBarCoordinator = MainLawyerTabBarCoordinator(navigationController: navigationController ?? UINavigationController())
      lawyerTabBarCoordinator.parentCoordinator = self
      childCoordinators.append(lawyerTabBarCoordinator)
      lawyerTabBarCoordinator.start()
      
      //asignamos la tabBar que verá el abogado
      configureTabBar = lawyerTabBarCoordinator.tabBarController
    }
    
    //validamos que exista el TabBar correctamente configurado
    guard let tabBarToPresent = configureTabBar else { return }
    //capturamos la ventana principal de la app de forma segura
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else { return }
    
    //cambiamos la raiz al tabBar configurado
    window.rootViewController = tabBarToPresent
    
    //animación de fundido suave
    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
  }
  
  
}
