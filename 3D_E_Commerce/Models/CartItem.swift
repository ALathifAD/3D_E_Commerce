//
//  CartItem.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//

import Foundation
import FirebaseFirestore

struct CartItem: Identifiable, Codable {
    var id: String = UUID().uuidString
    let product: Product
    var quantity: Int
    var isSwiped: Bool
    var offset: CGFloat
}


// Update CartItem to support Firestore
//struct CartItem: Identifiable, Codable {
//    @DocumentID var id: String?
//    let productId: String
//    var quantity: Int
//    var isSwiped: Bool = false
//    var offset: CGFloat = 0.0
//    
//    // Add a computed property to fetch the full product
//    var product: Product?
//}


//struct CartItem: Identifiable {
//    let id: UUID = UUID()
//    let product: Product
//    var quantity: Int
//    var isSwiped: Bool = false
//    var offset: CGFloat = 0.0
//}
