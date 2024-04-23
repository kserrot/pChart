//
//  AuthViewModel.swift
//  pChart
//
//  Created by Kaique Torres on 4/23/24.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    
    @Published var isAccountCreationSuccessful: Bool = false
    @Published var accountCreationMessage: String = ""
    @Published var showingAlert = false
    @Published var isAuthenticated = false

    init() {
        self.isAuthenticated = Auth.auth().currentUser != nil
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            self?.isAuthenticated = user != nil
        }
    }

    //Sign in the user
    func signInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error signing in: \(error.localizedDescription)")
                    self?.accountCreationMessage = "Error signing in: \(error.localizedDescription)"
                    self?.showingAlert = true
                    return
                }
                self?.isAuthenticated = true
            }
        }
    }

    //Sign up the user
    func signUpUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.accountCreationMessage = "Error: \(error.localizedDescription)"
                    self?.showingAlert = true
                } else {
                    self?.isAuthenticated = true
                    self?.accountCreationMessage = "Account created successfully!"
                    self?.isAccountCreationSuccessful = true
                    self?.showingAlert = true
                }
            }
        }
    }

    //Sign out the user
    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}
