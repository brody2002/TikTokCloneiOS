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
    
    @Binding var selectedTab: Int
    @Binding var previousSelectedtab: Int
    var body: some View{
        NavigationStack{
            VStack{
                if let mediaPreview {
                    CustomVideoPlayer(player: player)
                        .onAppear{
                            player.replaceCurrentItem(with: .init(url: mediaPreview.url))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
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
                if selectedItem == nil { showMediaPicker.toggle() }
            }
            .onDisappear{
                player.replaceCurrentItem(with: nil) // Fully clear AVPlayer
                player.pause()
                mediaPreview = nil
                selectedItem = nil
            }
            .photosPicker(isPresented: $showMediaPicker, selection: $selectedItem, matching: .videos)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if let unwrappedItem = selectedItem {
                        NavigationLink {
                            UploadPostView(selectedItem: unwrappedItem)
                        } label: {
                            Text("Next")
                        }
                    } else {
                        Text("Next")
                            .foregroundColor(.gray)
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
            .onChange(of: showMediaPicker){ _, showMediaPickerBool in
                if showMediaPickerBool == false && selectedItem == nil {
                    selectedTab = previousSelectedtab
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
    MediaSelectorView(selectedTab: .constant(2), previousSelectedtab: .constant(1))
}
