//
//  Order.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//

import Foundation
import FirebaseFirestore

struct Order: Identifiable, Codable {
    let id: String
    let items: [OrderItem]
    let total: Double
    let paymentMethod: String
    let address: String
    let date: Date
}

struct OrderItem: Identifiable, Codable {
    let id: String
    let product: Product
//    let productID: String
    let productName: String
    let quantity: Int
    let price: Double
}


//struct Order: Identifiable, Codable {
//   /* @DocumentID */var id: String?
//    let products: [CartItem]
//    let total: Double
//    let paymentMethod: String
//    let address: String
//}



// Update Order to support Firestore
//struct Order: Identifiable, Codable {
//    @DocumentID var id: String?
//    let productIds: [String]
//    let total: Double
//    let paymentMethod: String
//    let address: String
//    let userId: String
//    let createdAt: Date
//}
//

//struct Order: Identifiable {
//    let id = UUID()
//    let products: [CartItem]
//    let total: Double
//    let paymentMethod: String
//    let address: String
//}
