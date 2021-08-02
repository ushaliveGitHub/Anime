//
//  PosterView.swift
//  Anime
//
//  Created by Usha Natarajan on 8/1/21.
//

import SwiftUI
/**
 #The View for the anime image.
 Initialized with placeholder image until image can be fetched from API or from Image Cache.
 */
struct PosterView: View {
    @ObservedObject var photo: Poster
    
    init(url: String?){
        photo = Poster(url)
    }
    
    var body: some View {
        Image(uiImage: photo.image ??  PosterView.placeHolder)
            .resizable()
            //.scaledToFit() // I like the Image view streched 🙂
    }
    
    static var placeHolder = UIImage(named:"placeHolderImage") ?? UIImage()
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView(url: nil)
    }
}
