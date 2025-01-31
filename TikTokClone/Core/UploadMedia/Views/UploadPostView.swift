//
//  UploadPostView.swift
//  TikTokClone
//
//  Created by Brody on 1/27/25.
//

import SwiftUI
import PhotosUI
import AVFoundation

struct UploadPostView: View {
    let selectedItem: PhotosPickerItem
    @State private var caption = ""
    @State private var imageID = UUID()
    @State private var selectedImage: UIImage?
    @ObservedObject private var uploadManager = UploadPostService(videoUploader: VideoUploader(), imageUploader: ImageUploader())
    @ObservedObject var uploadVideoState: UploadVideoState
    @State var postURL: URL?
    @Environment(\.dismiss) var dismiss
    
    let characterLimit: Int = 2200 // Plan to implement
    var body: some View {
        VStack{
            HStack(alignment: .top){
                TextField("Enter your caption", text: $caption, axis: .vertical)
                Spacer()
                
                // Video Preview View
                VideoPreview(selectedImage: selectedImage)
            }
            .id(selectedImage)
            Divider()
            
            Spacer()
            
            Button(
                action: {
                    print("DEBUG: upload post")
                    Task {
                        // Uploads Post
                        await uploadManager.uploadPost(postURL ?? URL(fileURLWithPath: ""), caption: caption)
                        try FileManager.default.removeItem(at: postURL!)
                        await MainActor.run {
                            uploadVideoState.isVideoPosted = true
                            dismiss()
                        }
                    }
                },
                label: {
                    Text("Post")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 354, height: 44)
                        .background(Color(.systemPink))
                        .cornerRadius(8)
                }
            )
        }
        .padding()
        .navigationTitle("Post")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button(
                    action: {
                        dismiss()
                    },
                    label: {
                        Image(systemName: "lessthan")
                    }
                )
            }
        }
        .task { await loadImage()}
        .onDisappear{ }
    }
}

extension UploadPostView {
    
    private func loadImage() async {
        do {
            // Load the video URL
            guard let videoData = try await selectedItem.loadTransferable(type: Data.self) else { return }
            
            // Save the video to a temporary file
            postURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mp4")
            try videoData.write(to: postURL!)
            
            // Generate a thumbnail from the video
            let thumbnail = await generateThumbnail(for: postURL!)
            await MainActor.run {
                self.selectedImage = thumbnail
                self.imageID = UUID()
            }
        } catch { print("Error loading image: \(error)") }
    }

    /// Generates a thumbnail image from a video URL
    private func generateThumbnail(for url: URL) async -> UIImage? {
        let asset = AVURLAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        do {
            let cgImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch {
            print("DEBUG: Failed to generate thumbnail: \(error)")
            return nil
        }
    }
}



