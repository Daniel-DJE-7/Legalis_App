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
      view.backgroundColor = #colorLiteral(red: 0.9921569228, green: 0.9921568036, blue: 0.9921569228, alpha: 1)
      
    }
    
  

}
