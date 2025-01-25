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
    var body: some View {
        NavigationStack{
            VStack{
                PhotosPicker(selection: $selectedPickerItem, matching: .images){
                    VStack{
                        if let image = profileImage {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                                .foregroundStyle(Color(.systemGray4))
                        }
                        
                        
                        Text("Change photo")
                    }
                    
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 24){
                    Text("About you")
                        .font(.footnote)
                        .foregroundStyle(Color(.systemGray2))
                        .fontWeight(.semibold)
                    
                    HStack{
                        Text("Name")
                        Spacer()
                        Text("LeBron James")
                    }
                    HStack{
                        Text("Username")
                        Spacer()
                        Text("lebron.james06")
                    }
                    HStack{
                        Text("Bio")
                        Spacer()
                        Text("Add a bio")
                    }
                }
                .font(.subheadline)
                .padding()
                
                Spacer()
            }
            .task(id: selectedPickerItem){
                await loadImage(fromItem: selectedPickerItem)
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button("Cancel"){
                        
                    }
                    .foregroundStyle(.black)
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Done"){
                        
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

extension EditProfileView {
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.profileImage = Image(uiImage: uiImage)
    }
}

#Preview {
    EditProfileView()
}
