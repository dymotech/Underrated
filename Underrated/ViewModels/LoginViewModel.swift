//
//  LoginViewModel.swift
//  Underrated
//
//  Created by Cody Martin on 3/29/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import Foundation
import Resolver

class LoginViewModel: ObservableObject {
@Published private var authenticationService: AuthenticationService = Resolver.resolve()

    func link(complitionHandler: @escaping (Bool, Error?) -> Void) -> Void {
        self.authenticationService.linkWithGoogle(complitionHandler: { (result, error) in
            if let error = error {
                complitionHandler(false, error)
                return
            }
            
            if result == true {
                complitionHandler(true, nil)
            } else {
                complitionHandler(false, nil)
            }
        })
    }
    
func logout() {
  self.authenticationService.signOut()
}
}
