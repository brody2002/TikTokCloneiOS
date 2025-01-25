//
//  ExploreView.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import Foundation
import SwiftUI

struct ExploreView: View{
    @StateObject var viewModel = ExploreViewModel(userService: MockUserService())
    
    var body: some View{
        NavigationStack{
            ScrollView{
                LazyVStack(spacing: 16){
                    ForEach(viewModel.users){ user in
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
    ExploreView()
}

