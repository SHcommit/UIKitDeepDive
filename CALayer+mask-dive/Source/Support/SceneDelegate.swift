//
//  SceneDelegate.swift
//  CALayer+mask-dive
//
//  Created by 양승현 on 12/7/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    window = UIWindow(windowScene: (scene as? UIWindowScene) ?? .init(session: session, connectionOptions: connectionOptions))
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()
  }
}
