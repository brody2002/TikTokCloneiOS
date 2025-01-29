//
//  UploadVideoState.swift
//  TikTokClone
//
//  Created by Brody on 1/28/25.
//

import Foundation

class UploadVideoState: ObservableObject {
    @Published var isVideoPosted: Bool
    init(isVideoPosted: Bool) {
        self.isVideoPosted = isVideoPosted
    }
}
