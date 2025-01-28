//
//  EditProfileManager.swift
//  TikTokClone
//
//  Created by Brody on 1/26/25.
//


import UIKit
import Firebase
import FirebaseAuth

class EditProfileManager: ObservableObject {
    private let imageUploader: ImageUploader
    init(imageUploader: ImageUploader) {
        self.imageUploader = imageUploader
    }
    
    func uploadProfileImage(_ uiImage: UIImage) async -> String? {
        do {
            let profileImageURL = try await imageUploader.uploadImage(image: uiImage) // ✅ Creates the URL
            try await updateUserProfileImageURL(profileImageURL) // ✅ Updates Firebase
            return profileImageURL // ✅ Return URL so EditProfileView can update `user`
        }
        catch {
            print("DEBUG: Handle image uploader error here...")
            return nil
        }
    }

    private func updateUserProfileImageURL(_ imageUrl: String?) async throws {
        guard let imageUrl else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await FirestoreConstants.UsersCollection.document(currentUid).updateData([
            "profileImageUrl": imageUrl
        ])
    }
    
}
