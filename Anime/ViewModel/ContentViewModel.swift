//
//  ContentViewModel.swift
//  Anime
//
//  Created by Usha Natarajan on 7/31/21.
//

import Foundation

/**
 View model for Anime Detail
 */
struct ContentViewModel {
    let title: String
    let synopsis: String
    let url: String
    let imageUrl: String
    let animeInfo:[AnimeInfo]
    
    init(_ anime: Results){
        title = anime.title ?? ""
        synopsis = anime.synopsis ?? ""
        url = anime.url ?? ""
        imageUrl = anime.image_url ?? ""
        animeInfo = [
            AnimeInfo(stat: "Type", value: anime.type ?? ""),
            AnimeInfo(stat: "Episodes", value: String(anime.episodes ?? 0)),
            AnimeInfo(stat: "Rated", value: anime.rated ?? ""),
            AnimeInfo(stat: "Airing", value: anime.airing ?? false ? "Currently Airing" : "Finished"),
            AnimeInfo(stat: "Aired", value: anime.airDate),
            AnimeInfo(stat: "Score", value: String(anime.score ?? 0)),
            AnimeInfo(stat: "Members", value: String(anime.members ?? 0))
        ]
    }
}
