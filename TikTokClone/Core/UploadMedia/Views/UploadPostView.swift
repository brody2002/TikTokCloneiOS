//
//  UploadPostView.swift
//  TikTokClone
//
//  Created by Brody on 1/27/25.
//

import SwiftUI

struct UploadPostView: View {
    @State private var caption = ""
    var body: some View {
        VStack{
            HStack(alignment: .top){
                TextField("Enter your caption", text: $caption, axis: .vertical)
                Spacer()
                Image("placeHolderImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 94, height: 140)
                    .clipShape(.rect(cornerRadius: 10))
                
            }
            Divider()
            
            Spacer()
            
            Button(
                action: {
                    print("DEBUG: upload post")
                },
                label: {
                    Text("Post")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 354, height: 44)
                        .background(Color(.systemPink))
                        .cornerRadius(8)
                }
            )
        }
        .padding()
        .navigationTitle("Post")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button(
                    action: {
                        print("DEBUG: exit post view")
                    },
                    label: {
                        Image(systemName: "lessthan")
                    }
                )
            }
        }
    }
}

#Preview {
    UploadPostView()
}
