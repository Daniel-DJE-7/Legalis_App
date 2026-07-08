//
//  Coordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 7/7/26.
//

import UIKit

enum Event {
  case buttonTapped
}

protocol Coordinator {
  
  var navigationController: UINavigationController? {get set}//to show views
  
  func eventOccured(with type: Event)
  func start()//start method it will be to take app's control
}

//it transmits the event
protocol Coordinating {
  var coordinator: Coordinator? { get set }
}
