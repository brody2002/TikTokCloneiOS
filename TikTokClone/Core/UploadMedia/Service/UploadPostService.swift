//
//  UploadPostService.swift
//  TikTokClone
//
//  Created by Brody on 1/28/25.
//


import UIKit
import Firebase
import FirebaseAuth

class UploadPostService: ObservableObject {
    
    private let videoUploader: VideoUploader
    
    init(videoUploader: VideoUploader) {
        self.videoUploader = videoUploader
    }
    
    func uploadPost(_ inputUrl: URL, caption: String) async {
        do {
            print("DEBUG: inputUrl \(inputUrl)")
            let postUrl = try await videoUploader.uploadVideo(videoURL: inputUrl) // returns firebase url
            print("DEBUG: postURL: \(postUrl ?? "No Url")")
            try await updateUserPostDict(postUrl, caption: caption)
        } catch {
            print("DEBUG: Handle video uploader error here...")
        }
    }
    
    // Needs to capture postId as well as make a function that can add multiple post ids, 
    func updateUserPostDict(_ videoUrl: String?, caption: String) async throws {
        guard let videoUrl else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let postId = NSUUID().uuidString
        let postData: [String: Any] = [
            "postId": postId,
            "id": currentUid,
            "videoUrl": "\(videoUrl)",
            "caption": caption
        ]
        // Uploads postData to firebase under postId
        try await FirestoreConstants.PostCollection.document(postId).setData(postData)
        
        // Uploads new post to userDatabase
        try await FirestoreConstants.UsersCollection.document(currentUid).updateData([
            "postIds": FieldValue.arrayUnion([postId])
        ])
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
//            ├── caption: "caption message"
//            ├── timestamp: 1706467200
