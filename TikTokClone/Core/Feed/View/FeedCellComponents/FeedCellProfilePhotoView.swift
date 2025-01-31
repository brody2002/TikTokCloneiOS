//
//  FeedCellProfilePhotoView.swift
//  TikTokClone
//
//  Created by Brody on 1/30/25.
//

import SwiftUI
import Kingfisher

struct FeedCellProfilePhotoView: View {
    var user: User?
    var body: some View {
        ZStack{
            if let profilePhotoUrl = user?.profileImageUrl{
                KFImage(URL(string: profilePhotoUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .onAppear{print("DEBUG: FEED PROFILE profilePhotoUrl -> \(profilePhotoUrl)")}
            } else {
                Circle()
                    .frame(width: 48, height: 48)
                    .foregroundColor(.gray)
                    .onAppear{print("DEBUG: CIRCLE profilePhotoUrl -> \(user?.profileImageUrl ?? "no url provided")")}
            }
        }
        
            
    }
    
}


#Preview {
    FeedCellProfilePhotoView(user: DeveloperPreview.user )
}
