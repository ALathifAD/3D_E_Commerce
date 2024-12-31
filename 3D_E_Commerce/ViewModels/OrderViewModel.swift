//
//  OrderViewModel.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestoreInternal
//import FirebaseFirestore
//import FirebaseAuth
//
//class OrderViewModel: ObservableObject {
//    @Published var orders: [Order] = []
//    
//    private let db = Firestore.firestore()
//    
//    init() {
//        fetchOrders()
//    }
//    
//    // Add Order to Firestore
//    func addOrder(products: [CartItem], paymentMethod: String, address: String) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User not logged in")
//            return
//        }
//        
//        // Calculate total price
//        let total = products.reduce(0.0) { $0 + (Double($1.product?.price ?? "0") ?? 0.0) * Double($1.quantity) }
//        
//        let newOrder = Order(
//            productIds: products.map { $0.productId },
//            total: total,
//            paymentMethod: paymentMethod,
//            address: address,
//            userId: userId,
//            createdAt: Date()
//        )
//        
//        do {
//            // Add order to Firestore
//            try db.collection("users").document(userId).collection("orders").addDocument(from: newOrder)
//        } catch {
//            print("Error adding order: \(error)")
//        }
//    }
//    
//    // Fetch Orders from Firestore
//    func fetchOrders() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User not logged in")
//            return
//        }
//        
//        db.collection("users").document(userId).collection("orders")
//            .order(by: "createdAt", descending: true)
//            .addSnapshotListener { (querySnapshot, error) in
//                guard let documents = querySnapshot?.documents else {
//                    print("Error fetching orders: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//                
//                self.orders = documents.compactMap { document in
//                    do {
//                        return try document.data(as: Order.self)
//                    } catch {
//                        print("Error decoding order: \(error)")
//                        return nil
//                    }
//                }
//            }
//    }
//}


class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    private let firestoreManager = FirestoreManager()
    private let db = Firestore.firestore()
    
 /*   func addOrder(newOrder: Order, completion: @escaping (Bool) -> Void) {
        let orderData: [String: Any] = [
            "items": newOrder.items.map { item -> [String: Any] in
                return [
                    "id": item.id,
                    "productName": item.productName,
                    "quantity": item.quantity,
                    "price": item.price
                ]
            },
            "total": newOrder.total,
            "paymentMethod": newOrder.paymentMethod,
            "address": newOrder.address,
            "date": newOrder.date
        ]

        Firestore.firestore().collection("orders").document(newOrder.id).setData(orderData) { error in
            if let error = error {
                print("Error adding order to database: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Order added successfully to database.")
                completion(true)
            }
        }
    }

    */
    
    
//    func addOrder(newOrder: Order, completion: @escaping (Bool) -> Void) {
//        
        
        
        //P 1
//        let orderData: [String: Any] = [
//            "id": newOrder.id,
//            "items": newOrder.items.map {
//                [
//                "productID": $0.productID,
//                "productName": $0.productName,
//                "quantity": $0.quantity,
//                "price": $0.price
//                ] },
//            "total": newOrder.total,
//            "paymentMethod": newOrder.paymentMethod,
//            "address": newOrder.address,
//            "date": Timestamp(date: newOrder.date)
//        ]

//        Firestore.firestore().collection("orders").document(newOrder.id).setData(orderData) { error in
//            if let error = error {
//                print("Error adding order to database: \(error.localizedDescription)")
//                completion(false)
//            } else {
//                print("Order added successfully to database.")
//                completion(true)
//            }
//        }
//    }
    
    func addOrder(newOrder: Order, completion: @escaping (Bool) -> Void) {
        let orderData: [String: Any] = [
            "items": newOrder.items.map { item -> [String: Any] in
                return [
                    "id": item.id,
                    "productName": item.productName,
                    "quantity": item.quantity,
                    "price": item.price,
                    "imgProduct": item.product.ImgProduct // Tambahkan ini
                ]
            },
            "total": newOrder.total,
            "paymentMethod": newOrder.paymentMethod,
            "address": newOrder.address,
            "date": newOrder.date
        ]

        Firestore.firestore().collection("orders").document(newOrder.id).setData(orderData) { error in
            if let error = error {
                print("Error adding order to database: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Order added successfully to database.")
                completion(true)
            }
        }
    }
    
    
    
    func fetchOrders(completion: @escaping ([Order]?, Error?) -> Void) {
        db.collection("orders").getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
            } else {
                let orders = snapshot?.documents.compactMap { document -> Order? in
                    guard let data = document.data() as? [String: Any],
                          let itemsData = data["items"] as? [[String: Any]],
                          let total = data["total"] as? Double,
                          let paymentMethod = data["paymentMethod"] as? String,
                          let address = data["address"] as? String,
                          let timestamp = data["date"] as? Timestamp else { return nil }

                    let items = itemsData.compactMap { itemData -> OrderItem? in
                        guard let productName = itemData["productName"] as? String,
                              let quantity = itemData["quantity"] as? Int,
                              let price = itemData["price"] as? Double,
                              let imgProduct = itemData["imgProduct"] as? String else { return nil } // Tambahkan ini

                        let product = Product(
                            id: nil,
                            name: productName,
                            ImgProduct: imgProduct, // Gunakan imgProduct dari data
                            price: "\(price)",
                            description: "",
                            rating: 0,
                            scnFileName: ""
                        )
                        
                        return OrderItem(
                            id: itemData["id"] as? String ?? "",
                            product: product,
                            productName: productName,
                            quantity: quantity,
                            price: price
                        )
                    }

                    return Order(
                        id: document.documentID,
                        items: items,
                        total: total,
                        paymentMethod: paymentMethod,
                        address: address,
                        date: timestamp.dateValue()
                    )
                }

                DispatchQueue.main.async {
                    self.orders = orders ?? []
                    completion(orders, nil)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // plan yang bener
    
    
//    func fetchOrders(completion: @escaping ([Order]?, Error?) -> Void) {
//        db.collection("orders").getDocuments { snapshot, error in
//            if let error = error {
//                completion(nil, error)
//            } else {
//                let orders = snapshot?.documents.compactMap { document -> Order? in
//                    guard let data = document.data() as? [String: Any],
//                          let itemsData = data["items"] as? [[String: Any]],
//                          let total = data["total"] as? Double,
//                          let paymentMethod = data["paymentMethod"] as? String,
//                          let address = data["address"] as? String,
//                          let timestamp = data["date"] as? Timestamp else { return nil }
//
//                    let items = itemsData.compactMap { itemData -> OrderItem? in
//                        guard let productName = itemData["productName"] as? String,
//                              let quantity = itemData["quantity"] as? Int,
//                              let price = itemData["price"] as? Double else { return nil }
//                        let product = Product(id: nil, name: productName, ImgProduct: imgProduct, price: "\(price)", description: "", rating: 0, scnFileName: "") // Asumsikan produk harus didefinisikan dengan cara ini
//                        return OrderItem(id: itemData["id"] as? String ?? "", product: product, productName: productName, quantity: quantity, price: price)
//                    }
//
//                    return Order(
//                        id: document.documentID,
//                        items: items,
//                        total: total,
//                        paymentMethod: paymentMethod,
//                        address: address,
//                        date: timestamp.dateValue()
//                    )
//                }
//
//                DispatchQueue.main.async {
//                    self.orders = orders ?? []
//                    completion(orders, nil)
//                }
//            }
//        }
//    }

    
    
    
//    func fetchOrders(completion: @escaping ([Order]?, Error?) -> Void) {
//        db.collection("orders").getDocuments { snapshot, error in
//            if let error = error {
//                completion(nil, error)
//            } else {
//                let orders = snapshot?.documents.compactMap { document -> Order? in
//                    guard let data = document.data() as? [String: Any],
//                          let itemsData = data["items"] as? [[String: Any]],
//                          let total = data["total"] as? Double,
//                          let paymentMethod = data["paymentMethod"] as? String,
//                          let address = data["address"] as? String,
//                          let timestamp = data["date"] as? Timestamp else { return nil }
//
//                    let items = itemsData.compactMap { itemData -> OrderItem? in
//                        guard let productID = itemData["productID"] as? String,
//                              let productName = itemData["productName"] as? String,
//                              let quantity = itemData["quantity"] as? Int,
//                              let price = itemData["price"] as? Double else { return nil }
//                        return OrderItem(productID: productID, productName: productName, quantity: quantity, price: price)
//                    }
//
//                    return Order(
//                        id: document.documentID, // Gunakan `documentID` sebagai id
//                        items: items,
//                        total: total,
//                        paymentMethod: paymentMethod,
//                        address: address,
//                        date: timestamp.dateValue()
//                    )
//                }
//                
//                DispatchQueue.main.async {
//                    self.orders = orders ?? [] // Pastikan data diupdate di main thread
//                    completion(orders, nil)
//                }
////                completion(orders, nil)
//            }
//        }
//    }

    
}



//class OrderViewModel: ObservableObject {
//    @Published var orders: [Order] = []
//    
//    func addOrder(products: [CartItem], total: Double, paymentMethod: String, address: String) {
//        let newOrder = Order(products: products, total: total, paymentMethod: paymentMethod, address: address)
//        orders.append(newOrder)
//    }
//}
