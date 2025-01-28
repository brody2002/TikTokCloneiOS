//
//  VideoPreview.swift
//  TikTokClone
//
//  Created by Brody on 1/28/25.
//

import SwiftUI

struct VideoPreview: View {
    let selectedImage: UIImage?
    var body: some View {
        if let image = selectedImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 94, height: 140)
                .clipShape(.rect(cornerRadius: 10))
        } else {
            Image("placeHolderImage")
                .resizable()
                .scaledToFill()
                .frame(width: 94, height: 140)
                .clipShape(.rect(cornerRadius: 10))
        }
    }
}

