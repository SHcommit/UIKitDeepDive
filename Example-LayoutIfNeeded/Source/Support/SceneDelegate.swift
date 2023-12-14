//
//  SceneDelegate.swift
//  Example-LayoutIfNeeded
//
//  Created by 양승현 on 12/14/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    window = UIWindow(windowScene: scene as! UIWindowScene)
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()
  }
}
