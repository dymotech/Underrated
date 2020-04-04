//
//  Film.swift
//  Underrated
//
//  Created by Cody Martin on 3/27/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Film: Identifiable, Codable {
//    var id = UUID()
//    var image: String;
    @DocumentID var id: String? // (2)
//    var id: String = UUID().uuidString
    @ServerTimestamp var createdTime: Timestamp?
    var description: String;
    var director: String;
    var genre: String;
    var poster: String;
    var releaseYear: Int;
    var starring: [String];
    var title: String;
    var writer: String;
    var userId: String?
    
}

struct TODOS: Identifiable, Codable {
    let todo: String
    let isComplete: String
    var userId: String?
    @DocumentID var id: String? // (2)
    @ServerTimestamp var createdTime: Timestamp?
}

#if DEBUG
let testDataFilms = [
    Film(description: "USA wins WWII, but faster", director: "Quentin Taratino", genre: "Action", poster: "https://image.tmdb.org/t/p/w1280/ai0LXkzVM3hMjDhvFdKMUemoBe.jpg", releaseYear: 2009, starring:["Brad Pitt", "Cristoff Waltz"], title:"Inglourious Basterds", writer:"Quentin Taratino")
//  Task(title: "Implement UI", priority: .medium, completed: false),
//  Task(title: "Connect to Firebase", priority: .medium, completed: false),
//  Task(title: "????", priority: .high, completed: false),
//  Task(title: "PROFIT!!!", priority: .high, completed: false)
]
#endif
