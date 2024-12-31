////
////  LoginView.swift
////  3D_E_Commerce
////
////  Created by Lathif A.D on 18/09/24.
////
//


import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var navigateToHome = false
    @State private var navigateToAdmin = false
    @State private var isPasswordVisible = false // State untuk mengatur visibility password
    
    var body: some View {
        VStack {
            Image("logo1")
                .resizable()
                .frame(width: 200, height: 150)
                .padding(.bottom, 120)
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
            
            Button("Log In") {
                viewModel.login()
            }
            .padding()
            
            NavigationLink(
                destination: BaseView(),
                isActive: $navigateToHome
            ) {
                EmptyView()
            }
            NavigationLink(
                destination: AdminDashboardView(),
                isActive: $navigateToAdmin
            ) {
                EmptyView()
            }
            NavigationLink(destination: SignUpView()) {
                Text("Sign Up")
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .padding()
        .onReceive(viewModel.$isLoggedIn) { isLoggedIn in
            if isLoggedIn {
                navigateToHome = true
            }
        }
        .onReceive(viewModel.$isAdminLoggedIn) { isAdminLoggedIn in
            if isAdminLoggedIn {
                navigateToAdmin = true
            }
        }
    }
}

#Preview {
    LoginView()
}





//import SwiftUI
//
//struct LoginView: View {
//    @StateObject private var viewModel = LoginViewModel()
//    @State private var navigateToHome = false
//    
//    var body: some View {
//        VStack {
//            TextField("Email", text: $viewModel.email)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            
//            SecureField("Password", text: $viewModel.password)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            
//            if let errorMessage = viewModel.errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//            }
//            
//            Button("Log In") {
//                viewModel.login()
//            }
//            .padding()
//            
//            NavigationLink(
//                destination: BaseView(),
//                isActive: $navigateToHome
//            ) {
//                EmptyView()
//            }
//            NavigationLink(destination: SignUpView()) {
//                Text("Sign Up")
//            }
//            .padding()
//        }
//        .padding()
//        .onReceive(viewModel.$isLoggedIn) { isLoggedIn in
//            if isLoggedIn {
//                navigateToHome = true
//            }
//        }
//    }
//}
//
//#Preview {
//    LoginView()
//}
