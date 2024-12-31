//
//  CartView.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartData: CartViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {  // Tambahkan NavigationView di sini
            VStack {
                HStack(spacing: 20) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 26, weight: .heavy))
                            .foregroundColor(.black)
                    }
                    
                    Text("My Cart")
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Spacer()
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(cartData.items) { item in
                            if let index = getIndex(item: item) {
                                ItemView(item: $cartData.items[index], items: $cartData.items)
                            }
                        }
                    }
                }
                
                VStack {
                    HStack {
                        Text("Total")
                            .fontWeight(.heavy)
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text(cartData.calculateTotalPrice())
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                    }
                    .padding([.top, .horizontal])
                    
                    NavigationLink(destination: CheckoutView()) {
                        Text("Check out")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(15)
                    }
                }
            }
            .background(Color("gray").ignoresSafeArea())
            .navigationBarHidden(true)  // Sembunyikan navigation bar bawaan
        }
    }
    
    func getIndex(item: CartItem) -> Int? {
        return cartData.items.firstIndex { $0.id == item.id }
    }
}

#Preview {
    CartView()
        .environmentObject(CartViewModel())  // Tambahkan environment object untuk preview
}
