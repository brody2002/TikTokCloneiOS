//
//  MainTabView.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    @State private var prevSelectedTab: Int = 0
    let authService: AuthService
    let user: User
    @StateObject var uploadVideoState = UploadVideoState(isVideoPosted: false)
    @ObservedObject var currentUser: CurrentUser
    
    
    var body: some View {
        TabView(selection: $selectedTab){
            FeedView()
                .tabItem {
                    VStack{
                        Image(systemName: "house")
                            .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                        Text("Home")
                    }
                }
                .onAppear {
                    selectedTab = 0
                    prevSelectedTab = 0
                }
                .tag(0)
            ExploreView()
                .tabItem {
                    VStack{
                        Image(systemName: "person.2")
                            .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                        Text("Friends")
                    }
                }
                .onAppear {
                    selectedTab =  1
                    prevSelectedTab = 0
                }
                .tag(1)
            
            MediaSelectorView(
                selectedTab: $selectedTab,
                previousSelectedtab: $prevSelectedTab,
                uploadVideoState: uploadVideoState
            )
                .tabItem {
                    Image(systemName: "plus")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                }
                .onAppear {
                    selectedTab = 2
                }
                .tag(2)
            
            NotificationsView()
                .tabItem {
                    VStack{
                        Image(systemName: "ellipsis.message")
                            .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                        Text("Inbox")
                    }
                }
                .onAppear {
                    selectedTab = 3
                    prevSelectedTab = 3
                }
                .tag(3)
            
            CurrentUserProfileView(authService: authService, currentUser: currentUser)
                .tabItem {
                    VStack{
                        Image(systemName: "person")
                            .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                        Text("Profile")
                    }
                }
                .onAppear {
                    selectedTab = 4
                    prevSelectedTab = 4
                }
                .tag(4)
        }
        .tint(.black)
    }
        
}

#Preview {
    MainTabView(authService: AuthService(), user: DeveloperPreview.user, currentUser: DeveloperPreview.currentUser)
}

