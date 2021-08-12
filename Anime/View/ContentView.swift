//
//  ContentView.swift
//  Anime
//
//  Created by Usha Natarajan on 8/2/21.
//

import SwiftUI
/**
 The detail view
 */
struct ContentView: View {
    var anime: Results?
    @Binding var showingSheet: Bool
    var body: some View {
        if let anime = anime {
            Card(showingSheet: $showingSheet, contentModel: ContentViewModel(anime))
        }else{
            EmptyView()
        }
    }
}

struct Card: View {
    @Binding var showingSheet: Bool
    
    private struct constant {
        static let shadowRadius: CGFloat = 10.0
        static let sampleImage = UIImage(named:"sampleAnime") ?? UIImage()
        static let width: CGFloat = 50.0
        static let height: CGFloat = 4.0
    }
    private var indicator: some View {
            Capsule()
            .fill(Color.secondary)
            .frame(width: constant.width, height: constant.height)
    }

    var contentModel: ContentViewModel
    var body: some View {
        VStack(alignment:.center) {
            GeometryReader{ geo in
                ZStack(alignment: .topLeading){
                    VStack{
                        Text(contentModel.title)
                            .font(.headline)
                            .padding()
                        HStack {
                            PosterView(url: contentModel.imageUrl)
                                .frame(width: geo.size.width / 2, height: geo.size.width , alignment: .leading)
                            Info(info: contentModel.animeInfo, synopsis: contentModel.synopsis, url: contentModel.url)
                                .frame(width: geo.size.width / 2, height: geo.size.width , alignment: .center)
                            
                        }
                        Text(contentModel.synopsis)
                            .padding(.top,10)
                            .font(.system(size: 14, weight: .semibold))
                    }
                }.shadow(radius: constant.shadowRadius)
                .padding(.bottom, 10)
            }
        }.padding()
    }
}


//Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(anime: Results(mal_id: 34,
                                   url: "",
                                   image_url: "",
                                   title: "Dounika Naru Hibi",
                                   airing: false,
                                   synopsis: "",
                                   type: "Movie",
                                   episodes: 50,
                                   score: 7.9,
                                   start_date: "Dec 31, 1994",
                                   end_date: "Mar 23, 2000",
                                   members: 9876,
                                   rated: "R"),
                    showingSheet: .constant(false))
    }
}


//Donot delete
//                        Button(action: {
//                            //dismiss()
//                            self.showingSheet = false
//                        }, label: {
//                            VStack{
//                                indicator
//                                    .frame(width: geo.size.width, height: 4, alignment: .center)
//                                    .padding(.top)
//                            }
//                        })

