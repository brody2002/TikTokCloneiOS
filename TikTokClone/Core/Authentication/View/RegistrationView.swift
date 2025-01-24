//
//  RegistrationView.swift
//  TikTokClone
//
//  Created by Brody on 1/24/25.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var fullName: String = ""
    @State private var username: String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Spacer()
            //logo image
            Image("tiktok-app-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            //text fields
            VStack{
                TextField("Enter your email", text: $email)
                    .textInputAutocapitalization(.never)
                    .modifier(StandardTextFieldModifier())
                
                SecureField("Enter your password", text: $password)
                    .modifier(StandardTextFieldModifier())
                
                TextField("Enter your full name", text: $fullName)
                    .textInputAutocapitalization(.words)
                    .modifier(StandardTextFieldModifier())
                
                TextField("Enter your username", text: $username)
                    .textInputAutocapitalization(.never)
                    .modifier(StandardTextFieldModifier())
            }
            
            Button(
                action:{
                    print("DEBUG: Sign Up")
                },
                label:{
                    Text("Sign Up")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 350, height: 44)
                        .background(.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            )
            .padding(.vertical)
            .opacity(formIsValid ? 1 : 0.7)
            .disabled(!formIsValid)
            Spacer()
            
            Divider()
            Button() {
                dismiss()
            } label: {
                HStack(spacing: 3){
                    Text("Already have an account?")
                    Text("Login")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .padding(.vertical)
            }
            
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Mark: - AuthenticationFormProtocol

extension RegistrationView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && email.contains(".")
        && !password.isEmpty
        && !fullName.isEmpty
        && !username.isEmpty
    }
}

#Preview {
    RegistrationView()
}
