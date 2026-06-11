//
//  MainTabBarNavigationViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 1/6/26.
//

import UIKit

enum UserType {
  case client
  case lawyer
}

class MainTabBarItemNavigationController: UITabBarController {
  
  var typeViewController: UserType?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    userTypeModuls()
  }
  
  fileprivate func creatingTabBarController(
    _ viewController: UIViewController,
    image: UIImage?,
    selectedImage: UIImage?,
    navTabBarItemtitle: String?,
    navHeaderTitle: String?,
    largeTitle: Bool
    ) -> UIViewController {
    
      let navBarItemController = UINavigationController(rootViewController: viewController)
      
      //large title
      navBarItemController.navigationBar.prefersLargeTitles = largeTitle
      navBarItemController.tabBarItem.image = image
      navBarItemController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
      navBarItemController.tabBarItem.title = navTabBarItemtitle//title for navTabBar to bottom
      navBarItemController.navigationBar.backgroundColor = #colorLiteral(red: 0.9489575028, green: 0.9486498237, blue: 0.9694228768, alpha: 1)
      
      //navBarItemController.tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
      tabBar.tintColor = #colorLiteral(red: 0.001550899004, green: 0.1220162287, blue: 0.2591198385, alpha: 1)
      
      
      viewController.navigationItem.title = navHeaderTitle//title for navBar header
     
      return navBarItemController
  }
  
  func userTypeModuls() {

      switch typeViewController {
        case .lawyer:
          viewControllers = configureLawyersModuls()

        case .client:
            viewControllers = configureClientModuls()

        case .none:
            viewControllers = []
      }
  }
  
  func updateUserType(_ type: UserType) {
      typeViewController = type
      userTypeModuls()
  }
  
  
  func configureLawyersModuls() -> [UIViewController] {
    
     return [
        creatingTabBarController(
            HomeLawyerViewController(),
            image: UIImage(named: "homeSymbolGray"),
           selectedImage: UIImage(named: "HomeSymbolBlue"),
            navTabBarItemtitle: "Inicio",
            navHeaderTitle: nil,
            largeTitle: false
        )
    ]
  }
  
  func configureClientModuls() -> [UIViewController] {
    
    return [
        creatingTabBarController(
            HomeClientCollectionViewController(),
            image: UIImage(named: "homeSymbolGray"),
           selectedImage: UIImage(named: "HomeSymbolBlue"),
            navTabBarItemtitle: "Inicio",
            navHeaderTitle: nil,
            largeTitle: false
        ),
        
        creatingTabBarController(
          ChatsCollectionViewController(),
          image: UIImage(named: "chatGrey"),
          selectedImage: UIImage(named: "chatsBlue"),
          navTabBarItemtitle: "Chats",
          navHeaderTitle: nil,
          largeTitle: false)
    ]
    
  }
  
}
  

//Abelardo Pineda
//2578096310
//Nuevocar0-2
//2154865236
//daniel@gmail.com
