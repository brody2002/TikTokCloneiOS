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
            
            NavigationLink { if let user = user { UserProfileView(user: user) } }
            label: {
                AvatarView(user: user, size: .medium)
            }
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .frame(width: 48, height: 48)
                .foregroundStyle(.white)
            Button(
                action:{
                    print("DEBUG: Follow User")
                },
                label:{
                    ZStack{
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.pink)
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.black)
                            .shadow(radius: 3)
                    }
                }
            )
            .offset(y: 30)
        }
        
        
    }
    
}


#Preview {
    NavigationStack{
        FeedCellProfilePhotoView(user: DeveloperPreview.user )
    }
    
}
