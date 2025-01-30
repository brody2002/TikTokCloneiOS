//
//  GridImageView.swift
//  TikTokClone
//
//  Created by Brody on 1/30/25.
//

import SwiftUI
import Kingfisher

struct GridImageView: View {
    let width: CGFloat
    let postUrl: String?
    var body: some View {
        if let imageUrl = postUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: width, height: 160)
                .onAppear{ print("DEBUG: postUrl\(postUrl ?? "nothing")")}
        } else {
            Rectangle()
                .foregroundStyle(.black)
                .frame(width: width, height: 160)
                
        }
    }
}

