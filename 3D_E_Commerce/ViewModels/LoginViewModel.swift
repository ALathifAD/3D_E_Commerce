//
//  LoginViewModel.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 18/09/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    private let authService = AuthService()
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false
    
    @Published var isAdminLoggedIn: Bool = false
    
    
    func login() {
        
        if email.lowercased() == "admin" && password == "admin123" {
                    isAdminLoggedIn = true
                    return
                }
                
        
        authService.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.isLoggedIn = true // Update state untuk navigasi
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func logout() {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut() // Melakukan sign-out dengan Firebase
                isLoggedIn = false // Mengubah status login
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
                self.errorMessage = "Logout failed: \(signOutError.localizedDescription)"
            }
        }
    
}


//------------------------
//import Foundation
//
//import SwiftUI
//
//class LoginViewModel: ObservableObject {
//    private let authService = AuthService()
//    
//    @Published var email: String = ""
//    @Published var password: String = ""
//    @Published var errorMessage: String?
//    @Published var isLoggedIn: Bool = false
//    
//    func login() {
//        authService.login(email: email, password: password) { result in
//            switch result {
//            case .success(_):
//                DispatchQueue.main.async {
//                    // Handle successful login (e.g., navigate to main screen)
//                    NavigationLink(destination: BaseView()) {
//                        Text("Log In")
//                    }
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//}
