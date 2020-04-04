//
//  FilmStripView.swift
//  Underrated
//
//  Created by Cody Martin on 3/29/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct FilmStripView: View {
    var header : String
    var films: [Film]
//    @ObservedObject var viewModel: FilmStripViewModel
    
//    init(){
//        self.filmStripView = FilmStripViewModel(films: films)
//    }
    
    var body: some View {
        return VStack(alignment: .leading) {
            Text(header).font(.subheadline).padding(.leading, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(films) { film in
                        NavigationLink(destination: FilmDetailView(film: film)) {
                            FilmStripCellView(film: film)
                        }
                        .buttonStyle(PlainButtonStyle())

                    }
                }
                .frame(height: 200)
                .padding(.leading, 10)
            }
        }
    }
}

struct FilmStripCellView: View {
//     @ObservedObject var filmStripCellVM: FilmStripCellViewModel
//    @ObservedObject
    var film: Film
    
    var body: some View {
        WebImage(url: URL(string: film.poster))
        .resizable()
        .aspectRatio(contentMode: .fit)
        .cornerRadius(20)
    }
}

struct FilmStripView_Previews: PreviewProvider {
    static var previews: some View {
        FilmStripView(header: "Preview", films: testDataFilms)
    }
}
