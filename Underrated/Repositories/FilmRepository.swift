//
//  FilmRepository.swift
//  Underrated
//
//  Created by Cody Martin on 3/27/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import Foundation
import Disk

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
//import FirebaseFunctions

import Combine
import Resolver

class BaseFilmRepository {
  @Published var films = [Film]()
}

protocol FilmRepository: BaseFilmRepository {
  func addFilm(_ film: Film)
  func removeFilm(_ film: Film)
  func updateFilm(_ film: Film)
}

class TestDataFilmRepository: BaseFilmRepository, FilmRepository, ObservableObject {
  override init() {
    super.init()
    self.films = testDataFilms
  }
  
  func addFilm(_ film: Film) {
    films.append(film)
  }
  
  func removeFilm(_ film: Film) {
    if let index = films.firstIndex(where: { $0.id == film.id }) {
      films.remove(at: index)
    }
  }
  
  func updateFilm(_ film: Film) {
    if let index = self.films.firstIndex(where: { $0.id == film.id } ) {
      self.films[index] = film
    }
  }
}

class LocalFilmRepository: BaseFilmRepository, FilmRepository, ObservableObject {
  override init() {
    super.init()
    loadData()
  }
  
  func addFilm(_ film: Film) {
    self.films.append(film)
    saveData()
  }
  
  func removeFilm(_ film: Film) {
    if let index = films.firstIndex(where: { $0.id == film.id }) {
      films.remove(at: index)
      saveData()
    }
  }
  
  func updateFilm(_ film: Film) {
    if let index = self.films.firstIndex(where: { $0.id == film.id } ) {
      self.films[index] = film
      saveData()
    }
  }
  
  private func loadData() {
    if let retrievedFilms = try? Disk.retrieve("films.json", from: .documents, as: [Film].self) { // (1)
      self.films = retrievedFilms
    }
  }
  
  private func saveData() {
    do {
      try Disk.save(self.films, to: .documents, as: "films.json") // (2)
    }
    catch let error as NSError {
      fatalError("""
        Domain: \(error.domain)
        Code: \(error.code)
        Description: \(error.localizedDescription)
        Failure Reason: \(error.localizedFailureReason ?? "")
        Suggestions: \(error.localizedRecoverySuggestion ?? "")
        """)
    }
  }
}


class FirestoreFilmRepository: BaseFilmRepository, FilmRepository, ObservableObject {
  @LazyInjected var db: Firestore
  @LazyInjected var authenticationService: AuthenticationService
//  @LazyInjected var functions: Functions

  var filmsPath: String = "films"
  var userId: String = "unknown"
  
  private var listenerRegistration: ListenerRegistration?
  private var cancellables = Set<AnyCancellable>()
  
  override init() {
    super.init()
    
    authenticationService.$user
      .compactMap { user in
        user?.uid
      }
      .assign(to: \.userId, on: self)
      .store(in: &cancellables)
    
//     (re)load data if user changes
    authenticationService.$user
      .receive(on: DispatchQueue.main)
      .sink { user in
        self.loadData()
      }
      .store(in: &cancellables)
  }
  
  private func loadData() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
    }
    listenerRegistration = db.collection(filmsPath)
      .whereField("userId", isEqualTo: self.userId)
//      .order(by: "createdTime")
      .addSnapshotListener { (querySnapshot, error) in
        if let querySnapshot = querySnapshot {
          self.films = querySnapshot.documents.compactMap { document -> Film? in
            try? document.data(as: Film.self)
          }
        }
      }
  }
  
  func addFilm(_ film: Film) {
    do {
      var userFilm = film
      userFilm.userId = self.userId
      let _ = try db.collection(filmsPath).addDocument(from: userFilm)
    }
    catch {
      fatalError("Unable to encode film: \(error.localizedDescription).")
    }
  }
  
  func removeFilm(_ film: Film) {
    if let filmID = film.id {
      db.collection(filmsPath).document(filmID).delete { (error) in
        if let error = error {
          print("Unable to remove document: \(error.localizedDescription)")
        }
      }
    }
  }
  
  func updateFilm(_ film: Film) {
    if let filmID = film.id {
      do {
        try db.collection(filmsPath).document(filmID).setData(from: film)
      }
      catch {
        fatalError("Unable to encode film: \(error.localizedDescription).")
      }
    }
  }
  
//  func migrateFilms(fromUserId: String) {
//    let data = ["previousUserId": fromUserId]
//    functions.httpsCallable("migrateFilms").call(data) { (result, error) in
//      if let error = error as NSError? {
//        print("Error: \(error.localizedDescription)")
//      }
//      print("Function result: \(result?.data ?? "(empty)")")
//    }
//  }
}
