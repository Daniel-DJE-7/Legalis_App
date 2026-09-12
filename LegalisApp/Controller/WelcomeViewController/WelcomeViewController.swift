//
//  WelcomeViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 29/4/26.
//

import UIKit

class WelcomeViewController: UIViewController, welcomeViewDelegate, ClientCoordinatorDelegate, LawyerCoordinatorDelegate {

  var mainCoordinator: AppCoordinator?
  var clientCoordinator: ClientCoordinator?
  var lawyerCoordinator: LawyerCoordinator?
  
    override func loadView() {
      let welcomView = WelcomeView()
      welcomView.delegate = self
      
      view = welcomView
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//          for family in UIFont.familyNames {
//            print(family)
//            for name in UIFont.fontNames(forFamilyName: family) {
//              print(name)
//            }
//          }
  }
  
  func clientSignUp() {
    
    self.clientCoordinator = ClientCoordinator(viewController: self)
    //asignamos el coordinator
    self.clientCoordinator?.delegate = self
    
    self.clientCoordinator?.start()

  }
  
  func lawyerSignUp() {
    self.lawyerCoordinator = LawyerCoordinator(viewController: self)
    self.lawyerCoordinator?.delegate = self// Asignamos el delegado del Abogado
    self.lawyerCoordinator?.start()
  }
  
  // MARK: - ClientCoordinatorDelegate
  // Esta función se ejecuta automáticamente cuando el modal termina de cerrarse
  func clientCoordinatorDidSignUpSuccessfully(_ coordinator: ClientCoordinator) {
    // Le ordenamos al coordinador raíz que cambie al TabBar del Cliente
    mainCoordinator?.switchToFlow(for: .client)
    self.clientCoordinator = nil
   }
  
  // MARK: - LawyerCoordinatorDelegate
   func lawyerCoordinatorDidSignUpSuccessfully(_ coordinator: LawyerCoordinator) {
     //aqui estamos switcheando para que se vean las vistas de los abogados
      mainCoordinator?.switchToFlow(for: .lawyer)
     //Limpiamos la referencia para liberar memoria
     self.lawyerCoordinator = nil
   }
  
}
