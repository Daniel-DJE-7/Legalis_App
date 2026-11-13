//
//  ClientCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 7/9/26.
//

import UIKit

protocol ClientCoordinatorDelegate: AnyObject {
  func clientCoordinatorDidSignUpSuccessfully(_ coordinator: ClientCoordinator, userID: Int)
}

class ClientCoordinator: Coordinator {
  
  var navigationController: UINavigationController?
  var viewController: UIViewController?
  
  weak var delegate: ClientCoordinatorDelegate?
  
  init(viewController: UIViewController?) {
    self.viewController = viewController
  }
  
  func start() {
    let vc = ClientsSignUpViewController()
    vc.coordinator = self // Asignamos la referencia para que el VC pueda avisar al coordinador
    vc.modalPresentationStyle = .fullScreen
    vc.modalTransitionStyle = .coverVertical
    viewController?.present(vc, animated: true)
  }
  
  
  // Esta función es llamada por el ClientsSignUpViewController cuando el registro es exitoso
  func userDidSingUpSuccessfully(userID: Int) {
    // Notificamos al delegado (WelcomeViewController) que el flujo terminó con éxito
    self.delegate?.clientCoordinatorDidSignUpSuccessfully(self, userID: userID)
    viewController?.dismiss(animated: false)
    
  }
  
}
