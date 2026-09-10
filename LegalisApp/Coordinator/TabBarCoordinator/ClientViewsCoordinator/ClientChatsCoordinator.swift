//
//  ClientChatsCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/9/26.
//

import UIKit

class ClientChatsCoordinator: Coordinator {
    
  var navigationController: UINavigationController?
  
  init(navigationController: UINavigationController? = nil) {
    self.navigationController = navigationController
  }
  
  func start() {
//    let chatVC = ConversationsTableViewController()
//    chatVC.navigationController?.pushViewController(chatVC, animated: true)
  }
  
}
