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
    
    @Namespace private var zoomNameSpace
    
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
                    
                    // Individual posts in the grid
                    NavigationLink {
                        ProfileFeedView(sourcePost: post, posts: posts)
                            .navigationTransition(.zoom(sourceID: "\(post.id)", in: zoomNameSpace))
                            .ignoresSafeArea()
                    } label: {
                        GridImageView(width: width, postUrl: post.imageUrl)
                            .clipped()
                            .matchedTransitionSource(id: "\(post.id)", in: zoomNameSpace)
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

