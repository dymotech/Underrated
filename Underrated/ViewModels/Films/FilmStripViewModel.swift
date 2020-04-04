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

class FilmStripViewModel: ObservableObject {
//    @Published var films: [Film]
//    @Published var film: Film
//    @Published var filmRepository: FilmRepository = Resolver.resolve()
    @Published var filmStripCellViewModels = [FilmStripCellViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init(films: [Film]) {
        
        self.filmStripCellViewModels = films.map{ film in
            FilmStripCellViewModel(film: film)
        }
//        $films.map { film in
//          FilmStripCellViewModel(film: film)
//        }
//        .assign(to: \.filmStripCellViewModels, on: self)
//        .store(in: &cancellables)
//    @Published var filma = films
//
//      $films.map { films in
//        films.map { film in
//          FilmStripCellViewModel(film: film)
//        }
//      }
//      .assign(to: \.filmStripCellViewModels, on: self)
//      .store(in: &cancellables)
    }
}
