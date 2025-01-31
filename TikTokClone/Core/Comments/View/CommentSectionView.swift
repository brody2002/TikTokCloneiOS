//
//  CommentSectionView.swift
//  TikTokClone
//
//  Created by Brody on 1/31/25.
//

import SwiftUI

struct CommentSectionView: View {
    let post: Post
    @State private var isTextFieldFocused: Bool = false
    var body: some View {
        VStack{
            Text("5 Comments")
                .foregroundStyle(.black)
                .font(.footnote)
                .padding(.top, 32)
            ScrollView{
                LazyVStack(spacing: 15){
                    ForEach(0 ..< 10){_ in
                        CommentSectionRowView(user: DeveloperPreview.user)
                    }
                }
            }
            .padding(.horizontal)
            // Typing View
            CommentSectionTypingView(post: DeveloperPreview.post, isTextFieldFocused: $isTextFieldFocused)
                .offset(y: -30)
            
        }
        .onTapGesture {
            print("DEBUG: dismissKeyboard")
            isTextFieldFocused = false
        }
        
    }
}

enum focusField {
    case commentsTextField
}

#Preview {
    CommentSectionView(post: DeveloperPreview.post)
}
