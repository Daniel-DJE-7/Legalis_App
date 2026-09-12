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
  weak var parentCoordinator: AppCoordinator?
  
  init(navigationController: UINavigationController = UINavigationController()) {
    self.navigationController = navigationController
  }
  
  func start() {
    // 1. Generamos el array de los 5 UINavigationControllers ya estilizados desde tu clase MainTabBarNavigationItem
    let clientModules = tabBarController.configureClientModuls()
    
    // Validamos que tengamos la cantidad correcta de pestañas creadas en tu Main
    guard clientModules.count == 5 else { return }
    
    // 2. Extraemos el UINavigationController INDIVIDUAL asignado a cada pestaña, accedemos al valor del array clientModules por cada pestaña según su indice
    let homeNav = clientModules[0]
    let chatNav = clientModules[1]
    let appointmentNav = clientModules[2]
    let favoritesNav = clientModules[3]
    let myAccountNav = clientModules[4]
          
    // 3. Inicializamos los coordinadores hijos inyectándoles SU PROPIO NavigationController
    let homeCoordinator = HomeClientCoordinator(navigationController: homeNav, tabBarController: tabBarController)
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
    
  }
  
}
