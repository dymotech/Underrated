////
////  MovieView.swift
////  Underrated
////
////  Created by Cody Martin on 3/3/20.
////  Copyright © 2020 Cody Martin. All rights reserved.
////

import SwiftUI
import SDWebImageSwiftUI

struct FilmView: View {
    @ObservedObject var filmListVM = FilmListViewModel() // (7)
    var body: some View {
        return NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    FilmStripView(header: "Action", films: self.filmListVM.actionFilms)
                    FilmStripView(header: "Comedy", films: self.filmListVM.comedyFilms)
//                    FilmStripView(header: "Comedy")
//                    FilmStripView(header: "Drama")
                }
                .navigationBarTitle("Films", displayMode: .automatic)
            }
        }
    }
}

struct FilmView_Previews: PreviewProvider {
    static var previews: some View {
        FilmView()
    }
}
