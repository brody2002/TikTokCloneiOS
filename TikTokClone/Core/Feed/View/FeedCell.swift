//
//  FeedCell.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI
import AVKit
import Kingfisher

struct FeedCell: View {
    let post: Post
    var player: AVPlayer
    let userService: UserService
    @State var user: User?
    @State var showCommentSheet: Bool = false
    
    
    
    init(post: Post, player: AVPlayer) {
        self.post = post
        self.player = player
        self.userService = UserService()
    }
    
    var body: some View {
        ZStack{
            CustomVideoPlayer(player: player)
                .containerRelativeFrame([.horizontal, .vertical])
            VStack{
                Spacer()
                HStack(alignment: .bottom){
                    FeedCellTitleCaption(post: post)
                        .animation(.spring(response: 0.3), value: post.username)
                    Spacer()
                    VStack(spacing: 20){
                        FeedCellProfilePhotoView(user: user)
                            .padding(.bottom, 2)
                        Button(
                            action:{print("DEBUG: Add to like count")},
                            label: {  HeartView(inputData: post.likesAmount) })
                        .frame(width: 32, height: 32)
                        Button(
                            action:{ showCommentSheet.toggle() },
                            label: { InterfaceItem(imageName: "ellipsis.bubble.fill", inputData: post.commentsAmount) }
                        )
                        Button(
                            action:{ print("DEBUG: Add to saved collection")},
                            label: {  BookmarkView(inputData: post.savesAmount) }
                        )
                        .frame(width: 32, height: 32)
                        
                        Button(
                            action:{ print("DEBUG: Share feature") },
                            label: {
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .foregroundStyle(.white)
                            }
                        )
                        Spacer().frame(height: 2)
                    }
                }
                .padding(.bottom, 80)
            }
            .padding(.leading)
            .padding(.top)
            .padding(.bottom)
            .sheet(isPresented: $showCommentSheet) {
                // Pass in CommentSection from post
                CommentSectionView(post: post)
                    .presentationDetents([.fraction(0.70)])
            }
        }
        .task {
            do {
                self.user = try await userService.fetchSpecificUser(userId: post.userId)
            } catch {
                print("DEBUG: unable to fetch the posted User")
            }
        }
        .onTapGesture {
            switch player.timeControlStatus {
            case .paused:
                player.play()
            case .waitingToPlayAtSpecifiedRate:
                break
            case .playing:
                player.pause()
            @unknown default:
                break
            }
        }
    }
}

extension FeedCell {
    
    struct InterfaceItem: View {
        let imageName: String
        @State var width: CGFloat
        @State var height: CGFloat
        let inputData: Int
        
        init(imageName: String, width: CGFloat = 28, height: CGFloat = 28, inputData: Int) {
            self.imageName = imageName
            self.width = width
            self.height = height
            self.inputData = inputData
        }
        
        var body: some View {
            VStack{
                 Image(systemName: imageName)
                        .resizable()
                        .frame(width: width, height: height)
                        .foregroundStyle(.white)
                PostNumericsHandler(inputData: inputData)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .bold()
            }
        }
    }
}


#Preview {
    FeedCell(post: DeveloperPreview.post, player: AVPlayer())
}
