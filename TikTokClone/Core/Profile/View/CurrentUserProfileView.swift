//
//  CurrentUserProfileView.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    let authService: AuthService
    @ObservedObject var currentUser: CurrentUser
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 2){
                    // Profile header
                    CurrentUserProfileHeaderView(currentUser: currentUser)
                    
                    // Posts grid view
                    PostGridView()
                    
                }
                .padding(.top)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Sign Out"){
                        print("DEBUG: Sign out here...")
                        clearCurrentUser()
                        authService.signOut()
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

extension CurrentUserProfileView {
    private func clearCurrentUser(){
        currentUser.fullName = ""
        currentUser.email = ""
        currentUser.username = ""
        currentUser.id = ""
        currentUser.bio = nil
        currentUser.profileImageUrl = nil
    }
}

#Preview {
    @Previewable @State var previewUser = DeveloperPreview.currentUser
    CurrentUserProfileView(authService: AuthService(), currentUser: previewUser)
}
