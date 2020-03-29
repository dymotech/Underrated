//
//  FilmListViewModel.swift
//  Underrated
//
//  Created by Cody Martin on 3/27/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import Foundation
import Combine
import Resolver

class FilmListViewModel: ObservableObject {
@Published var filmRepository: FilmRepository = Resolver.resolve()
@Published var filmCellViewModels = [FilmCellViewModel]()

private var cancellables = Set<AnyCancellable>()

init() {
  filmRepository.$films.map { films in
    films.map { film in
      FilmCellViewModel(film: film)
    }
  }
  .assign(to: \.filmCellViewModels, on: self)
  .store(in: &cancellables)
}
  
  func removeFilms(atOffsets indexSet: IndexSet) { // (4)
//    filmCellViewModels.remove(atOffsets: indexSet)
    let viewModels = indexSet.lazy.map { self.filmCellViewModels[$0] }
    viewModels.forEach { filmCellViewModel in
      filmRepository.removeFilm(filmCellViewModel.film) // (1)
    }
  }
  
  func addFilm(film: Film) { // (5)
//    filmCellViewModels.append(FilmCellViewModel(film: film))
    filmRepository.addFilm(film)
  }
}
