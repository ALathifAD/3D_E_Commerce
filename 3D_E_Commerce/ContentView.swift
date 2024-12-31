//
//  ContentView.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 13/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            NavigationView {
                LoginView() // Tidak perlu membungkusnya dalam ScrollView
                    .preferredColorScheme(.light)
            }
        }
}

#Preview {
    ContentView()
}
