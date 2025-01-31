//
//  FeedView.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI
import AVKit

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    @State private var scrollPosition: String?
    @State private var player = AVPlayer()
    @Binding var refreshFeedView: Bool // Binding to receive refresh trigger

    init(scrollPosition: String? = nil, refreshFeedView: Binding<Bool>) {
        self.scrollPosition = scrollPosition
        self._refreshFeedView = refreshFeedView
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.posts) { post in
                    FeedCell(post: post, player: player)
                        .id(post.id)
                        .onAppear {
                            playInitialVideoIfNecessary()
                        }
                }
            }
            .scrollTargetLayout()
        }
        .onAppear { player.play() }
        .onDisappear { player.pause() }
        .scrollPosition(id: $scrollPosition)
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .onChange(of: scrollPosition) { oldPostId, newPostId in
            playVideoOnChangeOfScrollPosition(postId: newPostId)
        }
        .onChange(of: refreshFeedView) { _, _ in
            // Trigger refresh logic when refreshFeedView changes
            
            refreshView()
        }
        .overlay(
            VStack{
                FeedViewNavBar()
                    .padding(.top, 10)
                    .padding(.horizontal)
                Spacer()
            }
        )
        .background(Color.black.ignoresSafeArea())
    }

    func playInitialVideoIfNecessary() {
        guard
            scrollPosition == nil,
            let post = viewModel.posts.first,
            player.currentItem == nil else { return }
        let item = AVPlayerItem(url: URL(string: post.videoURL)!)
        player.replaceCurrentItem(with: item)
    }

    func playVideoOnChangeOfScrollPosition(postId: String?) {
        guard let currentPost = viewModel.posts.first(where: { $0.id == postId }) else { return }

        player.replaceCurrentItem(with: nil)
        let playerItem = AVPlayerItem(url: URL(string: currentPost.videoURL)!)
        player.replaceCurrentItem(with: playerItem)

        // If player is paused
        if player.rate == 0 { player.play() }
    }

    func refreshView() {
        // Refresh the video content
        print("DEBUG: Refreshing FeedView content")
        viewModel.fetchPosts() // Example: Reload posts from the ViewModel
        player.replaceCurrentItem(with: nil) // Reset the player
        if let firstPost = viewModel.posts.first {
            scrollPosition = firstPost.id
            let playerItem = AVPlayerItem(url: URL(string: firstPost.videoURL)!)
            player.replaceCurrentItem(with: playerItem)
            player.play()
        }
    }
}
#Preview {
    FeedView(refreshFeedView: .constant(false))
}
