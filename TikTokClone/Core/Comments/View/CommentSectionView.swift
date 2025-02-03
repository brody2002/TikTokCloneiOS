//
//  CommentSectionView.swift
//  TikTokClone
//
//  Created by Brody on 1/31/25.
//

import SwiftUI

struct CommentSectionView: View {
    let post: Post
    let commentSectionViewModel: CommentSectionViewModel
    @State var commentSection: CommentSection?
    @State var commentsArray: [Comment]?
    
    init(post: Post) {
        self.post = post
        self.commentSectionViewModel = CommentSectionViewModel(post: post)
        self.commentSection = nil
        self.commentsArray = nil
    }
    var body: some View {
        VStack{
            Text("\(commentSection?.commentAmount ?? 0)")
                .foregroundStyle(.black)
                .font(.footnote)
                .padding(.top, 32)
            ScrollView{
                LazyVStack(spacing: 15){
                    if let commentsArray = commentsArray {
                        ForEach(commentsArray, id: \.id) { comment in
                            CommentSectionRowView(comment: comment)
                        }
                    }
                }
            }
            .padding(.horizontal)
            // Typing View
            CommentSectionTypingView(post: post)
                .offset(y: -30)
            
        }
        .onTapGesture {
            print("DEBUG: dismissKeyboard")
        }
        .task{
            self.commentSection = try? await commentSectionViewModel.fetchCommentSection(postId: post.id)
            print("\nDEBUG: found CommentsSection \(self.commentSection)\n")
            self.commentsArray = try? await commentSectionViewModel.fetchCommentsOnPost(postId: post.id)
            print("\nDEBUG: found CommentsArary \(self.commentsArray)\n")
        }
        
    }
}

#Preview {
    CommentSectionView(post: DeveloperPreview.post)
}
