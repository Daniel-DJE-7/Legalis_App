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
    navTabBarItemtitle: String?,
    navHeaderTitle: String?,
    largeTitle: Bool,
    controllerBackgroundcolor: UIColor) -> UIViewController {
    
      let navBarItemController = UINavigationController(rootViewController: viewController)
      
      //large title
      navBarItemController.navigationBar.prefersLargeTitles = largeTitle
      navBarItemController.tabBarItem.image = image
      navBarItemController.tabBarItem.title = navTabBarItemtitle//title for navTabBar to bottom
      
      viewController.navigationItem.title = navHeaderTitle//title for navBar header
      viewController.view.backgroundColor = controllerBackgroundcolor
      
      return navBarItemController
  }
  
  func userTypeModuls() {

      let homeViewController: UIViewController

      switch typeViewController {
      case .lawyer:
          homeViewController = HomeLawyerViewController()

      case .client:
          homeViewController = HomeClientCollectionViewController()

      case .none:
          homeViewController = UIViewController()
      }

      viewControllers = [
          creatingTabBarController(
              homeViewController,
              image: UIImage(named: "homeSymbol"),
              navTabBarItemtitle: "Home",
              navHeaderTitle: nil,
              largeTitle: false,
              controllerBackgroundcolor: #colorLiteral(red: 0.9724870324, green: 0.9721793532, blue: 0.9929525256, alpha: 1)
          )
      ]
  }
  
  func updateUserType(_ type: UserType) {
      typeViewController = type
      userTypeModuls()
  }
  
  }
  

//Abelardo Pineda
//2578096310
//Nuevocar0-2
//2154865236
//daniel@gmail.com
