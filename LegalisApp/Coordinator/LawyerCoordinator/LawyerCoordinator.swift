//
//  LawyerCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 7/9/26.
//

import UIKit

protocol LawyerCoordinatorDelegate: AnyObject {
  func lawyerCoordinatorDidSignUpSuccessfully(_ coordinator: LawyerCoordinator)
}

class LawyerCoordinator: Coordinator {
  
  var navigationController: UINavigationController?
  var viewController: UIViewController?
  weak var delegate: LawyerCoordinatorDelegate?
  
  init(viewController: UIViewController?) {
    self.viewController = viewController
  }
  
  func start() {
    let vc = LawyersSignUpViewController()
    vc.coordinator = self //Inyectamos el coordinador a la vista
    vc.modalTransitionStyle = .flipHorizontal
    vc.modalPresentationStyle = .fullScreen
    viewController?.present(vc, animated: true)
  }
  
  func userDidSignUpSuccessfully() {
    // 1. Primero le avisamos al delegado para que el MainCoordinator cambie la raíz al TabBar de inmediato
    self.delegate?.lawyerCoordinatorDidSignUpSuccessfully(self)
    // 2. Luego cerramos el modal sin animación en segundo plano, para que no se vea de vuelta la welcomeview
    viewController?.dismiss(animated: false )
    
  }
  
    
}
