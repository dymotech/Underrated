//
//  SomeView.swift
//  Underrated
//
//  Created by Cody Martin on 3/26/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

import SwiftUI

struct ContentView2: View {
    
    //MARK: Properties
    @ObservedObject var session = FirebaseSession()
    
    var body: some View {
        
        NavigationView {
            Group {
                if session.session != nil {
                    VStack {
                        NavigationLink(destination: NewTODOView()) {
                            Text("Add TODO")
                        }
                        
                        List {
                            ForEach(self.session.items) { todo in
                                NavigationLink(destination: TODODetailView(todo: todo)) {
                                    TODORowView(todo: todo)
                                }
                            }
                        }
                        .navigationBarItems(trailing: Button(action: {
                            self.session.logOut()
                        }) {
                            Text("Logout")
                        })
                    }
                } else {
                    LoginView()
                    .navigationBarItems(trailing: Text(""))
                }
            }
            .onAppear(perform: getUser)
            .navigationBarTitle(Text("TODO"))
            .padding()
        }
    }
    
    //MARK: Functions
    func getUser() {
        session.listen()
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
  
//
//  NewTODOView.swift
//  TODO
//
//  Created by Sebastian Esser on 9/19/19.
//  Copyright © 2019 Sebastian Esser. All rights reserved.
//
//import SwiftUI

struct NewTODOView: View {
    
    @State private var newTODO = ""
    
    @ObservedObject var session = FirebaseSession()
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Text("TODO:")
                    TextField("Enter TODO", text: $newTODO)
                        .padding()
                }
                Button(action: {
                    self.addTODO()
                }) {
                    Text("Add")
                }
            }
        }
        .padding()
    }
    
    func addTODO() {
        if !newTODO.isEmpty {
            //Add TODO to Firebase
            session.uploadTODO(todo: newTODO)
            dismiss()
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

//struct NewTODOView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTODOView()
//    }
//}


struct SomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//import SwiftUI

struct TODORowView: View {
    
    var todo: TODOS
    
    var body: some View {
        HStack {
            Text(todo.todo)
            
            Spacer()
            
            if todo.isComplete == "true" {
                Image(systemName: "checkmark").imageScale(.medium)
            } else {
                Image(systemName: "xmark").imageScale(.medium)
            }
        }
    }
}

//import SwiftUI

struct TODODetailView: View {
    
    @ObservedObject var session = FirebaseSession()
    @State var complete = false
    
    var todo: TODOS
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 20) {
            Text(todo.todo)
            Spacer()
            VStack {
                Text("Is Complete")
                Button(action: {
                    self.buttonPressed()
                }) {
                    if self.complete == true {
                        Image(systemName: "checkmark").imageScale(.medium)
                    } else {
                        Image(systemName: "xmark").imageScale(.medium)
                    }
                }
                .onAppear() {
                    self.setupButton()
                }
            }
            }
        .padding()
    }
    
    func setupButton() {
        if todo.isComplete == "true" {
            complete = true
        } else {
            complete = false
        }
    }
    
    func buttonPressed() {
        if complete == true {
            self.complete = false
            self.session.updateTODO(key: todo.id!, todo: todo.todo, isComplete: "false")
            print("buttonpressed ran, should set complete, complete is: \(String(describing: self.complete))")
        } else {
            self.complete = true
            self.session.updateTODO(key: todo.id!, todo: todo.todo, isComplete: "true")
            print("buttonpressed ran, should set incomplete, complete is \(String(describing: self.complete))")
        }
    }
}


import SDWebImageSwiftUI


struct FilmCell: View {
  @ObservedObject var filmCellVM: FilmCellViewModel // (1)
  var onCommit: (Result<Film, InputError>) -> Void = { _ in } // (5)
  
  var body: some View {
    HStack {
        WebImage(url: URL(string: filmCellVM.film.poster))
        .onSuccess { image, cacheType in
            // Success
            print("Got image from somewhere \(image) \(cacheType.rawValue)")
        }
//        .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
//        .placeholder(Image(systemName: "photo"))
        .resizable()
        .aspectRatio(contentMode: .fit)
//      Image(filmCellVM.film.poster) // (2)
//        .resizable()
//        .frame(width: 20, height: 20)
//        .onTapGesture {
////          self.filmCellVM.film.completed.toggle()
//        }
      TextField("Enter film title", text: $filmCellVM.film.title, // (3)
                onCommit: { //(4)
                  if !self.filmCellVM.film.title.isEmpty {
                    self.onCommit(.success(self.filmCellVM.film))
                  }
                  else {
                    self.onCommit(.failure(.empty))
                  }
      }).id(filmCellVM.id)
    }
  }
}

enum InputError: Error {
  case empty
}


struct FilmsListView: View {
  @ObservedObject var filmListVM = FilmListViewModel() // (7)
  @State var presentAddNewItem = false
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        List {
          ForEach (filmListVM.filmCellViewModels) { filmCellVM in // (8)
            FilmCell(filmCellVM: filmCellVM) // (1)
          }
          .onDelete { indexSet in
            self.filmListVM.removeFilms(atOffsets: indexSet)
          }
          if presentAddNewItem { // (5)
            FilmCell(filmCellVM: FilmCellViewModel.newFilm()) { result in // (2)
              if case .success(let film) = result {
                self.filmListVM.addFilm(film: film) // (3)
              }
              self.presentAddNewItem.toggle() // (4)
            }
          }
        }
        Button(action: { self.presentAddNewItem.toggle() }) { // (6)
          HStack {
            Image(systemName: "plus.circle.fill")
              .resizable()
              .frame(width: 20, height: 20)
            Text("New Film")
          }
        }
        .padding()
        .accentColor(Color(UIColor.systemRed))
      }
      .navigationBarTitle("Films")
    }
  }
}
