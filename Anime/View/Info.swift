//
//  Info.swift
//  Anime
//
//  Created by Usha Natarajan on 8/2/21.
//

import SwiftUI

struct Info: View {
    var info:[AnimeInfo]
    var synopsis: String
    var url: String
    
    struct constants {
        static let titleSize = CGSize(width: 65, height: 20)
        static let infoSize = CGSize(width: 100, height: 30)
        static let linkSize = CGSize(width: 100, height: 30)
        static let webLink =  UIImage(named:"webLink") ?? UIImage()
        static let linkImage = CGSize(width: 20, height: 20)
        static let linkFont:CGFloat = 12
        static let space:CGFloat = 10
        
    }
    var body: some View {
        VStack(alignment: .leading, spacing: constants.space) {
            ForEach(info, id:\.self) { item in
                InfoRow(item:item,
                        titleSize: constants.titleSize,
                        infoSize: constants.infoSize)
            }
            if let urlLink = URL(string: url) {
                Link(destination: urlLink) {
                    HStack {
                        Image(uiImage:constants.webLink)
                            .resizable()
                            .frame(width: constants.linkImage.width, height: constants.linkImage.height)
                        Text("External website")
                            .foregroundColor(.blue)
                            .font(.system(size: constants.linkFont , weight: .semibold))
                        
                    }.frame(width: constants.linkSize.width,
                            height: constants.linkSize.height, alignment: .bottomLeading)
                }
            }
        }
    }
}



struct InfoRow: View {
    var item: AnimeInfo
    var titleSize: CGSize
    var infoSize: CGSize
    struct constants {
        static let stat: CGFloat = 12
        static let item: CGFloat = 10
    }
    
    var body: some View {
        HStack(spacing:.zero){
            
            Text("\(item.stat):")
                .font(.system(size: constants.stat, weight: .bold))
                .frame(width: titleSize.width,
                       height: titleSize.height, alignment: .leading)
            Text(item.value)
                .font(.system(size: constants.item, weight: .semibold))
                .frame(width: infoSize.width,
                       height: infoSize.height, alignment: .leading)
        }
    }
}

