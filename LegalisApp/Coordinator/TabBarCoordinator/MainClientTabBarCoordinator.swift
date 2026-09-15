//
//  MainClientTabBarCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/9/26.
//

import UIKit

protocol MainClientTabBarCoordinatorDelegate: AnyObject {
  func tabBarCoordinatorRequestSwitchToAppointmets(_ coordinator: MainClientTabBarCoordinator)
}

class MainClientTabBarCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController?
  let tabBarController = MainTabBarItemNavigationController()
  weak var parentCoordinator: AppCoordinator?
  
  
  private var homeCoordinator: HomeClientCoordinator?
  private var appointmentCoordinator: AppointmentClientCoordinator?
  
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
    homeCoordinator.tabBarDelegate = self
    self.homeCoordinator = homeCoordinator
    
    let chatCoordinator = ClientChatsCoordinator(navigationController: chatNav)
    
    let appointmentCoordinator = AppointmentClientCoordinator(navigationController: appointmentNav)
    appointmentCoordinator.delegate = self
    self.appointmentCoordinator = appointmentCoordinator
    
    let favoritesCoordinator = FavoritesClientCoordinator(navigationController: favoritesNav)
    favoritesCoordinator.delegate = self
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
  
  func switchToAppointmentsTab() {
    DispatchQueue.main.async {
          self.tabBarController.selectedIndex = 2
      }
  }
  
}

extension MainClientTabBarCoordinator: HomeClientCoordinatorDelegate,
                                       FavoritesClientCoordinatorDelegate,
                                       AppointmentClientCoordinatorDelegate {


  //MARK: - FROM HOME COORDINATOR TO TABBAR
  func homeCoordinatorDidRequestAppointmentsTab(_ coordinator: HomeClientCoordinator) {
    switchToAppointmentsTab()
    
    DispatchQueue.main.async {
      // 1. Regresamos el Navigation de la pestaña Home a la vista principal (limpia el flujo de compra)
      coordinator.navigationController?.popToRootViewController(animated: false)
    }
  }
  
  //MARK: - FROM FAVORITES COORDINATOR TO APPOINTMENT TABBAR
  func favoritesCoordinatorDidRequestAppointmentsTab(_ coordinator: FavoritesClientCoordinator) {
    switchToAppointmentsTab()
    
    DispatchQueue.main.async {
      coordinator.navigationController?.popToRootViewController(animated: false)
    }
  }
  
  func appointmentsCoordinatorDidRequestReSchedule(_ coordinator: AppointmentClientCoordinator) {
    switchToAppointmentsTab()
    
    coordinator.navigationController?.popToRootViewController(animated: false)
  }
  
}
