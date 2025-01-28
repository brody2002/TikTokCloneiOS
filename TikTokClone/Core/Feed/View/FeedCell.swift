//
//  FeedCell.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI
import AVKit

struct FeedCell: View {
    let post: Post
    var player: AVPlayer
    
    init(post: Post, player: AVPlayer) {
        self.post = post
        self.player = player
    }
    
    var body: some View {
        ZStack{
            CustomVideoPlayer(player: player)
                .containerRelativeFrame([.horizontal, .vertical])
            VStack{
                Spacer()
                HStack(alignment: .bottom){
                    VStack(alignment: .leading){
                        //User
                        Text("\(post.user)")
                            .fontWeight(.semibold)
                        
                        //Caption
                        optionTextHandlerView(inputData: post.caption)
                    }
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    Spacer()
                    VStack(spacing: 28){
                        
                        ZStack{
                            Circle()
                                .frame(width: 48, height: 48)
                                .foregroundStyle(.gray)
                            ZStack{
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.pink)
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                            }
                            .offset(y: 20)
                        }
                        
                        
                        Button(action:{
                            
                        }, label: {
                            VStack{
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .foregroundStyle(.white)
                                
                                optionTextHandlerView(inputData: post.likesAmount)
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                            
                        })
                        Button(action:{
                            
                        }, label: {
                            VStack{
                                Image(systemName: "ellipsis.bubble.fill")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .foregroundStyle(.white)
                                
                                optionTextHandlerView(inputData: post.commentsAmount)
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                        })
                        
                        Button(action:{
                            
                        }, label: {
                            Image(systemName: "bookmark.fill")
                                .resizable()
                                .frame(width: 22, height: 28)
                                .foregroundStyle(.white)
                        })
                        
                        Button(action:{
                            
                        }, label: {
                            Image(systemName: "arrowshape.turn.up.right.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(.white)
                        })
                    }
                }
                .padding(.bottom, 80)
            }
            .padding()
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
    
    struct optionTextHandlerView: View {
        var inputData: String?
            var body: some View {
                if let data = inputData{
                    Text(data)
                } else { Text("") }
            }
        }
}

#Preview {
    FeedCell(post: DeveloperPreview.post, player: AVPlayer())
}
