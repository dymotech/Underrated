//
//  ASession.swift
//  Underrated
//
//  Created by Cody Martin on 3/26/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
//import FirebaseDatabase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseSession: ObservableObject {
    
    //MARK: Properties
    @Published var session: User?
    @Published var isLoggedIn: Bool?
    @Published var items: [TODOS] = []

    let db = Firestore.firestore()
    var ref: DatabaseReference = Database.database().reference(withPath: "\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
//    var todoRef: DatabaseReference = Database.database().reference(withPath: "todos")
//    var todos: CollectionReference?
    
    //MARK: Functions
    func listen() {
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let _ = user {
//                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
                self.isLoggedIn = true
//                let settings = FirestoreSettings()
//                Firestore.firestore().settings = settings
                // [END setup]
//                db = Firestore.firestore()
//                self.todos = self.db.collection("todos")
                self.getTODOS()
            } else {
                self.isLoggedIn = false
                self.session = nil
            }
        }
    }
    
    func logIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func logOut() {
            try! Auth.auth().signOut()
            self.isLoggedIn = false
            self.session = nil

    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func getTODOS() {
        
        self.db.collection("todos").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error retreiving collection: \(error)")
            }
//            self.items = []
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
//            let dictionaries = documents.compactMap({$0.data()})
//            let addresses = dictionaries.compactMap({TODOS(from: $0)})
            
            self.items = documents.compactMap { document -> TODOS? in // (3)
              try? document.data(as: TODOS.self) // (4)
            }
            
//            self.items =
//            documents.map {document in
//                let result = Result {
//                    try document.flatMap {
//                        try $0.data(as: TODOS.self)
//                    }
//                }
//                switch result {
//                case .success(let city):
//                    if let city = city {
//                        print("City: \(city)")
//                    } else {
//                        print("Document does not exist")
//                    }
//                case .failure(let error):
//                    print("Error decoding city: \(error)")
//                }
//            }
            
            

            
            
//            let toDo = TODOS(snapshot: snapshot) {
//            self.items.append(toDo)
        }
        
//        self.todos.observe(DataEventType.value) { (snapshot) in
//            self.items = []
//            for child in snapshot.children {
//                if let snapshot = child as? DataSnapshot,
//                    let toDo = TODOS(snapshot: snapshot) {
//                    self.items.append(toDo)
//                }
//            }
//        }
    }
    
    func uploadTODO(todo: String) {
        //Generates number going up as time goes on, sets order of TODO's by how old they are.
        let number = Int(Date.timeIntervalSinceReferenceDate * 1000)
        
//        let postRef = todos.child(String(number))
        let post = TODOS(todo: todo, isComplete: "false")
//        postRef.setValue(post.toAnyObject())
        
        do {
//            try self.db.collection("todos").addDocument(from: post)
            try self.db.collection("todos").document("\(number)").setData(from: post)
            { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
             print("Document added with ID: \(number)")
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
        
//        do {
//          try db.collection("tasks").document(taskID).setData(from: task) // (1)
//        }
//        catch {
//          print("There was an error while trying to update a task \(error.localizedDescription).")
//        }
        
//        self.todos?.document(number).setData(from: )
//            .addDocument(data: post.toAnyObject()) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref.documentID)")
//            }
//        }
    }
    
    func updateTODO(key: String, todo: String, isComplete: String) {
//        let update = ["todo": todo, "isComplete": isComplete]
        let post = TODOS(todo: todo, isComplete: isComplete)
//        let childUpdate = ["\(key)": update]
//        todos.updateChildValues(childUpdate)
        do {
            try self.db.collection("todos").document(key).setData(from: post)
             print("Document added with ID: \(key)")
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
        
    }
    
}
