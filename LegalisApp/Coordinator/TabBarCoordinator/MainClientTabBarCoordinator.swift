//
//  MainClientTabBarCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/9/26.
//

import UIKit

class MainClientTabBarCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController?
  let tabBarController = MainTabBarItemNavigationController()
  weak var parentCoordinator: MainCoordinator?
  
  init(navigationController: UINavigationController = UINavigationController()) {
    self.navigationController = navigationController
  }
  
  func start() {
    // 1. Generamos el array de los 5 UINavigationControllers ya estilizados desde tu clase MainTabBarNavigationItem
    let clientModules = tabBarController.configureClientModuls()
    
    // Validamos que tengamos la cantidad correcta de pestañas creadas en tu Main
    guard clientModules.count >= 5 else { return }
    
    // 2. Extraemos el UINavigationController INDIVIDUAL asignado a cada pestaña
    guard let homeNav = clientModules[0] as? UINavigationController,
          let chatNav = clientModules[1] as? UINavigationController,
          let appointmentNav = clientModules[2] as? UINavigationController,
          let favoritesNav = clientModules[3] as? UINavigationController,
          let myAccountNav = clientModules[4] as? UINavigationController else {
      return
    }
          
    // 3. Inicializamos los coordinadores hijos inyectándoles SU PROPIO NavigationController
    let homeCoordinator = HomeClientCoordinator(navigationController: homeNav)
    let chatCoordinator = ClientChatsCoordinator(navigationController: chatNav)
    let appointmentCoordinator = AppointmentClientCoordinator(navigationController: appointmentNav)
    let favoritesCoordinator = FavoritesClientCoordinator(navigationController: favoritesNav)
    let myAccountCoordinator = MyAccountClientCoordinator(navigationController: myAccountNav)
    
    //4. guardamos referencias en memoria
    childCoordinators = [
      homeCoordinator,
      chatCoordinator,
      appointmentCoordinator,
      favoritesCoordinator,
      myAccountCoordinator
    ]
    
    //5. arrancamos cada flujo
    homeCoordinator.start()
    chatCoordinator.start()
    appointmentCoordinator.start()
    favoritesCoordinator.start()
    myAccountCoordinator.start()
    
    // 6. Asignamos los mismos NavigationControllers estilizados al TabBar
    tabBarController.viewControllers = [
      homeNav,
      chatNav,
      appointmentNav,
      favoritesNav,
      myAccountNav
    ]
    
    // 7. Insertamos el TabBar en el flujo de navegación principal, reemplazamos la raíz de navegación de la app por el TabBar completo de forma limpia
//    navigationController?.setViewControllers([tabBarController], animated: true)
  }
  
}
