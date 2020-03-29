//
//  ContentView.swift
//  Underrated
//
//  Created by Cody Martin on 3/1/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
            }.tag(1)

            FilmsListView()
                .tabItem {
                    VStack {
                        Image(systemName: "film")
                        Text("Film")
                    }
            }.tag(2)

            BookView()
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                        Text("Books")
                    }
            }.tag(3)

            LibraryView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }.tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

