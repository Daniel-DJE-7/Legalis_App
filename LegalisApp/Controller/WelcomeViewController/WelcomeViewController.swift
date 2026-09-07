//
//  WelcomeViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 29/4/26.
//

import UIKit

class WelcomeViewController: UIViewController, welcomeViewDelegate {

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
    self.clientCoordinator?.start()

  }
  
  func lawyerSignUp() {
    self.lawyerCoordinator = LawyerCoordinator(viewController: self)
    self.lawyerCoordinator?.start()
  }
  
}
