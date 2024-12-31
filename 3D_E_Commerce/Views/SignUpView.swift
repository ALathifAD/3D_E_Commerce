//
//  SignUpView.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 18/09/24.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @State private var navigateToLogin = false
    @State private var isPasswordVisible = false // State untuk mengatur visibility password

    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .padding(.bottom, 16)
                
                ZStack(alignment: .trailing) {
                    if isPasswordVisible {
                        TextField("Password", text: $viewModel.password)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    } else {
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .padding(.bottom, 16)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Button("Sign Up") {
                    viewModel.signUp()
                }
                .padding()
                
                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                    EmptyView()
                }
            }
            .padding()
            .onChange(of: viewModel.isSignedUp) { isSignedUp in
                if isSignedUp {
                    navigateToLogin = true
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}


//import SwiftUI
//
//struct SignUpView: View {
//    @StateObject private var viewModel = SignUpViewModel()
//    @State private var navigateToLogin = false
//    @State private var navigateToHome = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Email", text: $viewModel.email)
//                    .padding()
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                
//                SecureField("Password", text: $viewModel.password)
//                    .padding()
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                
//                if let errorMessage = viewModel.errorMessage {
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                }
//                
//                Button("Sign Up") {
//                    viewModel.signUp()
//                }
//                .padding()
//                
//                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
//                    EmptyView()
//                }
////                NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
////                    EmptyView()
////                }
//            }
//            .padding()
//            .onChange(of: viewModel.isSignedUp) { isSignedUp in
//                if isSignedUp {
//                    navigateToLogin = true
//                }
//            }
//        }
//    }
//}
//
//
//
//#Preview {
//    SignUpView()
//}
