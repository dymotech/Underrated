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


//struct FilmListView: View {
//    let films: [Film] = [Film(image: "van"),Film(image: "van"),Film(image: "van")]
//    var body: some View {
//        return NavigationView {
//            ScrollView(.vertical, showsIndicators: true) {
//                VStack {
////                    CardyView(image: "van")
////                    CardyView(image: "van")
////                    CardyView(image: "van")
////                    CardyView(image: "van")
//                    ForEach(films) { film in
//                        NavigationLink(destination: FilmDetailView(film:  Film(image: "van"))) {
////                            Text("Show Detail View")
////                            VStack{
//                                CardView(image: "van")
////                            }
//                        }
////                        .buttonStyle(.plain)
//                        .buttonStyle(PlainButtonStyle())
//
//                    }
//                }
//            }
//            .navigationBarTitle("Films", displayMode: .automatic)
//        }
//    }
//}

//struct FilmListView: View {
//      let films: [[Film]] = [[Film(image: "van"),Film(image: "van")],[Film(image: "van"),Film(image: "van")]]
//
//    var body: some View {
//        return NavigationView {
//        List {
//            HStack(alignment: .center) {
//                       Image("van")
//                           .resizable()
//                           .scaledToFit()
//
//                Image("van")
//                    .resizable()
//                    .scaledToFit()
//
//                   }
//            HStack(alignment: .center) {
//                         Image("van")
//                             .resizable()
//                             .scaledToFit()
//
//                  Image("van")
//                      .resizable()
//                      .scaledToFit()
//
//                     }
//
//        }.padding(EdgeInsets.init(top: 0, leading: -20, bottom: 0, trailing: -20))
//        }.navigationBarTitle("Films", displayMode: .automatic)
//    }
//}




struct FilmListViewGrid: View {
  @State var films: [Film] = []
    @State var style = ModularGridStyle(.vertical, columns: .count(2), rows: .min(200))

  var body: some View {
    return NavigationView {
        ScrollView(style.axes) {
            Grid(films) { film in
                Image(film.poster)
                     .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
            }
            .gridStyle(self.style)
            .animation(.easeInOut)
        }
        .navigationBarTitle("Films", displayMode: .automatic)

  }
}
}

//}

//struct CardyView: View {
//    var image: String;
//    var body: some View {
//        VStack {
////              Spacer()
//            CardView(image: image)
////              Spacer()
//            Spacer()
//            Spacer()
//          }
//    }
//}

struct FilmListViewGrid_Previews: PreviewProvider {
    static var previews: some View {
        FilmListViewGrid()
    }
}

// Make new .swift file!
//struct TitleAndImageView: View {
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text("Design")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(Color.white)
//
//                Text("Everything new.")
//                    .fontWeight(.medium)
//                    .foregroundColor(Color.white)
//            }
//
//            Spacer()
//
//            Image(systemName: "faceid")
//                .font(.system(size: 72))
//                .foregroundColor(Color.white)
//        }
//        .padding([.horizontal, .bottom])
//    }
//}


// Make new .swift file!
//struct CardView: View {
//    var image: String;
//    var body: some View {
////        NavigationLink(destination: ItemDetail(item: item)) {
////        NavigationLink(destination: FilmDetailView(film:  Film(image: "van")))
////        {
//            VStack(alignment: .center) {
//                Image(image)
//                    .resizable()
//    //                .aspectRatio(contentMode: .fill)
//                    .aspectRatio(contentMode: .fit)
//    //                .frame(width: 320, height: 180)
//                    .cornerRadius(10)
//    //                .padding()
//
//                VStack {
//    //                Text("Look a house")
//    //                    .font(.title)
//    //                    .fontWeight(.semibold)
//    //                    .padding(.bottom)
//
//                    Text("It would sure be nice to have a house\nlike that, right?")
//                        .font(.body)
//                        .lineLimit(2)
//                        .multilineTextAlignment(.center)
//                }
//    //            .padding()
//
//    //            Button(action: {
//    //                print("Tap tap tap...")
//    //            }) {
//    //                Text("Learn More?")
//    //                    .foregroundColor(Color.black)
//    //                    .padding()
//    //                    .background(Color(red: 1.0, green: 0.6, blue: 0, opacity: 0.6))
//    //                    .cornerRadius(12)
//    //            }
//    //            .padding()
//            }
//            .padding()
//            .background(Color.white)
//            .cornerRadius(28)
////        }
//    }
//}

struct GridCell: View {
  var film: Film

  var body: some View {
    VStack() {
      Image(film.poster)
        .resizable()
        .scaledToFit()
    }
//   NavigationLink(destination: FilmDetailView(film:  Film(image: "van"))) {
////                            Text("Show Detail View")
////                            VStack{
//            CardView(image: "van")
////                            }
//    }
////                        .buttonStyle(.plain)
//    .buttonStyle(PlainButtonStyle())

    }
  }

