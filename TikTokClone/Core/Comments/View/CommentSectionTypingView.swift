//
//  CommentSectionTypingView.swift
//  TikTokClone
//
//  Created by Brody on 1/31/25.
//

import SwiftUI
import UIKit

enum FocusField: Hashable {
    case comment
    case emoji
}

struct CommentSectionTypingView: View {
    let post: Post
    @State private var text: String = ""
    @FocusState private var focusField: FocusField?
    let viewModel: CommentSectionViewModel
    let user: User
    @Binding var refreshId: UUID
    
    init(post: Post, user: User, refreshId: Binding<UUID>) {
        self.post = post
        self.viewModel = CommentSectionViewModel(post: post)
        self.user = user
        self._refreshId = refreshId
        self.focusField = nil
    }
    
    private var showSubmitButton: Bool {
        return !text.isEmpty && focusField == nil
    }
    var body: some View {
        VStack(spacing: 8){
            Divider()
            Spacer().frame(height: 2)
            HStack(spacing: 29){
                Button("😁"){ text = text + "😁" }
                Button("🥰"){ text = text + "🥰" }
                Button("😂"){ text = text + "😂" }
                Button("😳"){ text = text + "😳" }
                Button("😏"){ text = text + "😏" }
                Button("😅"){ text = text + "😅" }
                Button("🥺"){ text = text + "🥺" }
            }
            .focused($focusField, equals: .emoji)
            .font(.system(size: 24))
            HStack(spacing: 20){
                AvatarView(user: user, size: .xSmall)
                TextField("Add comment...", text: $text)
                    .foregroundStyle(.black)
                    .font(.callout)
                    .padding(8)
                    .padding(.leading, 10)
                    .background(
                        Capsule()
                            .fill(Color(.systemGray6))
                    )
                    .focused($focusField, equals: .comment) // Use local FocusState
                    .overlay(
                        HStack{
                            Spacer()
                            CommentsSubmitButton()
                                .padding(.trailing, 10)
                                .offset(x: showSubmitButton ? 0 : 200)
                                .animation(.spring(response: 0.3), value: showSubmitButton)
                                .onTapGesture {
                                    Task{ await submitComment(comment: text) }
                                }
                        }
                    )
                    .submitLabel(.send)
                    .onSubmit {
                        Task {
                            await submitComment(comment: text)
                        }
                    }
                
                	
                // CATCH submission button notification
                
            }
        }
        .padding(.horizontal)
        .background( Color(.white) )
    }
}

extension CommentSectionTypingView {
    
    struct CommentsSubmitButton: View {
        var body: some View{
            Button(
                action:{},
                label:{
                    Capsule()
                        .fill(.pink)
                        .frame(width: 50, height: 30)
                        .overlay(
                            Image(systemName: "arrow.up")
                                .resizable()
                                .foregroundStyle(.white)
                                .frame(width: 12, height: 14)
                        )
                }
            )
        }
    }

    func submitComment(comment: String) async {
        do { try await viewModel.uploadCommentToFirebase(message: comment) }
        catch { print("DEBUG: Couldn't Upload comment") }
        self.text = ""
        self.focusField = nil
        refreshId = UUID()
    }
}

#Preview {
    CommentSectionTypingView(post: DeveloperPreview.post, user: DeveloperPreview.user, refreshId: .constant(UUID()))
}
