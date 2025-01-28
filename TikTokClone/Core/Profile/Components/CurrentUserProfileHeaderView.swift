//
//  ProfileHeaderView.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI

struct CurrentUserProfileHeaderView: View {
    @ObservedObject var currentUser: CurrentUser
    @State private var showEditProfile = false
    var body: some View {
        VStack(spacing: 16){
            VStack(spacing: 8){
                // profile Image
                AvatarView(user: currentUser, size: .large)
                
                // username
                Text(currentUser.username)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            
            // Stats View
            HStack(spacing: 16){
                UserStatView(value: 5, title: "Following")
                UserStatView(value: 63, title: "Followers")
                UserStatView(value: 100, title: "Likes")
            }
            
            //action Button
            Button(
                action:{
                    showEditProfile.toggle()
                },
                label:{
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 360, height: 32)
                        .foregroundStyle(.black)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            )
            
            Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(currentUser: currentUser)
        }
    }
}

#Preview {
    ProfileHeaderView(user: DeveloperPreview.user)
}

