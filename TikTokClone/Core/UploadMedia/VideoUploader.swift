//
//  Untitled.swift
//  TikTokClone
//
//  Created by Brody on 1/28/25.
//

import Foundation
import UIKit
import FirebaseStorage


struct VideoUploader {

    enum VideoUploadError: Error {
        case fileNotFound
        case dataConversionFailed
        case uploadFailed(Error)
        case urlRetrievalFailed(Error)
    }
    
    /// Uploads a video to Firebase Storage and returns the download URL
    func uploadVideo(videoURL: URL) async throws -> String? {
        let filename = NSUUID().uuidString + ".mp4" // new file name
        let ref = Storage.storage().reference(withPath: "/videos/\(filename)")
        print("DEBUG: from uploadVideo() videoUrl: \(videoURL)")
        do {
            let videoData = try Data(contentsOf: videoURL)
            print("DEBUG: videoData made")
            let _ = try await ref.putDataAsync(videoData)
            print("DEBUG: putDataAsync")
            let url = try await ref.downloadURL()
            print("DEBUG: url made \(url)")
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload video with error: \(error)")
            return nil
        }
    }
    
    
    
    
}

