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
    let userService = UserService()
    @State var user: User?
    @State var refreshCommentSectionId = UUID()
    
    init(post: Post) {
        self.post = post
        self.commentSectionViewModel = CommentSectionViewModel(post: post)
        self.commentSection = nil
        self.commentsArray = nil
    }
    var body: some View {
        VStack{
            Text("Comments: \(commentSection?.commentAmount ?? 0)")
                .foregroundStyle(.black)
                .font(.footnote)
                .padding(.top, 32)
            ScrollView{
                LazyVStack(spacing: 15){
                    if let commentsArray = commentsArray {
                        ForEach(commentsArray.sorted(by: { $0.timestamp > $1.timestamp })) { comment in
                            CommentSectionRowView(comment: comment)
                        }
                    }
                }
            }
            .padding(.horizontal)
            // Typing View
            if let user = user {
                CommentSectionTypingView(post: post, user: user, refreshId: $refreshCommentSectionId)
                    .offset(y: -30)
            }
        }
        .task{
            self.commentSection = try? await commentSectionViewModel.fetchCommentSection(postId: post.id)
            self.commentsArray = try? await commentSectionViewModel.fetchCommentsOnPost(postId: post.id)
            self.user = try? await userService.fetchCurrentUser()
            
        }
        .onChange(of: self.refreshCommentSectionId) { _, _ in
            Task{
                print("DEBUG: Update to the comments section")
                self.commentsArray = try? await commentSectionViewModel.fetchCommentsOnPost(postId: post.id)
            }
            
        }
        
    }
}

#Preview {
    CommentSectionView(post: DeveloperPreview.post)
}
