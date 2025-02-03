//
//  SavedView.swift
//  TikTokClone
//
//  Created by Brody on 2/3/25.
//

import SwiftUI

struct BookmarkView: View {
    @State var width: CGFloat
    @State var height: CGFloat
    let inputData: Int
    
    // Bookmark Modifiers
    @State var bookmarkColor: Bool = false
    @State var bookmarkSize: CGFloat = 28.00
    init(width: CGFloat = 28, height: CGFloat = 28, inputData: Int) {
        self.width = width
        self.height = height
        self.inputData = inputData
    }
    
    var body: some View {
        VStack{
            Image(systemName: "bookmark.fill")
                .resizable()
                .frame(width: bookmarkSize, height: bookmarkSize)
                .foregroundStyle(bookmarkColor ? Color.gray : Color.white)
                .onTapGesture { bookmarkToggleFunc() }
            
            PostNumericsHandler(inputData: inputData)
                .font(.caption)
                .foregroundStyle(.white)
                .bold()
        }
    }
    
    private func bookmarkToggleFunc() {
        if bookmarkColor == false {
            withAnimation(.spring(response: 0.2)){
                bookmarkColor.toggle()
                bookmarkSize = 34.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation(.spring(response: 0.2)) { bookmarkSize = 28.0 }
            }
        } else { withAnimation(.spring(response: 0.3)){ bookmarkColor.toggle() } }
    }
}
