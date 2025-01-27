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
                            player.replaceCurrentItem(with: .init(url: mediaPreview.url))
                            player.play()
                        }
                        .padding()
                }
            }
            .task(id: selectedItem){
                print("doing something")
                await loadMediaPreview(fromItem: selectedItem)
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { showMediaPicker.toggle() }
            .photosPicker(isPresented: $showMediaPicker, selection: $selectedItem, matching: .videos)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Next"){
                        print("DEBUG: Go to upload post...")
                    }
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
