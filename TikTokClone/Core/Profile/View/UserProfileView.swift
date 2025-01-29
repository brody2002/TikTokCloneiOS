//
//  UserProfileView.swift
//  TikTokClone
//
//  Created by Brody on 1/25/25.
//

import SwiftUI

struct UserProfileView: View {
    let user: User
    let isCurrentUser: Bool = false
    var body: some View {
        ScrollView{
            VStack(spacing: 2){
                // Profile header
                ProfileHeaderView(user: user)
                
                // Posts grid view
                PostGridView(user: user)
                
            }
            .padding(.top)
        }
        .navigationTitle("\(user.fullName)")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    UserProfileView(user: DeveloperPreview.user)
}
