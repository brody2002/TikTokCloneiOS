//
//  FeedCellTitleCaption.swift
//  TikTokClone
//
//  Created by Brody on 1/30/25.
//

import SwiftUI

struct FeedCellTitleCaption: View {
    let post: Post // Assume Post is a model with username and caption properties

    var body: some View {
        VStack(alignment: .leading) {
            if let username = post.username {
                Text(username)
                    .fontWeight(.semibold)
                Text(post.caption)
            } else {
                Text("")
                    .fontWeight(.semibold)
                Text("")
            }
        }
        .foregroundStyle(.white)
        .font(.subheadline)
    }
}

#Preview {
    FeedCellTitleCaption(post: DeveloperPreview.post)
}
