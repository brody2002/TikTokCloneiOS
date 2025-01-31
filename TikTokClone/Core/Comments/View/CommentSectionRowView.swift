//
//  CommentSectionRowView.swift
//  TikTokClone
//
//  Created by Brody on 1/31/25.
//

import SwiftUI

struct CommentSectionRowView: View {
    let user: User?
    var body: some View {
        HStack(alignment: .top, spacing: 10){
            AvatarView(user: user, size: .xSmall)
            VStack(alignment: .leading, spacing: 5){
                Text("username")
                    .font(.caption2)
                    .foregroundStyle(Color(.systemGray))
                    .fontWeight(.semibold)
                Text("Hello! this is a comment being left in the comment section 🦦")
                    .font(.footnote)
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                HStack(spacing: 10){
                    Text("2025-1-31")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray4))
                    Button(
                        action:{ print("DEBUG: Reply Button") },
                        label:{
                            Text("Reply")
                                .foregroundStyle(Color(.systemGray))
                                .font(.caption)
                        }
                    )
                    Spacer()
                    HStack(spacing: 0){
                        HStack{
                            Image(systemName: "heart")
                                .resizable()
                                .foregroundStyle(Color(.systemGray))
                                .frame(width: 18, height: 18)
                            VStack(alignment: .center){
                                Text("333k")
                                    .foregroundStyle(Color(.systemGray))
                                    .font(.caption2)
                                    .frame(width: 40, alignment: .leading)
                            }
                        }
                        
                        
                        
                        Image(systemName: "hand.thumbsdown")
                            .foregroundStyle(Color(.systemGray))
                    }
                    
                    
                }
                
                    
            }
            Spacer()
        }
    }
}

#Preview {
    CommentSectionRowView(user: DeveloperPreview.user)
}
