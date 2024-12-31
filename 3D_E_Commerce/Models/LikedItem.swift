//
//  LikedItem.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//

import Foundation
import FirebaseFirestore

struct LikedItem: Identifiable, Codable {
    /*@DocumentID*/ var id: String?
    let product: Product
    var isSwiped: Bool
    var offset: CGFloat
}

// Update LikedItem to support Firestore
//struct LikedItem: Identifiable, Codable {
//    @DocumentID var id: String?
//    let productId: String
//    var isSwiped: Bool = false
//    var offset: CGFloat = 0.0
//    
//    // Add a computed property to fetch the full product
//    var product: Product?
//}

//struct LikedItem: Identifiable {
//    let id: UUID = UUID()
//    let product: Product
//    var isSwiped: Bool = false
//    var offset: CGFloat = 0.0
//}
