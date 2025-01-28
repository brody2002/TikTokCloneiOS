//
//  EditProfileDetailView.swift
//  TikTokClone
//
//  Created by Brody on 1/26/25.
//

import SwiftUI

struct EditProfileDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var value = ""
    
    let option: EditProfileOptions
    var user: CurrentUser
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                
                TextField("Add your bio", text: $value)
                Spacer()
                if !value.isEmpty{
                    Button(
                        action:{
                            value = ""
                        },
                        label:{
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.gray)
                        }
                    )
                }
            }
            Divider()
            Text(subtitle)
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.top, 8)
            Spacer()
        }
        .padding()
        .navigationTitle(option.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .onAppear{ onViewAppear() }
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel"){ dismiss() }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save"){ dismiss() }
                    .fontWeight(.semibold)
            }
        }
        
    }
}

private extension EditProfileDetailView{
    var subtitle: String {
        switch option{
        case .name:
            "Your full name can only be changed once every 7 days."
        case .bio:
            "Tell us a little bit about yourself."
        case .username:
            "Usernames can contain only letters, numbers, underscores, and periods."
        }
    }
    
    func onViewAppear(){
        switch option{
        case .name:
            value = user.fullName
        case .bio:
            value = user.bio ?? ""
        case .username:
            value = user.username
        }
    }
    
    mutating func saveInfo(){
        switch option {
        case .name:
            self.user.fullName = self.subtitle
        case .bio:
            self.user.bio = self.subtitle
        case .username:
            self.user.bio = self.subtitle
        }
    }
}



#Preview {
    NavigationStack{
        EditProfileDetailView(option: .username, user: DeveloperPreview.currentUser)
            .tint(.primary)
    }
    
}
