//
//  FeedViewNavBar.swift
//  TikTokClone
//
//  Created by Brody on 1/30/25.
//

import SwiftUI

struct FeedViewNavBar: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: StrokeStyle(lineWidth: 1))
                .fill(Color(.systemGray6))
                .frame(height: 40)
            HStack(spacing: 10){
                Image("TikTokLive")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color(.systemGray3))
                    .padding(.leading)
                Spacer()
            }
            .overlay(
                VStack(spacing: 4){
                    Text("For You")
                        .padding(.horizontal, 10)
                        .frame(height: 18)
                        .cornerRadius(8)
                        .foregroundStyle(Color(.systemGray3))
                        .font(.system(size: 16))
                        .bold()
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 40, height: 2)
                        .foregroundStyle(Color(.systemGray3))
                }
            )
            
        }
        

        
    }
}

#Preview {
    FeedViewNavBar()
}
