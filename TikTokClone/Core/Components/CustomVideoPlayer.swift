//
//  CustomVideoPlayer.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import Foundation
import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.exitsFullScreenWhenPlaybackEnds = true
        controller.allowsPictureInPicturePlayback = true // shrinks a video into a small player
        controller.videoGravity = .resizeAspectFill // makes video full screen
        controller.allowsVideoFrameAnalysis = false
        controller.requiresLinearPlayback = true
        
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
