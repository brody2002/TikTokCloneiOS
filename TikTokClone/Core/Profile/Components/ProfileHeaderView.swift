//
//  ProfileHeaderView.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    @State private var showEditProfile = false
    var body: some View {
        VStack(spacing: 16){
            VStack(spacing: 8){
                // profile Image
                AvatarView(user: user, size: .large)
                
                // username
                Text(user.username)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            
            // Stats View
            HStack(spacing: 16){
                UserStatView(value: 5, title: "Following")
                UserStatView(value: 63, title: "Followers")
                UserStatView(value: 100, title: "Likes")
            }
            
            Divider()
        }
    }
}

#Preview {
    ProfileHeaderView(user: DeveloperPreview.user)
}
