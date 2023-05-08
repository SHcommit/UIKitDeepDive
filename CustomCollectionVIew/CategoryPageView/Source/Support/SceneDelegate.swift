//
//  SceneDelegate.swift
//  CategoryPageView
//
//  Created by 양승현 on 2023/05/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    self.window = UIWindow(windowScene: windowScene)
    window?.rootViewController = UINavigationController(
      rootViewController: ViewController())
    window?.makeKeyAndVisible()
  }
}
