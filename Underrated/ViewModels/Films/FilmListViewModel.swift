//
//  FilmStripViewModel.swift
//  Underrated
//
//  Created by Cody Martin on 3/29/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import Foundation
import Combine
import Resolver

class FilmListViewModel: ObservableObject {
    @Published var filmRepository: FilmRepository = Resolver.resolve()
//    @Published var actionFilmStripViewModel = FilmStripViewModel(films: [])
//    @Published var comedyFilmStripViewModel = FilmStripViewModel(films: [])
    @Published var actionFilms = [Film]()
    @Published var comedyFilms = [Film]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        
//    filmRepository.$films
//    .assign(to: \.actionFilms, on: self)
//    .store(in: &cancellables)
//
//    filmRepository.$films
//    .assign(to: \.comedyFilms, on: self)
//    .store(in: &cancellables)
        
        filmRepository.queryFilmsByGenre(genre: "Action", callback: { films in
            if let films = films {
                print("BANG")
                self.actionFilms = films
            }
        })
        
        filmRepository.queryFilmsByGenre(genre: "Comedy", callback: { films in
            if let films = films {
                print("BANG Bang")
                self.comedyFilms = films
            }
        })
        
        
        
//        filmRepository.$films.map { films in FilmStripViewModel(films: films) }
//        .assign(to: \.actionFilmStripViewModel, on: self)
//        .store(in: &cancellables)
//
//        filmRepository.$films.map { films in
//            films.filter { film -> Bool in
//                film.title == "New ish2202020"
//            }
//        }
//        .map( { films in
//            FilmStripViewModel(films: films)
//        })
//        .assign(to: \.comedyFilmStripViewModel, on: self)
//        .store(in: &cancellables)
    }
      
//    func removeFilms(atOffsets indexSet: IndexSet) {
//        let viewModels = indexSet.lazy.map { self.filmStripCellViewModels[$0] }
//        viewModels.forEach { filmCellViewModel in
//          filmRepository.removeFilm(filmCellViewModel.film)
//        }
//    }
}
