//
//  UploadPostService.swift
//  TikTokClone
//
//  Created by Brody on 1/28/25.
//


import UIKit
import AVKit
import Firebase
import FirebaseAuth

class UploadPostService: ObservableObject {
    
    private let videoUploader: VideoUploader
    private let imageUploader: ImageUploader
    
    init(videoUploader: VideoUploader, imageUploader: ImageUploader) {
        self.videoUploader = videoUploader
        self.imageUploader = imageUploader
    }
    
    func uploadPost(_ inputUrl: URL, caption: String) async {
        do {
            // Create firebase video/image Urls
            let videoUrl = try await videoUploader.uploadVideo(videoURL: inputUrl)
            guard let thumbnailImage = await generateThumbnail(for: inputUrl) else { return }
            let imageUrl = try await imageUploader.uploadImage(image: thumbnailImage)
            
            try await updateUserPostDict(videoUrl, imageUrl, caption: caption)
            
        } catch {
            print("DEBUG: Error uploading post - \(error.localizedDescription)")
        }
    }
    
    private func updateUserPostDict(_ videoUrl: String?, _ imageUrl: String?, caption: String) async throws {
        guard let videoUrl else { return }
        guard let imageUrl else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let timeStamp = formatDate()
        
        let postId = NSUUID().uuidString
        let postData: [String: Any] = [
            "postId": postId,
            "id": currentUid, // userId
            "videoUrl": "\(videoUrl)",
            "imageUrl": imageUrl,
            "timestamp": timeStamp,
            "caption": caption,
            "likesAmount": 0,
            "commentsAmount": 0,
            "savesAmount": 0,
            "commentSection": CommentSection(
                id: NSUUID().uuidString,
                commentAmount: 0,
                commentList: [Comment]()
            )
        ]
        
        // Uploads postData to firebase under postId
        try await FirestoreConstants.PostCollection.document(postId).setData(postData)
        
        // Uploads new post to userDatabase
        try await FirestoreConstants.UsersCollection.document(currentUid).updateData([
            "postIds": FieldValue.arrayUnion([postId])
        ])
    }

    private func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: Date())
        return dateString
    }

    private func generateThumbnail(for videoUrl: URL?) async -> UIImage? {
        guard let url = videoUrl else { return nil }
        let asset = AVURLAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        do {
            let cgImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch {
            print("DEBUG: Failed to generate thumbnail - \(error.localizedDescription)")
            return nil
        }
    }
}





// Storage concept

//        /Users/{userId}/
//            ├── username: "Brody"
//            ├── postIds: ["post001", "post002", "post003"]
//
//        /Posts/{post001}/
//            ├── postId: "post001"
//            ├── userId: "user123"
//            ├── videoUrl: "sfsefksekfskefk.mp4"
//            ├── imageUrl: 1706467200
//            ├── caption: "caption message"
//            ├── timestamp: 1706467200

