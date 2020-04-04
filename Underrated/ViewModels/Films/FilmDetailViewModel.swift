//
//  FilmStripCellViewModel.swift
//  Underrated
//
//  Created by Cody Martin on 3/29/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import Foundation
import Combine
import Resolver

class FilmDetailViewModel: ObservableObject  {
    @Published var filmRepository: FilmRepository = Resolver.resolve()
//  @Published var film: Film
  
  var id: String = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
//    self.film = film
//
//    $film // (8)
//      .map { $0.completed ? "checkmark.circle.fill" : "circle" }
//      .assign(to: \.completionStateIconName, on: self)
//      .store(in: &cancellables)

//    $film // (7)
//      .map { $0.id }
//      .assign(to: \.id, on: self)
//      .store(in: &cancellables)
    
//    $film
//      .compactMap { $0.id }
//      .assign(to: \.id, on: self)
//      .store(in: &cancellables)
    
//    $film
//      .dropFirst()
//      .debounce(for: 0.8, scheduler: RunLoop.main)
//      .sink { film in
//        self.filmRepository.updateFilm(film)
//      }
//      .store(in: &cancellables)

  }
    
    func addFilm(film: Film) {
        filmRepository.addFilm(film)
    }
  
}

