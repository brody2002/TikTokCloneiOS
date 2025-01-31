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
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .frame(width: 48, height: 48)
                .foregroundStyle(.white)
            ZStack{
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.pink)
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .shadow(radius: 3)
            }
            .offset(y: 30)
        }
        
            
    }
    
}


#Preview {
    FeedCellProfilePhotoView(user: DeveloperPreview.user )
}
