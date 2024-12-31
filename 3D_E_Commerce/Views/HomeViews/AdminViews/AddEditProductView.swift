//
//  adminManagement.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 14/12/24.
//

import SwiftUI

struct AddEditProductView: View {
    @Binding var product: Product?  // Binding to the product
    var onSave: (Product?) -> Void  // Callback for saving

    @State private var name: String = ""
    @State private var price: String = ""
    @State private var description: String = ""
    @State private var rating: String = ""  // Keep as String for TextField
    @State private var imgProduct: String = ""
    @State private var scnFileName: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Product Name", text: $name)
                TextField("Price", text: $price)
                TextField("Description", text: $description)
                TextField("Image URL", text: $imgProduct)
                TextField("SCN File Name", text: $scnFileName)

                // Use TextField for rating, keeping it as String
                TextField("Rating", text: $rating)
                    .keyboardType(.decimalPad)

                Button("Save") {
                    // Convert rating from String to Double when saving
                    if let ratingValue = Double(rating) {
                        let updatedProduct = Product(
                            id: product?.id,
                            name: name,
                            ImgProduct: imgProduct,
                            price: price,
                            description: description,
                            rating: ratingValue,  // Now we pass a Double
                            scnFileName: scnFileName
                        )
                        onSave(updatedProduct)  // Save the updated product
                    } else {
                        // Handle invalid rating value (optional)
                        print("Invalid rating value")
                    }
                }
            }
            .onAppear {
                // Populate the fields with the existing product values (if any)
                if let existingProduct = product {
                    name = existingProduct.name
                    price = existingProduct.price
                    description = existingProduct.description
                    imgProduct = existingProduct.ImgProduct
                    scnFileName = existingProduct.scnFileName
                    rating = String(existingProduct.rating)  // Convert Double to String for display
                }
            }
        }
    }
}
