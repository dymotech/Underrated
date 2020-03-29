//
//  SceneDelegate.swift
//  Underrated
//
//  Created by Cody Martin on 3/1/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import UIKit
import SwiftUI
import Resolver

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var currentScene: UIScene?
    var window: UIWindow?
    @LazyInjected var authenticationService: AuthenticationService

//    NotificationCenter.default.addObserver(forName: .newUser, object: nil, queue: .main) { [weak self] (notification) in
//
//    guard let windowScene = self?.currentScene as? UIWindowScene else { return }
//
//    keyWindow = UIWindow(windowScene: windowScene)
//    keyWindow?.rootViewController = UIHostingController(rootView: Text("hello"))
//    keyWindow?.makeKeyAndVisible()

//    NotificationCenter.default.addObserver(self, selector:#selector(done(notification:)),name:LoginView.NotificationDone,object: nil)
//    NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
//
//    Notification.def
    let nc = NotificationCenter.default
    

//    @objc func done(notification: Notification) {
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = UIHostingController(rootView: contentView)
//        self.window = window
//        window.makeKeyAndVisible()
//    }
    
//    func done2(notification: Notification) {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
//        self.window?.rootViewController = storyboard.instantiateInitialViewController()
//    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

//        nc.addObserver(self, selector: #selector(userLoggedIn), name: Notification.Name("UserLoggedIn"), object: nil)
//        nc.addObserver(self, selector:#selector(done(notification:)), name:Constants.UserLoggedInNotification, object: nil)

//        let keyWindow: UIWindow?
//        self.currentScene = scene
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Unable to read managed object context.")
        }

         let session = FirebaseSession()

//        NotificationCenter.default.addObserver(forName: Constants.UserLoggedInNotification, object: nil, queue: .main) { [weak self] (notification) in
//
//             guard let windowScene = self?.currentScene as? UIWindowScene else { return }
//
//             keyWindow = UIWindow(windowScene: windowScene)
//             let contentView = ContentView().environment(\.managedObjectContext, context)
//             keyWindow?.rootViewController = UIHostingController(rootView: contentView.environmentObject(session))
//             keyWindow?.makeKeyAndVisible()
//
//           }

        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Get the managed object context from the shared persistent container.


        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
//        let loginView = LoginView().environment(\.managedObjectContext, context)
        
        let contentView = ContentView().environment(\.managedObjectContext, context)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = UIHostingController(rootView: loginView)
            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(session))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
//        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
//        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        // Create the SwiftUI view that provides the window contents.
//
//        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
//            fatalError("Unable to read managed object context.")
//        }
//
////        let contentView = ContentView()
//        let contentView = ContentView().environment(\.managedObjectContext, context)
//
//        //Firebase
//        let session = FirebaseSession()
//
//        // Use a UIHostingController as window root view controller.
//        if let windowScene = scene as? UIWindowScene {
//            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(session))
//            self.window = window
//            window.makeKeyAndVisible()
//        }
//    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

