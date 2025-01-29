//
//  CurrentUserPostGridFeedView.swift
//  TikTokClone
//
//  Created by Brody on 1/29/25.
//


import SwiftUI
import AVKit

struct ProfileFeedView: View {
    @State private var scrollPosition: String?
    @State var sourcePost: Post
    @State private var player = AVPlayer()
    @State var posts: [Post]
    
    init(sourcePost: Post, posts: [Post]){
        self.sourcePost = sourcePost
        self.posts = posts
    }
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 0){
                ForEach(posts) { post in
                    FeedCell(post: post, player: player)
                        .id(post.id)
                        .onAppear{
                            playInitialViideoIfNecessary()
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $scrollPosition)
        .onAppear{ player.play() }
        .onDisappear{ player.pause() }
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .onChange(of: scrollPosition){ oldPostId, newPostId in
            playVideoOnChangeOfScrollPosition(postId: newPostId)
        }
        .navigationBarBackButtonHidden()
    }
    
    func playInitialViideoIfNecessary(){
        scrollPosition = sourcePost.id
        let item = AVPlayerItem(url: URL(string: sourcePost.videoURL)!)
        player.replaceCurrentItem(with: item)
    }
    
    func playVideoOnChangeOfScrollPosition(postId: String?){
        guard let currentPost = posts.first(where: { $0.id == postId }) else { return }
        
        player.replaceCurrentItem(with: nil)
        let playerItem = AVPlayerItem(url: URL(string: currentPost.videoURL)!)
        player.replaceCurrentItem(with: playerItem)
        
        // if player is paused
        if player.rate == 0 { player.play() }
    }
}


