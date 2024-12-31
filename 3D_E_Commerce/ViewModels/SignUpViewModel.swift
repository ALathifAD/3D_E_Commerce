//
//  SignUpViewModel.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 18/09/24.
//

import Foundation

import SwiftUI
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    private let authService = AuthService()
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isSignedUp: Bool = false
    
    func signUp() {
        authService.signUp(email: email, password: password) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.isSignedUp = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}


