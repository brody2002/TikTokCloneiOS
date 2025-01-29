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
        do {
            let videoData = try Data(contentsOf: videoURL)
            let _ = try await ref.putDataAsync(videoData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload video with error: \(error)")
            return nil
        }
    }
}

