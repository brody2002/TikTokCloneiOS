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
   
    @Environment(\.dismiss) var dismiss
    
    let characterLimit: Int = 2200 // Plan to implement
    var body: some View {
        VStack{
            HStack(alignment: .top){
                TextField("Enter your caption", text: $caption, axis: .vertical)
                Spacer()
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 94, height: 140)
                        .clipShape(.rect(cornerRadius: 10))
                        .onAppear { print("DEBUG: SELECTED SHOWED")}
                } else {
                    Image("placeHolderImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 94, height: 140)
                        .clipShape(.rect(cornerRadius: 10))
                        .onAppear { print("DEBUG: DEFAULT SHOWED")}
                }
                
            }
            .id(selectedImage)
            Divider()
            
            Spacer()
            
            Button(
                action: {
                    print("DEBUG: upload post")
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
    }
}

extension UploadPostView {
    private func loadImage() async {
        print("DEBUG: Running loadImage() function")

        do {
            // Load the video URL
            guard let videoData = try await selectedItem.loadTransferable(type: Data.self) else {
                print("DEBUG: NOTHING IS HAPPENING")
                return
            }
            
            // Save the video to a temporary file
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mp4")
            try videoData.write(to: tempURL)
            
            // Generate a thumbnail from the video
            let thumbnail = await generateThumbnail(for: tempURL)
            
            await MainActor.run {
                self.selectedImage = thumbnail
                self.imageID = UUID()
                print("DEBUG: SELECTED IMAGE SET")
            }
        } catch {
            print("Error loading image: \(error)")
        }
    }

    /// Generates a thumbnail image from a video URL
    private func generateThumbnail(for url: URL) async -> UIImage? {
        let asset = AVAsset(url: url)
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
