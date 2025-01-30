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
    @State var refreshViewTrigger = UUID()
    
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            TabView(selection: $selectedTab.onUpdate(handleTabChange)){
                FeedView()
                    .id(refreshViewTrigger)
                    .tabItem {
                        VStack{
                            Image(systemName: "house")
                                .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                            Text("Home")
                        }
                    }
                    .onAppear { setTabs(0) }
                    .tag(0)
                ExploreView()
                    .tabItem {
                        VStack{
                            Image(systemName: "person.2")
                                .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                            Text("Friends")
                        }
                    }
                    .onAppear { setTabs(1) }
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
                .onAppear { selectedTab = 2 }
                .tag(2)
                
                NotificationsView()
                    .tabItem {
                        VStack{
                            Image(systemName: "ellipsis.message")
                                .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                            Text("Inbox")
                        }
                    }
                    .onAppear { setTabs(3) }
                    .tag(3)
                
                CurrentUserProfileView(authService: authService, currentUser: currentUser)
                    .tabItem {
                        VStack{
                            Image(systemName: "person")
                                .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                            Text("Profile")
                        }
                    }
                    .onAppear { setTabs(4) }
                    .tag(4)
            }
            .tint(.black)
        }
        
    }
    
    private func setTabs(_ input: Int){
        prevSelectedTab = selectedTab
        prevSelectedTab = input
    }
    
    // Handle tab changes
    private func handleTabChange() {
            if selectedTab == prevSelectedTab {
                // User tapped the same tab again
                if selectedTab == 0 {
                    // Only refresh if the feed tab is tapped again
                    print("DEBUG: Feed tab tapped again - refreshing FeedView")
                    refreshViewTrigger = UUID() // Triggers a refresh by changing the ID
                }
            } else {
                // User switched to a different tab
                prevSelectedTab = selectedTab // Update the previous tab
            }
        }
    
}

#Preview {
    MainTabView(authService: AuthService(), user: DeveloperPreview.user, currentUser: DeveloperPreview.currentUser)
}


// MARK: - Binding Extension for Refreshing View
extension Binding {
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
            closure()
        })
    }
}
