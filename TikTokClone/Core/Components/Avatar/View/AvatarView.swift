//
//  AvatarView.swift
//  TikTokClone
//
//  Created by Brody on 1/26/25.
//

import Foundation
import SwiftUI
import Kingfisher // used to cache images instead of reloading everytime something comes in view

struct AvatarView: View {
    let user: UserType?
    let size: AvatarSize
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable() 
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundStyle(Color(.systemGray4))
        }
    }
}

#Preview {
    VStack{
        AvatarView(user: DeveloperPreview.user, size: .xxSmall)
        AvatarView(user: DeveloperPreview.user, size: .xSmall)
        AvatarView(user: DeveloperPreview.user, size: .small)
        AvatarView(user: DeveloperPreview.user, size: .medium)
        AvatarView(user: DeveloperPreview.user, size: .large)
        AvatarView(user: DeveloperPreview.user, size: .xLarge)
    }
}
