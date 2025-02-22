//
//  EditProfileView.swift
//  TikTokClone
//
//  Created by Brody on 1/25/25.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @State private var selectedPickerItem: PhotosPickerItem?
    @State private var profileImage: Image?
    @State private var uiImage: UIImage?
    
    @Environment(\.dismiss) var dismiss
    @StateObject var manager = EditProfileManager(imageUploader: ImageUploader())
    @ObservedObject var currentUser: CurrentUser
    
    var body: some View {
        NavigationStack{
            VStack{
                PhotosPicker(selection: $selectedPickerItem, matching: .images){
                    VStack{
                        if let image = profileImage {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: avatarSize.dimension, height: avatarSize.dimension)
                                .clipShape(Circle())
                        } else {
                            AvatarView(user: currentUser, size: avatarSize)
                        }
                        Text("Change photo")
                            .foregroundStyle(.black)
                    }
                    
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 24){
                    Text("About you")
                        .font(.footnote)
                        .foregroundStyle(Color(.systemGray2))
                        .fontWeight(.semibold)
                    
                    EditProfileOptionRowView(option: EditProfileOptions.name, value: currentUser.fullName)
                    EditProfileOptionRowView(option:EditProfileOptions.username, value: currentUser.username)
                    EditProfileOptionRowView(option: EditProfileOptions.bio, value: currentUser.bio ?? "Add a bio")
                }
                .font(.subheadline)
                .padding()
                
                Spacer()
            }
            .task(id: selectedPickerItem){
                await loadImage(fromItem: selectedPickerItem)
            }
            .navigationDestination(for: EditProfileOptions.self, destination: { option in
                EditProfileDetailView(option: option, user: currentUser, manager: manager)
                
            })
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundStyle(.black)
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Done"){
                        onDoneTapped()
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                }
            }
            .onAppear { print("imageURL STRING: \(currentUser.profileImageUrl ?? "nothing")")}
        }
    }
}

private extension EditProfileView {
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    func onDoneTapped() {
        Task {
            if let uiImage {
                let imageUrl = await manager.uploadProfileImage(uiImage)
                currentUser.profileImageUrl = imageUrl
                print("done tapped: Image url: \(currentUser.profileImageUrl ?? "n/a")")
            }
            dismiss()
        }
    }

    var avatarSize: AvatarSize {
        return .large
    }
}


#Preview {
    @Previewable @State var previewUser = DeveloperPreview.currentUser
    EditProfileView(currentUser: previewUser)
}
