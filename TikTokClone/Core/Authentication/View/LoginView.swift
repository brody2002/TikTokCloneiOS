//
//  LoginView.swift
//  TikTokClone
//
//  Created by Brody on 1/24/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationStack{
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
                }
                
                NavigationLink {
                    Text("Forgot password?")
                } label: {
                    Text("Forgot password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                //login button
                
                Button(
                    action:{},
                    label:{
                        Text("Login")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 350, height: 44)
                            .background(Color.pink)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                )
                .padding(.vertical)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1: 0.7)
                Spacer()
                
                // go to Sign Up
                
                Divider()
                
                NavigationLink {
                    RegistrationView()
                } label: {
                    HStack(spacing: 3){
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    .padding(.vertical)
                }

                
                
            }
        }
    }
}

// Mark: - AuthenticationFormProtocol

extension LoginView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
    }
}

#Preview {
    LoginView()
}
