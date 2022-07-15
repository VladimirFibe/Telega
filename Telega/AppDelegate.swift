//
//  AppDelegate.swift
//  Telega
//
//  Created by Vladimir Fibe on 27.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    coordinateApplicationFlow()
    return true
  }
  
// MARK: - Route
  
  private func coordinateApplicationFlow() {
    window = UIWindow(frame: UIScreen.main.bounds)
    
    UserDefaults.standard.set(false, forKey: "isLoggedIn")
    UserDefaults.standard.synchronize()
    
    let rootViewController: UIViewController = TabBarController()
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()
  }
}

/*
 if !UserDefaults.standard.bool(forKey: "isLoggedIn") {
   let viewcontroller = SignInViewController()
   viewcontroller.modalPresentationStyle = .fullScreen
   self.present(viewcontroller, animated: true)
 }
 return UserDefaults.standard.bool(forKey: "isLoggedIn")

 */
