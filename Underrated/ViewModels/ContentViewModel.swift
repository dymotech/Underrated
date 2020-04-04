//
//  ContentViewModel.swift
//  Underrated
//
//  Created by Cody Martin on 4/3/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import Foundation
import Resolver
import Combine

class ContentViewModel: ObservableObject {
@Published private var authenticationService: AuthenticationService = Resolver.resolve()
@Published var userId: String?

//func logout() {
//  self.authenticationService.signOut()
//}
      private var cancellables = Set<AnyCancellable>()
      
    init() {
//        super.init()
        
        authenticationService.$user
          .compactMap { user in
            user?.uid
          }
          .assign(to: \.userId, on: self)
          .store(in: &cancellables)
        
    //     (re)load data if user changes
//        authenticationService.$user
//          .receive(on: DispatchQueue.main)
//          .sink { user in
//            if user == nil {
//                self.userId = nil
//            }
//          }
//          .store(in: &cancellables)
      }
}
