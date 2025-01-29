//
//  SearchBarView.swift
//  TikTokClone
//
//  Created by Brody on 1/29/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    var body: some View {
        
        HStack(spacing: 1) {
            Button(action: {
                isFocused = true
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color(.systemGray))
                    .padding(.leading)
            }
            .buttonStyle(PlainButtonStyle())
            
            TextField("Search...", text: $text)
                .padding(.horizontal, 10)
                .frame(height: 36)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .focused($isFocused)
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray6))
        )
        
    }
}

#Preview {
    @Previewable @State var text = ""
    SearchBarView(text: .constant(text))
}
