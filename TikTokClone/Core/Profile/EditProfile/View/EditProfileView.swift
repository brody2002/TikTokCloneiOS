//
//  EditProfileView.swift
//  TikTokClone
//
//  Created by Brody on 1/25/25.
//

import SwiftUI

struct EditProfileView: View {
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    Circle()
                        .frame(width: 64, height: 64)
                    Button("Change Photo"){
                        print("DEBUG: Change photo here...")
                    }
                    .foregroundStyle(.black)
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

#Preview {
    EditProfileView()
}
