//
//  ContentView.swift
//  Underrated
//
//  Created by Cody Martin on 3/1/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    var body: some View {
        Group {
            if (viewModel.userId != nil) {
                MainTabView()
          } else {
                LoginView()
          }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

