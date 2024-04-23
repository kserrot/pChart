//
//  AuthView.swift
//  pChart
//
//  Created by Kaique Torres on 4/23/24.
//

import SwiftUI

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isSigningUp = false
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if isSigningUp {
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            if !isSigningUp {
                Button("Sign In") {
                    authViewModel.signInUser(email: email, password: password)
                    print("User in")
                }
                .buttonStyle(.bordered)
                .controlSize(.regular)
                .background(Color.white)
                .foregroundColor(.blue)
                .cornerRadius(10)
            }

            Button(isSigningUp ? "Complete Sign Up" : "Sign Up") {
                if isSigningUp {
                    if password == confirmPassword {
                        authViewModel.signUpUser(email: email, password: password)
                        print("New User")
                    } else {
                        authViewModel.accountCreationMessage = "Passwords do not match."
                        authViewModel.showingAlert = true
                    }
                } else {
                    isSigningUp = true
                }
            }
            .buttonStyle(.bordered)
            .controlSize(.regular)
            .background(Color.white)
            .foregroundColor(.blue)
            .cornerRadius(10)
            .alert(isPresented: $authViewModel.showingAlert) {
                Alert(title: Text("Sign Up"), message: Text(authViewModel.accountCreationMessage), dismissButton: .default(Text("OK"), action: {
                    if authViewModel.isAccountCreationSuccessful {
                        isSigningUp = false
                    }
                }))
            }
        }
        .padding()
        .background(Color.accentColor.ignoresSafeArea())
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(AuthViewModel())
    }
}
