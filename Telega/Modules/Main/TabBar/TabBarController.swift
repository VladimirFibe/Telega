//
//  TabBarController.swift
//  Telega
//
//  Created by Vladimir Fibe on 14.07.2022.
//

import UIKit

final class TabBarController: UITabBarController {
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTabBarController()
  }
  
  // MARK: - Setup TabbarController
  private func configureTabBarController() {
    let mainViewController = UINavigationController(rootViewController: ViewController())
    let chatsViewController = UINavigationController(rootViewController: PasswordRecoveryViewController())
    let profileViewController = UINavigationController(rootViewController: SignUpViewController())
    
    mainViewController.tabBarItem = UITabBarItem(title: "Главная",
                                                 image: Icons.tabBarHomeIcon,
                                                 selectedImage: Icons.tabBarSelectedHomeIcon)
    chatsViewController.tabBarItem = UITabBarItem(title: "Чат",
                                                 image: Icons.tabBarChatIcon,
                                                 selectedImage: Icons.tabBarSelectedChatIcon)
    
    profileViewController.tabBarItem = UITabBarItem(title: "Профайл",
                                                 image: Icons.tabBarProfileIcon,
                                                 selectedImage: Icons.tabBarSelectedProfileIcon)
    

    viewControllers = [mainViewController, chatsViewController, profileViewController]
//    tabBar.isTranslucent = false
//    tabBar.barTintColor = .white

    delegate = self
  }
}

extension TabBarController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    if !UserDefaults.standard.bool(forKey: "isLoggedIn") {
      let viewcontroller = SignInViewController()
      viewcontroller.modalPresentationStyle = .fullScreen
      self.present(viewcontroller, animated: true)
    }
    return UserDefaults.standard.bool(forKey: "isLoggedIn")
  }
}
