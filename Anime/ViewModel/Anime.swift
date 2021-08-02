//
//  Anime.swift
//  Anime
//
//  Created by Usha Natarajan on 7/31/21.
//

import Foundation

class Anime: ObservableObject, Service {
    private var service: ApiService
    private let endpoint =  "https://api.jikan.moe/v3/search/anime?q="
    @Published var results = [Results]()
    
    init(_ search: String = "naruto" ){
        self.service = ApiService(endpoint: "\(endpoint)\(search)")
        self.service.delegate = self
        self.service.getData()
    }
    
    func refreshData(_ with: String) {
        self.service =  ApiService(endpoint: "\(endpoint)\(with)")
        self.service.delegate = self
        self.service.getData()
    }
    
    func didGetData(data: Data) {
        if let anime = try? JSONDecoder().decode(AnimeData.self, from: data){
            DispatchQueue.main.async {
                self.results = anime.results
            }
        }
    }
    
    func didGetError(error: Error) {
        debugPrint(error.localizedDescription)
    }
}
