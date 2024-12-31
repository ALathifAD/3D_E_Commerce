//
//  CartViewModel.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//

import Foundation
//import FirebaseFirestore
//import FirebaseAuth
//
//import SwiftUI
//
//class CartViewModel: ObservableObject {
//    @Published var items: [CartItem] = []
//    @Published var likedItems: [LikedItem] = []
//    @Published var products: [Product] = []
//    
//    private let db = Firestore.firestore()
//    
//    init() {
//        fetchProducts()
//        fetchCartItems()
//        fetchLikedItems()
//    }
//    
//    // Fetch all products
//    func fetchProducts() {
//        db.collection("products").addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("Error fetching products: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            self.products = documents.compactMap { document in
//                do {
//                    return try document.data(as: Product.self)
//                } catch {
//                    print("Error decoding product: \(error)")
//                    return nil
//                }
//            }
//        }
//    }
//    
//    // Add to Cart with Firestore Integration
//    func addToCart(product: Product) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User not logged in")
//            return
//        }
//        
//        let cartRef = db.collection("users").document(userId).collection("cart")
//        
//        // Check if product already exists in cart
//        cartRef.whereField("productId", isEqualTo: product.id ?? "").getDocuments { (querySnapshot, error) in
//            if let document = querySnapshot?.documents.first {
//                // Increment quantity if product exists
//                let docId = document.documentID
//                cartRef.document(docId).updateData(["quantity": FieldValue.increment(Double(1))])
//            } else {
//                // Add new cart item
//                do {
//                    let cartItem = CartItem(
//                        productId: product.id ?? UUID().uuidString,
//                        quantity: 1
//                    )
//                    try cartRef.addDocument(from: cartItem)
//                } catch {
//                    print("Error adding to cart: \(error)")
//                }
//            }
//        }
//    }
//    
//    // Fetch Cart Items
//    func fetchCartItems() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User not logged in")
//            return
//        }
//        
//        db.collection("users").document(userId).collection("cart")
//            .addSnapshotListener { (querySnapshot, error) in
//                guard let documents = querySnapshot?.documents else {
//                    print("Error fetching cart items: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//                
//                self.items = documents.compactMap { document in
//                    do {
//                        var cartItem = try document.data(as: CartItem.self)
//                        cartItem.product = self.products.first { $0.id == cartItem.productId }
//                        return cartItem
//                    } catch {
//                        print("Error decoding cart item: \(error)")
//                        return nil
//                    }
//                }
//            }
//    }
//    
//    // Calculate Total Price
//    func calculateTotalPrice() -> String {
//        let totalPrice = items.reduce(0) { $0 + Float($1.quantity) * (Float($1.product?.price ?? "0") ?? 0.0) }
//        return formatPrice(value: totalPrice)
//    }
//    
//    // Format Price (unchanged)
//    private func formatPrice(value: Float) -> String {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.currencyCode = "MYR"
//        formatter.currencySymbol = "RM"
//        return formatter.string(from: NSNumber(value: value)) ?? "RM0.00"
//    }
//    
//    // Like Product with Firestore Integration
//    func likeProduct(product: Product) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User not logged in")
//            return
//        }
//        
//        let likedRef = db.collection("users").document(userId).collection("liked")
//        
//        // Check if product is already liked
//        likedRef.whereField("productId", isEqualTo: product.id ?? "").getDocuments { (querySnapshot, error) in
//            if let document = querySnapshot?.documents.first {
//                // Already liked, so remove
//                document.reference.delete()
//            } else {
//                // Add to liked items
//                do {
//                    let likedItem = LikedItem(productId: product.id ?? UUID().uuidString)
//                    try likedRef.addDocument(from: likedItem)
//                } catch {
//                    print("Error liking product: \(error)")
//                }
//            }
//        }
//    }
//    
//    // Fetch Liked Items
//    func fetchLikedItems() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User not logged in")
//            return
//        }
//        
//        db.collection("users").document(userId).collection("liked")
//            .addSnapshotListener { (querySnapshot, error) in
//                guard let documents = querySnapshot?.documents else {
//                    print("Error fetching liked items: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//                
//                self.likedItems = documents.compactMap { document in
//                    do {
//                        var likedItem = try document.data(as: LikedItem.self)
//                        likedItem.product = self.products.first { $0.id == likedItem.productId }
//                        return likedItem
//                    } catch {
//                        print("Error decoding liked item: \(error)")
//                        return nil
//                    }
//                }
//            }
//    }
//    
//    // Check if Product is Liked
//    func isLiked(product: Product) -> Bool {
//        likedItems.contains { $0.productId == product.id }
//    }
//}

class CartViewModel: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var likedItems: [LikedItem] = []
    
    private let firestoreManager = FirestoreManager()

    // Menambahkan produk ke Cart
    
    func addToCart(product: Product) {
        var cartItem = CartItem(product: product, quantity: 1, isSwiped: false, offset: 0.0)
        cartItem.id = UUID().uuidString // Pastikan `id` unik
        
        firestoreManager.addToCart(cartItem) { error in
            if let error = error {
                print("Error adding to cart: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.items.append(cartItem)
                }
            }
        }
    }


    
//    func addToCart(product: Product) {
//            let cartItem = CartItem(product: product, quantity: 1, isSwiped: false, offset: 0.0)
//            firestoreManager.addToCart(cartItem) { error in
//                if let error = error {
//                    print("Error adding to cart: \(error.localizedDescription)")
//                } else {
//                    self.items.append(cartItem)
//                }
//            }
//        }
    //-----------------
//    func addToCart(product: Product) {
//        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
//            items[index].quantity += 1
//        } else {
//            items.append(CartItem(product: product, quantity: 1))
//        }
//
//    }

    // Menghitung total harga
    func calculateTotalPrice() -> String {
        let totalPrice = items.reduce(0) { $0 + Float($1.quantity) * (Float($1.product.price) ?? 0.0) }
        return formatPrice(value: totalPrice)
    }
    
    private func formatPrice(value: Float) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "MYR" // Mengatur kode mata uang
        formatter.currencySymbol = "Rp" // Secara eksplisit mengatur simbol
        return formatter.string(from: NSNumber(value: value)) ?? "RM0.00"
    }

    // MARK: - Liked Items Logic

    // Menambahkan produk ke Liked Items
    func likeProduct(product: Product) {
        if likedItems.contains(where: { $0.product.id == product.id }) {
            removeFromLikedItems(product: product) // Jika sudah ada, hapus
        } else {
            likedItems.append(LikedItem(product: product, isSwiped: false, offset: 0.0))
//            likedItems.append(LikedItem(product: product))
        }

    }

    // Menghapus produk dari Liked Items
    func removeFromLikedItems(product: Product) {
        likedItems.removeAll { $0.product.id == product.id }
    }

    // Mengecek apakah produk sudah di-like
    func isLiked(product: Product) -> Bool {
        likedItems.contains(where: { $0.product.id == product.id })
    }
}
