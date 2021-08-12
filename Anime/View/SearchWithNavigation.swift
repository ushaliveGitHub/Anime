//
//  SearchWithNavigation.swift
//  Anime
//
//  Created by Usha Natarajan on 8/10/21.
//

import SwiftUI

struct SearchWithNavigation: View {
    struct Constants {
        static let blurRadius: CGFloat = 20
        static let columns: CGFloat = 1
        static let duration: CGFloat = 0.2
        static let border: CGFloat = 0.2
    }
    
    @State private var showingSheet = false
    @ObservedObject var anime:Anime = Anime() // stores all anime view models
    @State var animeItem: Results? // stores single anime detail view model
    @State var searchText = "" // the search text
    @State var isEditing = false // to track search field editing state
    
    var body: some View {
        GeometryReader{ geo in
            NavigationView{
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
                                NavigationLink(destination: ContentView(anime: item, showingSheet: $showingSheet)) {
                                    AnimeRow(anime: item,
                                             size: geo.size)
                                        .padding()
                                        .frame(width: geo.size.width * 0.90, height: geo.size.height / 4, alignment: .leading)
                                        .overlay( // Frame for search bar
                                            RoundedRectangle(cornerRadius: Constants.blurRadius)
                                                .stroke("text".colorForAsset(), lineWidth: Constants.border)
                                        )
                                        .padding(.top)
                                        .shadow(radius: Constants.blurRadius / 4)
                                }
                            }.blur(radius: isEditing ? Constants.blurRadius : .zero) // blur when searching
                        }.blur(radius: showingSheet ? Constants.blurRadius : .zero) // blur when presenting detail sheet
                            .disabled(showingSheet || isEditing ) // Disable the scroll view when content detail or search view is presenting
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
}


struct SearchWithNavigation_Previews: PreviewProvider {
    static var previews: some View {
        SearchWithNavigation()
    }
}


extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
