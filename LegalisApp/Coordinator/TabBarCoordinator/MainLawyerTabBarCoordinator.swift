//
//  MainLawyerTabBarCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 10/9/26.
//

import UIKit

class MainLawyerTabBarCoordinator: Coordinator {

  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController?
  let tabBarController = MainTabBarItemNavigationController()
  weak var parentCoordinator: AppCoordinator?
  
  let userID: Int
  
  init(navigationController: UINavigationController = UINavigationController(), userID: Int) {
    self.navigationController = navigationController
    self.userID = userID
  }
  
  
  func start() {
    // 1. Generamos el array con las 3 pestañas del Abogado (ya estilizadas en tu clase Main)
    let lawyerModuls = tabBarController.configureLawyersModuls()
    
    guard lawyerModuls.count == 3 else { return }
    
    // 2. Extraemos el UINavigationController individual para cada una de las 3 pestañas
    let homeNav = lawyerModuls[0]
    let chatNav = lawyerModuls[1]
    let profileNav = lawyerModuls[2]
    
    // 3. Inicializamos los coordinadores hijos del Abogado (debes crear estas clases similares a las del cliente)
    let homeCoordinator = HomeLawyerCoordinator(navigationController: homeNav, userID: userID)
    let chatCoordinator = ChatLawyerCoordinator(navigationController: chatNav)
    let profileCoordinator = ProfileLawyerCoordinator(navigationController: profileNav)
    
    // 4. Guardamos las referencias de los flujos en memoria
    childCoordinators = [
      homeCoordinator,
      chatCoordinator,
      profileCoordinator
    ]
    
    // 5. Arrancamos cada flujo hijo
    homeCoordinator.start()
    chatCoordinator.start()
    profileCoordinator.start()
    
    // 6. Asignamos los NavigationControllers al TabBar del Abogado
    tabBarController.viewControllers = [
      homeNav,
      chatNav,
      profileNav
    ]
    
  }
  
  
}
