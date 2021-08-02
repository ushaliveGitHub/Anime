//
//  AnimeRow.swift
//  Anime
//
//  Created by Usha Natarajan on 8/1/21.
//

import SwiftUI

struct AnimeRow: View {
    var anime: Results
    var size: CGSize

    struct Constants {
        static let hSpace: CGFloat = 5
        static let vSpace: CGFloat = 10
        static let radius: CGFloat = 10
        static let titleSize: CGFloat = 14
        static let synopsisSize: CGFloat = 12
        static let inset: CGFloat = 10
    }
    
    var body: some View {
        HStack(spacing: Constants.hSpace){
           PosterView(url: anime.image_url)
                .frame(width: size.width / 3, alignment: .leading)
                .cornerRadius(Constants.radius)
            VStack(spacing: Constants.hSpace){
                HStack {
                    Text(anime.title ?? "")
                        .font(.system(size: Constants.titleSize, weight: .semibold))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                        .font(.body)
                }
                Text(anime.synopsis ?? "")
                    .font(.system(size: Constants.synopsisSize, weight: .regular))
            }
        }.padding(EdgeInsets(top: .zero, leading: Constants.inset, bottom: .zero, trailing:  Constants.inset))
        
    }
}
