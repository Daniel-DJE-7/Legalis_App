//
//  ClientsSignUpViewController.swift
//  LegalisApp
//
//  Created by Memo Figueredo on 5/5/26.
//

import UIKit

class ClientsSignUpViewController: UIViewController {

  let clientsSignUpView = ClientsSignUpView()
  
    override func loadView() {
      super.loadView()
      view = clientsSignUpView
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .systemGray6
//      for family in UIFont.familyNames {
//        print(family)
//        for name in UIFont.fontNames(forFamilyName: family) {
//          print(name)
//        }
//      }
    }
    
  

}
