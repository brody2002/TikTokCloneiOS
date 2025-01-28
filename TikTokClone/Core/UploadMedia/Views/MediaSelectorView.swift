//
//  MediaSelectorView.swift
//  TikTokClone
//
//  Created by Brody on 1/27/25.
//

import SwiftUI
import PhotosUI

struct MediaSelectorView: View{
    @State private var showMediaPicker = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var player = AVPlayer()
    @State private var mediaPreview: Movie?
    var body: some View{
        NavigationStack{
            VStack{
                if let mediaPreview {
                    CustomVideoPlayer(player: player)
                        .onAppear{
                            print("VIDEO PLAYING")
                            player.replaceCurrentItem(with: .init(url: mediaPreview.url))
                        }
                        .padding()
                }
            }
            .task(id: selectedItem){
                await loadMediaPreview(fromItem: selectedItem)
                if selectedItem != nil { player.play()}
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                print("VIEW APPEARED")
                if selectedItem == nil { showMediaPicker = true }
            }
            .onDisappear{
                print("video disapeer")
                player.replaceCurrentItem(with: nil) // Fully clear AVPlayer
                player.pause()
                mediaPreview = nil
                selectedItem = nil
            }
            .photosPicker(isPresented: $showMediaPicker, selection: $selectedItem, matching: .videos)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    NavigationLink {
                        UploadPostView()
                    } label: {
                        Text("Next")
                    }

                }
            }
            .onTapGesture {
                switch player.timeControlStatus {
                case .paused:
                    player.play()
                case .waitingToPlayAtSpecifiedRate:
                    break
                case .playing:
                    player.pause()
                @unknown default:
                    break
                }
            }
        }
    }
}

private extension MediaSelectorView {
    func loadMediaPreview(fromItem item: PhotosPickerItem?) async {
        guard let item else { return }
        self.mediaPreview = try? await item.loadTransferable(type: Movie.self)
        
        
    }
}

#Preview {
    MediaSelectorView()
}
