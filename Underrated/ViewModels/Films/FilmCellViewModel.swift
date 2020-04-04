//
//  FilmCellViewModel.swift
//  Underrated
//
//  Created by Cody Martin on 3/27/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import Foundation
import Combine
import Resolver

class FilmCellViewModel: ObservableObject, Identifiable  { // (6)
  @Published var film: Film
  @Injected var filmRepository: FilmRepository
  
  var id: String = ""
  @Published var completionStateIconName = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  static func newFilm() -> FilmCellViewModel {
    FilmCellViewModel(film: Film(description: "USA wins WWII, but faster", director: "Quentin Taratino", genre:"Action", poster: "https://image.tmdb.org/t/p/w1280/9oikl0CiefCKJXl9yuy9Yq8E9Z.jpg", releaseYear: 2009, starring:["Brad Pitt", "Cristoff Waltz"], title:"", writer:"Quentin Taratino"))
  }
  
  init(film: Film) {
    self.film = film
//
//    $film // (8)
//      .map { $0.completed ? "checkmark.circle.fill" : "circle" }
//      .assign(to: \.completionStateIconName, on: self)
//      .store(in: &cancellables)

//    $film // (7)
//      .map { $0.id }
//      .assign(to: \.id, on: self)
//      .store(in: &cancellables)
    
    $film
      .compactMap { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)
    
    $film
      .dropFirst()
      .debounce(for: 0.8, scheduler: RunLoop.main)
      .sink { film in
        self.filmRepository.updateFilm(film)
      }
      .store(in: &cancellables)

  }
  
}
