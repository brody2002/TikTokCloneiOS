//  CurrentUserPostGridView.swift
//  TikTokClone
//
//  Created by Brody on 1/29/25.
//

import SwiftUI
import AVKit
//hello
struct CurrentUserPostGridView: View {
    @State private var player = AVPlayer()
    @StateObject var viewModel: PostGridViewModel
    @State var fetchedPosts: [Post]?
    
    @Namespace private var zoomNameSpace
    
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
                        ProfileFeedView(sourcePost: post, posts: posts)
                            .navigationTransition(.zoom(sourceID: "\(post.id)", in: zoomNameSpace))
                            .ignoresSafeArea()
                    } label: {
                        Rectangle()
                            .frame(width: width, height: 160)
                            .clipped()
                            .matchedTransitionSource(id: "\(post.id)", in: zoomNameSpace)
                    }
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
