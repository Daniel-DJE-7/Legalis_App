//
//  WelcomeViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 29/4/26.
//

import UIKit

class WelcomeViewController: UIViewController, welcomeViewDelegate {

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
    let vc = ClientsSignUpViewController()
    
    vc.modalPresentationStyle = .fullScreen
    vc.modalTransitionStyle = .coverVertical
    present(vc, animated: true)
  }
  
  func lawyerSignUp() {
    let vc = LawyersSignUpViewController()
    vc.modalTransitionStyle = .flipHorizontal
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true)
  }
  
}
