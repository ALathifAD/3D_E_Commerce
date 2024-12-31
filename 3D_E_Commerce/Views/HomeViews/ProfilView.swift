//
//  ProfilView.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 13/12/24.
//

import SwiftUI

struct ProfilView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @Environment(\.presentationMode) var presentationMode  // Untuk menutup view
    @State private var navigateToLogin = false
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Bagian atas (Header)
                HStack {
                    Text("Profil")
                        .font(Font.custom("Pacifico-Regular", size: 30))
                        .bold()
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        loginViewModel.logout() // Fungsi untuk logout
                        navigateToLogin = true
                    }) {
                        Text("Log Out")
                            .foregroundColor(.red)
                            .padding(.trailing, 16)
                    }
                }
                .padding(.top, 20)
                .padding(.leading, 16)
                
                Spacer()
                
                // Bagian Konten Profil
                VStack(spacing: 10) {
                    Image("me")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200.0, height: 200.0)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 3)
                        )
                    
                    Text("ラティフ")
                        .font(Font.custom("NotoSerifJP-VariableFont_wght", size: 50))
                        .bold()
                        .foregroundColor(.black)
                    
                    Divider()
                    
                    InfoView(text: "+60 162 454 592", imageName: "phone.fill")
                    InfoView(text: "a.lathif.a.d@gmail.com", imageName: "envelope.fill")
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true) // Menyembunyikan tombol kembali default
                .background(
                    NavigationLink(
                        destination: LoginView(),
                        isActive: $navigateToLogin // Menavigasi kembali ke login setelah logout
                    ) {
                        EmptyView()
                    }
                )
    }
}
    
    struct InfoView: View {
        let text: String
        let imageName: String
        
        var body: some View {
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray)
                .frame(height: 50)
                .overlay(
                    HStack {
                        Image(systemName: imageName)
                            .foregroundColor(.init(red: 0.20, green: 0.29, blue: 0.37))
                        Text(text)                .foregroundColor(.white)
                            .font(Font.custom("NotoSerifJP-VariableFont_wght", size: 20))
                    })
                .padding(.all)
        }
    }
    
    //#Preview {
    //    ProfilView()
    //}
    //

