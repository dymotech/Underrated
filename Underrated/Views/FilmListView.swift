////
////  MovieView.swift
////  Underrated
////
////  Created by Cody Martin on 3/3/20.
////  Copyright © 2020 Cody Martin. All rights reserved.
////
//
//import SwiftUI
//
//struct MovieView: View {
//    var body: some View {
//        Text("Hello, MOVIES!")
//    }
//}
//
//struct CardView: View {
//    var image: String
//    var category: String
//    var heading: String
//    var author: String
//
//    var body: some View {
//    VStack {
//        Image(image)
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//
//        HStack {
//            VStack(alignment: .leading) {
//                Text(category)
//                    .font(.headline)
//                    .foregroundColor(.secondary)
//                Text(heading)
//                    .font(.title)
//                    .fontWeight(.black)
//                    .foregroundColor(.primary)
//                    .lineLimit(3)
//                Text(author)
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//            }
//            .layoutPriority(100)
//
//            Spacer()
//        }
//        .padding()
//    }
//    .cornerRadius(10)
//    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1))
//
//    .padding([.top, .horizontal])
//    }
//}
//
//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
////        MovieView()
//        CardView(image: "van", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Simon Ng")
//    }
//}


import SwiftUI
//import QGrid
import Grid


struct FilmListView: View {
    let films: [Film] = []
    var body: some View {
        return NavigationView {
            VStack{
                FilmStripView(films: films)
                FilmStripView(films: films)
                FilmStripView(films: films)
            }
//            EmptyView()
            .navigationBarTitle("Films", displayMode: .automatic)
        }
    }
}

struct FilmStripView: View {
    var films : [Film];
    var body: some View {
    return ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 10) {
            ForEach(films) { film in
                NavigationLink(destination: FilmDetailView()) {
                    CardView(image: film.poster)
                }
                .buttonStyle(PlainButtonStyle())

            }
        }
        .frame(height: 200)
        .padding(.leading, 10)
        }
    }
}



//struct FilmListView: View {
//  @State var films: [Film] = [Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van"),Film(image: "van")]
//    @State var style = ModularGridStyle(.vertical, columns: .count(2), rows: .min(200))
//
//  var body: some View {
//    return NavigationView {
//        ScrollView(style.axes) {
//            Grid(films) { film in
//                Image(film.image)
//                     .renderingMode(.original)
//                        .resizable()
//                        .scaledToFit()
//                        .aspectRatio(contentMode: .fit)
//            }
//            .gridStyle(self.style)
//            .animation(.easeInOut)
//        }
//        .navigationBarTitle("Films", displayMode: .automatic)
//
//  }
//}


struct FilmListView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListView()
    }
}

struct CardView: View {
    var image: String;
    var body: some View {
        // 1
//        GeometryReader { geometry in
                        
            // 2
            VStack() {
                Image(self.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
//                    .frame(width: geometry.size.width / 2, height: geometry.size.height * 0.75)
//                .cornerRadius(10)
    //                .padding()
//                    .scaledToFill()
//                    .frame(width: geometry.size.width, height: geometry.size.height * 0.75) // 3
//                    .clipped()
                
//                HStack {
//                    VStack(alignment: .leading, spacing: 6) {
//                        Text("Debra Weber, 28")
//                            .font(.title)
//                            .bold()
//                        Text("Judge")
//                            .font(.subheadline)
//                            .bold()
//                        Text("13 Mutual Friends")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                    }
//                    Spacer() // Add a spacer to push our HStack to the left and the spacer fill the empty space
//
//                    Image(systemName: "info.circle")
//                        .foregroundColor(.gray)
//                }.padding(.horizontal)
            }
//            .padding()
//            .frame(width: geometry.size.width, height: 300)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 5)
//    }
            // Add padding, corner radius and shadow with blur radius

//        }
    }
}


