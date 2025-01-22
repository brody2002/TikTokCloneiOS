//
//  FeedCell.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI

struct FeedCell: View {
    let post: Int
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.pink)
                .containerRelativeFrame([.horizontal, .vertical])
                .overlay(
                    Text("Post \(post)")
                        .foregroundStyle(.white)
                )
            VStack{
                Spacer()
                HStack(alignment: .bottom){
                    VStack(alignment: .leading){
                        Text("carlos.sainz")
                            .fontWeight(.semibold)
                        
                        Text("Rocket ship prepare for takeoff!!!")
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
                            .offset(y: 22)
                        }
                        
                        
                        Button(action:{
                            
                        }, label: {
                            VStack{
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .foregroundStyle(.white)
                                
                                Text("27")
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
                                
                                Text("27")
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
    }
}

#Preview {
    FeedCell(post: 2)
}
