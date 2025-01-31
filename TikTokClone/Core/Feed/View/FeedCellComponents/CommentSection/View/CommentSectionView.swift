//
//  CommentSectionView.swift
//  TikTokClone
//
//  Created by Brody on 1/31/25.
//

import SwiftUI

struct CommentSectionView: View {
    var body: some View {
        Text("5 Comments")
            .foregroundStyle(.black)
            .font(.footnote)
            .padding(.top, 32)
        ScrollView{
            LazyVStack(spacing: 15){
                CommentSectionRowView(user: DeveloperPreview.user)
                CommentSectionRowView(user: DeveloperPreview.user)
                CommentSectionRowView(user: DeveloperPreview.user)
                CommentSectionRowView(user: DeveloperPreview.user)
                CommentSectionRowView(user: DeveloperPreview.user)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    CommentSectionView()
}
