//
//  CommentSectionTypingView.swift
//  TikTokClone
//
//  Created by Brody on 1/31/25.
//

import SwiftUI

struct CommentSectionTypingView: View {
    let post: Post
    @Binding var isTextFieldFocused: Bool // Binding to control focus
    @State private var text: String = ""
    @FocusState private var focusState: Bool
    
    private var showSubmitButton: Bool { return !text.isEmpty && !focusState }
    
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
            .font(.system(size: 24))
            HStack(spacing: 20){
                AvatarView(user: DeveloperPreview.user, size: .xSmall)
                TextField("Add comment...", text: $text)
                    .foregroundStyle(.black)
                    .font(.callout)
                    .padding(8)
                    .padding(.leading, 10)
                    .background(
                        Capsule()
                            .fill(Color(.systemGray6))
                    )
                    .focused($focusState) // Use local FocusState
                    .onChange(of: focusState) {_, newValue in
                        isTextFieldFocused = newValue // Sync with parent
                    }
                    .onChange(of: isTextFieldFocused) {_, newValue in
                        focusState = newValue // Sync with child
                    }
                    .overlay(
                        HStack{
                            Spacer()
                            CommentsSubmitButton()
                                .padding(.trailing, 10)
                                .offset(x: showSubmitButton ? 0 : 200)
                                .animation(.spring(response: 0.3), value: showSubmitButton)
                        }
                    )
                    .submitLabel(.send)
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
    
    
}

#Preview {
    CommentSectionTypingView(post: DeveloperPreview.post, isTextFieldFocused: .constant(false))
}
