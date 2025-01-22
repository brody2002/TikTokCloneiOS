//
//  ExploreView.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import Foundation
import SwiftUI

struct ExploreView: View{
    @State var navPath: NavigationPath = NavigationPath()
    var body: some View{
        NavigationStack(path: $navPath){
            ScrollView{
                LazyVStack(spacing: 16){
                    ForEach(0 ..< 20){ user in
                        UserCell()
                    }
                }
                
            }
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

