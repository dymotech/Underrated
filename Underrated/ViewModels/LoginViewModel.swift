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

func logout() {
  self.authenticationService.signOut()
}
}
