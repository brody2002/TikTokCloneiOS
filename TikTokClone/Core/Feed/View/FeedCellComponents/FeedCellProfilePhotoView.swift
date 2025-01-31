//
//  FeedCellProfilePhotoView.swift
//  TikTokClone
//
//  Created by Brody on 1/30/25.
//

import SwiftUI
import Kingfisher

struct FeedCellProfilePhotoView: View {
    let profilePhotoUrl: String?
    var body: some View {
        if let photoUrl = profilePhotoUrl {
            KFImage(URL(string: photoUrl))
                .clipShape(Circle())
                .frame(width: 48, height: 48)
                .foregroundStyle(.gray)
        } else {
            Circle()
                .frame(width: 48, height: 48)
                .foregroundStyle(.gray)
        }
        
        
            
    }
}

#Preview {
    FeedCellProfilePhotoView(profilePhotoUrl: "")
}
