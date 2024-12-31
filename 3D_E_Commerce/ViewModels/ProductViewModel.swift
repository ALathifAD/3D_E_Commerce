//
//  ProductViewModel.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 12/12/24.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var addProductError: String?
    @Published var updateProductError: String?

    private let firestoreManager = FirestoreManager()

    func loadProducts() {
        firestoreManager.fetchProducts { [weak self] fetchedProducts in
            DispatchQueue.main.async {
                self?.products = fetchedProducts
            }
        }
    }
    
    func addProduct(product: Product) {
        firestoreManager.addProduct(product) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.addProductError = error.localizedDescription
                } else {
                    self?.addProductError = nil
                    self?.loadProducts()
                }
            }
        }
    }
    func updateProduct(product: Product) {
        firestoreManager.updateProduct(product) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.updateProductError = error.localizedDescription
                } else {
                    self?.updateProductError = nil
                    self?.loadProducts() // Memuat ulang produk setelah pembaruan
                }
            }
        }
    }
    
    func updateRating(for productId: String, newRating: Double) {
        guard let productIndex = products.firstIndex(where: { $0.id == productId }) else { return }
        
        var updatedProduct = products[productIndex]
        updatedProduct.rating = newRating

        firestoreManager.updateProduct(updatedProduct) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to update rating: \(error.localizedDescription)")
                } else {
                    self?.products[productIndex] = updatedProduct
                }
            }
        }
    }
    func deleteProduct(productId: String) {
            firestoreManager.deleteProduct(productId) { [weak self] error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error deleting product: \(error.localizedDescription)")
                    } else {
                        self?.loadProducts() // Memuat ulang produk setelah penghapusan
                    }
                }
            }
        }
    

}

