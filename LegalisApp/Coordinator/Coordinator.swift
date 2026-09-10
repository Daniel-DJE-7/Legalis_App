//
//  Coordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 7/7/26.
//

import UIKit

protocol Coordinator {
  
  var navigationController: UINavigationController? { get set }//This will be used when I used push(NavControler)
  var viewController: UIViewController? { get } //This will be used when I used present(VC) 
  
  func start()//start method it will be to take app's control
}

//it transmits the event
protocol Coordinating {
  var coordinator: Coordinator? { get set }
}

extension Coordinator {
  //damos un valor por defecto a las variables de protocolo
  var viewController: UIViewController? { nil }
  var navigationController: UINavigationController? { nil }
}
