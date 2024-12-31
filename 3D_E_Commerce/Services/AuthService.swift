//
//  AuthService.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 18/09/24.
//

import Foundation
import FirebaseAuth

class AuthService {
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = authResult?.user else {
                // Handle unexpected case
                return
            }
            completion(.success(user))
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = authResult?.user else {
                // Handle unexpected case
                return
            }
            completion(.success(user))
        }
    }
}
