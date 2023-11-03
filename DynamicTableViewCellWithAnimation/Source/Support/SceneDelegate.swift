//
//  SceneDelegate.swift
//  DynamicTableViewCellWithAnimation
//
//  Created by 양승현 on 11/4/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let scene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: scene)
    window?.rootViewController = UINavigationController(rootViewController: PetViewController())
    window?.makeKeyAndVisible()
  }
}
