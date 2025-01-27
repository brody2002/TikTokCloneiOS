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
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(Color(.systemGray5))
                
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
            EditProfileView(user: user)
        }
    }
}

#Preview {
    ProfileHeaderView(user: DeveloperPreview.user)
}
