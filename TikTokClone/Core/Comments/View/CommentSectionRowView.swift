//
//  CommentSectionRowView.swift
//  TikTokClone
//
//  Created by Brody on 1/31/25.
//

import SwiftUI

struct CommentSectionRowView: View {
    let userService: UserService
    let comment: Comment
    @State var user: User?
    
    init(comment: Comment) {
        self.userService = UserService()
        self.comment = comment
        self.user = nil
    }
    var body: some View {
        HStack(alignment: .top, spacing: 10){
            AvatarView(user: user, size: .xSmall)
            VStack(alignment: .leading, spacing: 5){
                Text(comment.username)
                    .font(.caption2)
                    .foregroundStyle(Color(.systemGray))
                    .fontWeight(.semibold)
                Text(comment.message)
                    .font(.footnote)
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                HStack(spacing: 10){
                    Text(comment.timestamp)
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
                                Text("\(comment.likes)")
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
        }.task {
            user = try? await userService.fetchSpecificUser(userId: comment.userId)

        }
    }
}

#Preview {
    CommentSectionRowView(comment: DeveloperPreview.comment)
}
