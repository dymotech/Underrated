//
//  FilmView.swift
//  Underrated
//
//  Created by Cody Martin on 3/17/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import SwiftUI

struct FilmDetailView: View {
//    var title;
    var film: Film;
//    @ObservedObject
    var viewModel = FilmDetailViewModel()
    var body: some View {
        VStack {
//            Image(film.image)
//            .resizable()
////                .aspectRatio(contentMode: .fill)
//            .aspectRatio(contentMode: .fit)
////                .frame(width: 320, height: 180)
//            .cornerRadius(10)
//                .padding()
            Text(film.title).onTapGesture {
                self.addFilm()
            }
        }
//        .navigationBarTitle(Text(film.image), displayMode: .inline)
    }
    
    func addFilm() {
        var fill = self.film
        fill.title = "xxxxxxxxxxxx"
        self.viewModel.addFilm(film: fill)
    }
}


//struct FilmView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilmDetailView()
//    }
//}

#if DEBUG
struct FilmDetailView_Previews: PreviewProvider {
  static var previews: some View {
    FilmDetailView(film: testDataFilms[0])
  }
}
#endif


//FilmDetailView(
//    image: "van"
//    id: 0,
//    name: "Charmander",
//    type: "Fire",
//    color: .red
//  )
