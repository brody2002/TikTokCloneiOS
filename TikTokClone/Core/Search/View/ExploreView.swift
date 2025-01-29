//
//  ExploreView.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import Foundation
import SwiftUI

struct ExploreView: View{
    @StateObject var viewModel = ExploreViewModel(userService: UserService())
    @State var searchText: String = ""
    
    private var filteredUsers: [User] {
        if searchText.isEmpty { return viewModel.users } else {
            return viewModel.users.filter {
                $0.username.localizedCaseInsensitiveContains(searchText) ||
                $0.fullName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View{
        NavigationStack{
            SearchBarView(text: $searchText)
                .padding(.horizontal)
                .padding(.top, 4)
            ScrollView{
                LazyVStack(spacing: 16){
                    ForEach(filteredUsers){ user in
                        NavigationLink(value: user){
                            UserCell(user: user)
                        }
                    }
                }
                
            }
        
            .navigationDestination(for: User.self, destination: { user in
                UserProfileView(user: user)
            })
            .padding(.horizontal)
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top)
        }
    }
}

#Preview{
    NavigationStack{
        ExploreView()
    }
}

