//
//  AnimeData.swift
//  Anime
//
//  Created by Usha Natarajan on 7/30/21.
//

import Foundation

struct AnimeData: Codable {
    let request_hash: String
    let request_cached: Bool
    let request_cache_expiry: Int
    let results: [Results]
}

struct Results: Codable {
    let mal_id: Int
    let url: String?
    let image_url: String?
    let title: String?
    let airing: Bool?
    let synopsis: String?
    let type: String?
    let episodes: Int?
    let score: Double?
    let start_date: String?
    let end_date: String?
    let members: Int?
    let rated: String?
   
    /**
     # Computed property
     # How it works
      Converts start date -  "2002-10-03T00:00:00+00:00" , end date -  "2007-02-08T00:00:00+00:00" =>  air date -  "Oct 3, 2002 to Feb 08, 2007"
     */
    var airDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let startDate = dateFormatter.date(from:start_date?.components(separatedBy: "T").first ?? ""),
           let endDate = dateFormatter.date(from: end_date?.components(separatedBy: "T").first ?? "") {
            dateFormatter.dateFormat = "MMM d, yyyy"
            let start = dateFormatter.string(from:startDate)
            let end = dateFormatter.string(from:endDate)
            return "\(start) to \(end)"
        }
        return " - "
    }
}

