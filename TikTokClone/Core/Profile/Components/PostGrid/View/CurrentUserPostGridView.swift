//  CurrentUserPostGridView.swift
//  TikTokClone
//
//  Created by Brody on 1/29/25.
//

import SwiftUI

struct CurrentUserPostGridView: View {
    @StateObject var viewModel: PostGridViewModel
    @State var fetchedPosts: [Post]?
    
    init(){
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(userService: UserService()))
    }
    
    private let columns = 3
    private let spacing: CGFloat = 1  // Uniform spacing between items
    
    private var items: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns)
    }
    
    private var width: CGFloat {
        (UIScreen.main.bounds.width - (spacing * CGFloat(columns - 1))) / CGFloat(columns)
    }
    
    var body: some View {
        LazyVGrid(columns: items, spacing: spacing) {
            if let posts = fetchedPosts {
                ForEach(posts) { post in
                    NavigationLink {
                        Text("\(post.id)")
                    } label: {
                        Rectangle()
                            .frame(width: width, height: 160)
                            .clipped()
                    }
//                    Rectangle()
//                        .frame(width: width, height: 160)
//                        .clipped()

                }
            }
            
        }
        .task {
            await viewModel.fetchCurrentUserPosts()
            self.fetchedPosts = viewModel.posts
        }
    }
}

#Preview {
    CurrentUserPostGridView()
}
