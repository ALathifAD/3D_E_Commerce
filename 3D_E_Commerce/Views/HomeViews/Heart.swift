//
//  Heart.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//

import SwiftUI

struct Heart: View {
    @EnvironmentObject var cartViewModel: CartViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(cartViewModel.likedItems) { likedItem in
                        NavigationLink(destination: Home(product: likedItem.product)) {
                            HStack {
                                Image(likedItem.product.ImgProduct)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(8)

                                VStack(alignment: .leading) {
                                    Text(likedItem.product.name)
                                        .font(.headline)
                                    Text("RM\(likedItem.product.price)")
                                        .font(.subheadline)
                                }

                                Spacer()

                                Button(action: {
                                    cartViewModel.removeFromLikedItems(product: likedItem.product)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Liked Items")
        }
    }
}
