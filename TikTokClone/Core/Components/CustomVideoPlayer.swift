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
        controller.allowsPictureInPicturePlayback = true
        controller.videoGravity = .resizeAspectFill
        controller.allowsVideoFrameAnalysis = false
        controller.requiresLinearPlayback = true

        // Add observer for video end
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(Coordinator.playerItemDidReachEnd),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update the player if needed
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: CustomVideoPlayer

        init(_ parent: CustomVideoPlayer) {
            self.parent = parent
        }

        @objc func playerItemDidReachEnd(notification: Notification) {
            // Restart the video from the beginning
            parent.player.seek(to: .zero)
            parent.player.play()
        }
    }

    static func dismantleUIViewController(_ uiViewController: UIViewControllerType, coordinator: Coordinator) {
        // Remove the observer when the view is dismantled
        NotificationCenter.default.removeObserver(
            coordinator,
            name: .AVPlayerItemDidPlayToEndTime,
            object: nil
        )
    }
}
