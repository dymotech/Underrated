//
//  AuthenticationService.swift
//  Underrated
//
//  Created by Cody Martin on 3/27/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import Foundation
import Firebase
import AuthenticationServices
//import CryptoKit
import Resolver
import GoogleSignIn

class AuthenticationService: ObservableObject {
  
  @Published var user: User?
  
  @LazyInjected private var filmRepository: FilmRepository
  private var handle: AuthStateDidChangeListenerHandle?
  private var coordinator:SignInWithGoogleCoordinator?
  
  init() {
    registerStateListener()
    self.coordinator = SignInWithGoogleCoordinator()
  }
  
  func signIn() {
    if Auth.auth().currentUser == nil {
      Auth.auth().signInAnonymously()
    }
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut()
    }
    catch {
      print("Error when trying to sign out: \(error.localizedDescription)")
    }
  }
  
  func updateDisplayName(displayName: String, completionHandler: @escaping (Result<User, Error>) -> Void) {
    if let user = Auth.auth().currentUser {
      let changeRequest = user.createProfileChangeRequest()
      changeRequest.displayName = displayName
      changeRequest.commitChanges { error in
        if let error = error {
          completionHandler(.failure(error))
        }
        else {
          if let updatedUser = Auth.auth().currentUser {
            print("Successfully updated display name for user [\(user.uid)] to [\(updatedUser.displayName ?? "(empty)")]")
            // force update the local user to trigger the publisher
            self.user = updatedUser
            completionHandler(.success(updatedUser))
          }
        }
      }
    }
  }
  
  private func registerStateListener() {
    if let handle = handle {
      Auth.auth().removeStateDidChangeListener(handle)
    }
    self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
      print("Sign in state has changed.")
      self.user = user
      
      if let user = user {
        let anonymous = user.isAnonymous ? "anonymously " : ""
        print("User signed in \(anonymous)with user ID \(user.uid). Email: \(user.email ?? "(empty)"), display name: [\(user.displayName ?? "(empty)")]")
      }
      else {
        print("User signed out.")
        self.signIn()
      }
    }
  }
  
}

enum SignInState: String {
  case signIn
  case link
  case reauth
}

class SignInWithGoogleCoordinator: NSObject {
    @LazyInjected private var filmRepository: FilmRepository
    @LazyInjected private var authenticationService: AuthenticationService
    
    private weak var window: UIWindow!
    private var onSignedInHandler: ((User) -> Void)?
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func signIn(onSignedInHandler: @escaping (User) -> Void) {
    }
    
    func link(onSignedInHandler: @escaping (User) -> Void) {
    }
}

extension SignInWithGoogleCoordinator: GIDSignInDelegate {
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }

    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        print("HERE")
      // ...
      if let error = error {
        // ...
        print(error)
        return
      }

        
      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
    print(credential)
        
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//        if let error = error {
            

        Auth.auth().currentUser?.link(with: credential) { (authResult, error) in
        if let error = error {
            print(error)
        } else {
            print("USER CONVERTED")
        }
    }
//    user.linkAndRetrieveData(with: credential) { (authResult, error) in
//        if let error = error {
//            firebaselinkingComplitionHandler(false, error)
//            return
//        }
//        firebaselinkingComplitionHandler(true, nil)
//    }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

  
}
