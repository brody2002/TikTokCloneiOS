//
//  PostGridView.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI

struct PostGridView: View {
    private let columns = 3
    private let spacing: CGFloat = 1  // Uniform spacing between items
    
    private var items: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns)
    }
    
    private var width: CGFloat {
        (UIScreen.main.bounds.width - (spacing * CGFloat(columns - 1))) / CGFloat(columns)
    }
    
    var body: some View {
        LazyVGrid(columns: items, spacing: spacing) {
            ForEach(0 ..< 25) { _ in
                Rectangle()
                    .frame(width: width, height: 160)
                    .clipped()
            }
        }
    }
}

#Preview {
    PostGridView()
}
