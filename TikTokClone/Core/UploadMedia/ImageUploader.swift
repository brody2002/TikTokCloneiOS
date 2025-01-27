//
//  ImageUploader.swift
//  TikTokClone
//
//  Created by Brody on 1/26/25.
//

import Foundation
import UIKit
import FirebaseStorage


struct ImageUploader {
    func uploadImage(image: UIImage) async throws -> String? { // returned string is the url to the image in cloud storage
        guard  let imageData = image.jpegData(compressionQuality: 0.25) else { return nil }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        }
        catch {
            print("DEBUG: Failed to upload image with error: \(error)")
            return nil
        }
    }
}
