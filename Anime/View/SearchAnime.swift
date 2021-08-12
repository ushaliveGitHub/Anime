//
//  SearchAnime.swift
//  Anime
//
//  Created by Usha Natarajan on 7/31/21.
//

import SwiftUI

struct SearchAnime: View {
    struct Constants {
        static let blurRadius: CGFloat = 20
        static let columns: CGFloat = 1
        static let duration: CGFloat = 0.2
    }
    
    @State private var showingSheet = false
    @ObservedObject var anime:Anime = Anime() // stores all anime view models
    @State var animeItem: Results? // stores single anime detail view model
    @State var searchText = "" // the search text
    @State var isEditing = false // to track search field editing state
    
    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment: .bottom){
                VStack {
                    
                    // Search bar
                    if !showingSheet {
                        SearchView(searchText: $searchText, size: geo.size, isEditing: $isEditing)
                            .onChange(of: searchText) { _ in
                                anime.refreshData(searchText)
                            }
                    }

                    // The search results
                    ScrollView{
                        ForEach(anime.results, id:\.mal_id){ item in
                            AnimeRow(anime: item,
                                     size: geo.size)
                                .frame(width: geo.size.width, height: geo.size.height / 4, alignment: .leading)
                                .onTapGesture {
                                    self.animeItem = item
                                    showingSheet.toggle()
                                }
                        }.blur(radius: isEditing ? Constants.blurRadius : .zero) // blur when searching
                        //}
                    }.blur(radius: showingSheet ? Constants.blurRadius : .zero) // blur when presenting detail sheet
                        .disabled(showingSheet || isEditing ) // Disable the scroll view when content detail or search view is presenting
                }
                
                // The Content Detail
                VStack(spacing: .zero){
                    ContentView(anime: animeItem, showingSheet: $showingSheet)
                        .frame(height: geo.size.height)
                        .layoutPriority(2)
                }
                .layoutPriority(1)
                .frame(height: showingSheet ? nil : .zero, alignment: .top)
                .animation(.linear(duration: Constants.duration))
            }
            
        }
    }
}


struct SearchAnime_Previews: PreviewProvider {
    static var previews: some View {
        SearchAnime()
    }
}
