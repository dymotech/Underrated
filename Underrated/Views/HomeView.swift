//
//  HomeView.swift
//  Underrated
//
//  Created by Cody Martin on 3/1/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import SwiftUI

struct HomeView: View {
var body: some View {
    NavigationView {
        Text("We have much to discuss")
            .font(.largeTitle)
            .navigationBarTitle("Welcome Home")
    }
}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
