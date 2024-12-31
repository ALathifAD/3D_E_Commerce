//
//  BaseView.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//


import SwiftUI

struct BaseView: View {
    @StateObject var baseData = BaseViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    @State private var showCartView = false
    
    // MARK: - HIDE TAB BAR
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $baseData.currentTab) {
                ProductListView()
                    .environmentObject(baseData)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04))
                    .tag(Tab.Home)
                Heart()
                    .environmentObject(baseData)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04))
                    .tag(Tab.Heart)
                HistoryView()
                    .environmentObject(baseData)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04))
                    .tag(Tab.ClipBoard)
                ProfilView(loginViewModel: loginViewModel)
                    .tag(Tab.Person)
            }
            .overlay(
                // MARK: - CUSTOM TAB BAR
                HStack(spacing: 0) {
                    // MARK: - TAB BUTTON
                    TabButton(Tab: .Home)
                    TabButton(Tab: .Heart)
                        .offset(x: -10)
                    
                    // MARK: CURVED BUTTON
                    Button {
                        withAnimation {
                            showCartView = true
                        }
                    } label: {
                        Image("cart")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26, height: 26)
                            .offset(x: -1)
                            .padding(18)
                            .foregroundColor(Color.white)
                            .background(Color("pcolor1"))
                            .clipShape(Circle())
                        //MAR: - BUTTON SHADOWS
                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                    }
                    .offset(y: -30)
                    
                    TabButton(Tab: .ClipBoard)
                        .offset(x: 10)
                    TabButton(Tab: .Person)
                }
                    .background(
                        Color.white
                            .clipShape(CustomCurveShape())
                        //MARK: - SHADOW
                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                            .ignoresSafeArea(.container, edges: .bottom)
                    )
                //MARK: - HIDE TAB ON DETAIL VIEW
                    .offset(y: baseData.showDetail ? 200 : 0)
                
                , alignment: .bottom
            )
        }
        .navigationBarBackButtonHidden(true)
        // Tambahkan sheet untuk menampilkan CartView
        .sheet(isPresented: $showCartView) {
            CartView()  // Pastikan CartView sudah ada
        }
    }
    
    @ViewBuilder
    func TabButton(Tab: Tab)-> some View {
        Button {
            withAnimation {
                baseData.currentTab = Tab
            }
        } label: {
            Image(Tab.rawValue)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(baseData.currentTab == Tab ? Color("pcolor1") : Color.gray.opacity(0.5))
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    BaseView()
}
