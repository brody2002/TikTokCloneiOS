//
//  PostGridView.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI

struct PostGridView: View {
    @StateObject var viewModel: PostGridViewModel
    @State var fetchedPosts: [Post]?
    let user: User
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(userService: UserService()))
        self.user = user
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

                }
            }
            
        }
        .task {
            await viewModel.fetctUserPosts(user: user)
            self.fetchedPosts = viewModel.posts
        }
    }
}

#Preview {
    PostGridView(user: DeveloperPreview.user)
}

