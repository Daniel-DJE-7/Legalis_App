//
//  FavoritesClientCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/9/26.
//

import UIKit

protocol FavoritesClientCoordinatorDelegate: AnyObject {
    func favoritesCoordinatorDidRequestAppointmentsTab(
        _ coordinator: FavoritesClientCoordinator
    )
}

class FavoritesClientCoordinator: Coordinator {

  var navigationController: UINavigationController?
  private var bookingCoordinator: BookingCoordinator?
  weak var delegate: FavoritesClientCoordinatorDelegate?
  
  init(navigationController: UINavigationController? = nil) {
    self.navigationController = navigationController
  }
  
  func start() {
    if let favoriteVC = navigationController?.viewControllers.first as? FavoriteCollectionViewController {
      favoriteVC.coordinator = self
    }
  }
  
  func goToLawyerDescriptionProfile() {
    let profileVC = ProfileLawyerCollectionViewController()
    
    bookingCoordinator = BookingCoordinator(navigationController: navigationController)
    //booking le avisa a favoritos cuando termine el flujo de pago con exito
    bookingCoordinator?.delegate = self
    
    profileVC.coordinator = bookingCoordinator
    
    navigationController?.pushViewController(profileVC, animated: true)
    
  }
  
}

extension FavoritesClientCoordinator: BookingCoordinatorDelegate {
  
  //aqui FavoritesClientCoordinator le avisa a MainClientTabBarCoordinator que quiere ir a citas en el tabar
  func bookingCoordinatorDidFinishWithSuccess(_ coordinator: BookingCoordinator) {
//    navigationController?.popToRootViewController(animated: false)
    delegate?.favoritesCoordinatorDidRequestAppointmentsTab(self)
  }
  
  
}
