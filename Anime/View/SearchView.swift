//
//  SearchView.swift
//  Anime
//
//  Created by Usha Natarajan on 8/1/21.
//

import SwiftUI

/**
 Search view 
 */
struct SearchView: View {
    @Binding var searchText: String
    @State var size: CGSize
    @State var text = ""
    @Binding var isEditing: Bool
    
    struct Constants {
        static let radius: CGFloat = 10
        static let lineWidth: CGFloat = 0.25
        static let height: CGFloat = 4.0
    }
    
    var body: some View {
        
        TextField("Search ⏎", text: $text, onCommit: { // The search field
            self.isEditing = false
            self.searchText = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        })
        .onAppear { // to detect when keyboard is shown to add a blur to search results
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                self.isEditing = true
            }
        }
        .padding(.vertical)
        .frame(width: size.width / 2, height: Constants.height)
        .padding()
        .cornerRadius(Constants.radius)
        .disableAutocorrection(true)
        .overlay( // Frame for search bar
            RoundedRectangle(cornerRadius: Constants.radius)
                .stroke(Color.gray, lineWidth: Constants.lineWidth)
        )
    }
}
