//
//  FirestoreManager.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 11/12/24.
//

import FirebaseFirestore
import FirebaseFirestore

class FirestoreManager: ObservableObject{
    private let db = Firestore.firestore()
    
    // Fungsi untuk mengunggah produk dummy ke Firestore
//    func uploadDummyProducts(completion: @escaping (Bool) -> Void) {
//        let dummyProducts = [
//            Product(id: nil, name: "Adjust Table", ImgProduct: "adjust_table_IMG", price: "400", description: "A modern adjustable table.", rating: 4.5, scnFileName: "adjust_table.scn"),
//            Product(id: nil, name: "Saber Lily - Distant Avalon Figure", ImgProduct: "Fate_IMG", price: "1800", description: "A beautiful Saber Lily collectible figure.", rating: 5.0, scnFileName: "Saber_Lily_-_Distant_Avalon_Figure.scn"),
//            Product(id: nil, name: "Anime Girl Tech Priest", ImgProduct: "anime_girl_IMG", price: "1200", description: "A collectible figurine.", rating: 5.0, scnFileName: "anime_girl_tech_priest_umm_warhammer_40000.scn"),
//            Product(id: nil, name: "Vintage Chair", ImgProduct: "bovenkamp_vintage_chair_1950s_IMG", price: "850", description: "A vintage chair from the 1950s.", rating: 4.7, scnFileName: "bovenkamp_vintage_chair_1950s.scn"),
//            Product(id: nil, name: "Desk", ImgProduct: "deskop_or_IMG", price: "600", description: "A sleek and modern desk.", rating: 4.2, scnFileName: "deskop_or.scn"),
//            Product(id: nil, name: "Eat Table", ImgProduct: "eat_table_IMG", price: "500", description: "A durable and stylish dining table.", rating: 4.3, scnFileName: "eat_table.scn"),
//            Product(id: nil, name: "Figure", ImgProduct: "figure1_IMG", price: "300", description: "An abstract decorative figure.", rating: 4.0, scnFileName: "figure1.scn"),
//            Product(id: nil, name: "Glass Table", ImgProduct: "glass_table_IMG", price: "750", description: "A modern glass table.", rating: 4.6, scnFileName: "glass_table.scn"),
//            Product(id: nil, name: "Hand Carved Wood Statue", ImgProduct: "hand_carved_wood_statue_IMG", price: "900", description: "A detailed hand-carved wood statue.", rating: 4.8, scnFileName: "hand_carved_wood_statue_fbx.scn"),
//            Product(id: nil, name: "Hourglass", ImgProduct: "hourglass_IMG", price: "150", description: "A classic hourglass for decoration.", rating: 4.1, scnFileName: "hourglass.scn"),
//            Product(id: nil, name: "Modern Chair", ImgProduct: "modern_chair_IMG", price: "650", description: "A stylish modern chair.", rating: 4.4, scnFileName: "modern_chair.scn"),
//            Product(id: nil, name: "School Chair", ImgProduct: "school_chair_IMG", price: "200", description: "A comfortable school chair.", rating: 4.0, scnFileName: "school_chair.scn"),
//            Product(id: nil, name: "School Table", ImgProduct: "school_table_IMG", price: "350", description: "A durable school table.", rating: 4.2, scnFileName: "school_table.scn"),
//            Product(id: nil, name: "Sense and Teapot", ImgProduct: "sense_and_teapot_sousou_no_frieren_IMG", price: "300", description: "A decorative teapot.", rating: 4.5, scnFileName: "sense_and_teapot_sousou_no_frieren.scn"),
//            Product(id: nil, name: "Small Clock", ImgProduct: "sm_clock_IMG", price: "100", description: "A compact decorative clock.", rating: 3.9, scnFileName: "sm_clock.scn"),
//            Product(id: nil, name: "Smiling Cat Figurine", ImgProduct: "smiling_cat_figurine_free_3d_IMG", price: "120", description: "A cute smiling cat figurine.", rating: 4.7, scnFileName: "smiling_cat_figurine_free_3d_download.scn"),
//            Product(id: nil, name: "Standard Chair", ImgProduct: "standart_chair_IMG", price: "300", description: "A classic standard chair.", rating: 4.3, scnFileName: "standart_chair.scn"),
//            Product(id: nil, name: "Swivel Chair", ImgProduct: "swivel_chair._IMG", price: "700", description: "A comfortable swivel chair.", rating: 4.6, scnFileName: "swivel_chair.scn"),
//            Product(id: nil, name: "Mimikyu Pokémon Figure", ImgProduct: "pokemon_IMG", price: "500", description: "A cute Mimikyu Pokémon collectible.", rating: 4.8, scnFileName: "Mimikyu_Pokemon.scn"),
//            Product(id: nil, name: "Wooden Chair", ImgProduct: "wooden_chair_IMG", price: "550", description: "A durable wooden chair.", rating: 4.5, scnFileName: "wooden_chair.scn")
//        ]
//        
//        let group = DispatchGroup()
//        var uploadSuccessful = true
//        
//        for product in dummyProducts {
//            group.enter()
//            addProduct(product) { error in
//                if let error = error {
//                    print("Error uploading product \(product.name): \(error.localizedDescription)")
//                    uploadSuccessful = false
//                }
//                group.leave()
//            }
//        }
//        
//        group.notify(queue: .main) {
//            completion(uploadSuccessful)
//        }
//    }
    
    // MARK: - Product
    // Menambahkan Produk ke Firestore
    
    func addProduct(_ product: Product, completion: @escaping (Error?) -> Void) {
        let productData: [String: Any] = [
            "name": product.name,
            "ImgProduct": product.ImgProduct,
            "price": product.price,
            "description": product.description,
            "rating": product.rating,
            "scnFileName": product.scnFileName
        ]
        
        db.collection("products").addDocument(data: productData) { error in
            completion(error)
        }
    }

    
//    func addProduct(_ product: Product, completion: @escaping (Error?) -> Void) {
//        do {
//            let _ = try db.collection("products").addDocument(from: product, completion: { error in
//                completion(error)
//            })
//        } catch {
//            completion(error)
//        }
//    }
//    
    // Mendapatkan Semua Produk
    
    func fetchProducts(completion: @escaping ([Product]) -> Void) {
        db.collection("products").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching products: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found in 'products'")
                completion([])
                return
            }
            
            var products: [Product] = []
            for document in documents {
                let data = document.data()
                let product = Product(
                    id: document.documentID,
                    name: data["name"] as? String ?? "",
                    ImgProduct: data["ImgProduct"] as? String ?? "",
                    price: data["price"] as? String ?? "",
                    description: data["description"] as? String ?? "",
                    rating: data["rating"] as? Double ?? 0.0,
                    scnFileName: data["scnFileName"] as? String ?? ""
                )
                products.append(product)
            }
            completion(products)
        }
    }


    func updateProduct(_ product: Product, completion: @escaping (Error?) -> Void) {
        // Pastikan produk memiliki ID
        guard let productId = product.id else {
            print("Error: Product ID is missing")
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Product ID is missing"]))
            return
        }

        let productData: [String: Any] = [
            "name": product.name,
            "ImgProduct": product.ImgProduct,
            "price": product.price,
            "description": product.description,
            "rating": product.rating,
            "scnFileName": product.scnFileName
        ]
        
        // Update dokumen berdasarkan ID
        db.collection("products").document(productId).setData(productData, merge: true) { error in
            completion(error)
        }
    }

        func deleteProduct(_ productId: String, completion: @escaping (Error?) -> Void) {
            db.collection("products").document(productId).delete { error in
                completion(error)
            }
        }

    //------------------------------------------------------------------------------
//    func fetchProducts(completion: @escaping ([Product]) -> Void) {
//           db.collection("products")
//               .getDocuments { snapshot, error in
//                   if let error = error {
//                       print("Error getting documents: \(error)")
//                       completion([])
//                   } else {
//                       var products: [Product] = []
//                       for document in snapshot!.documents {
//                           do {
//                               let product = try document.data(as: Product.self)
//                               products.append(product)
//                           } catch {
//                               print("Error decoding product: \(error)")
//                           }
//                       }
//                       completion(products)
//                   }
//               }
//       }
    //------------------------------------------------------------------------------
//    func fetchProducts(completion: @escaping ([Product]?, Error?) -> Void) {
//        db.collection("products").getDocuments { snapshot, error in
//            if let error = error {
//                completion(nil, error)
//            } else {
//                let products = snapshot?.documents.compactMap { document -> Product? in
//                    try? document.data(as: Product.self)
//                }
//                completion(products, nil)
//            }
//        }
//    }
//    
    // MARK: - Cart
    // Menambahkan Item ke Cart
    func addToCart(_ cartItem: CartItem, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        var data = [
            "id": cartItem.id,
            "productName": cartItem.product.name,
            "productPrice": cartItem.product.price,
            "quantity": cartItem.quantity
        ] as [String: Any]
        
        // Tambahkan dokumen dengan ID spesifik
        db.collection("cart").document(cartItem.id).setData(data) { error in
            completion(error)
        }
    }

//    func addToCart(_ cartItem: CartItem, completion: @escaping (Error?) -> Void) {
//        do {
//            let _ = try db.collection("cart").addDocument(from: cartItem, completion: { error in
//                completion(error)
//            })
//        } catch {
//            completion(error)
//        }
//    }
    
    // Mendapatkan Semua Item di Cart
    func fetchCartItems(completion: @escaping ([CartItem]?, Error?) -> Void) {
        db.collection("cart").getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
            } else {
                let items = snapshot?.documents.compactMap { document -> CartItem? in
                    try? document.data(as: CartItem.self)
                }
                completion(items, nil)
            }
        }
    }
    // Mendelete Semua Item di Cart
    
    func deleteCartItem(itemID: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("cart").document(itemID).delete { error in
            completion(error)
        }
    }

    
//    func deleteCartItem(itemID: String, completion: @escaping (Result<Void, Error>) -> Void) {
//        db.collection("cartItems").document(itemID).delete { error in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//        }
//    }
    // MARK: - Order
    // Menambahkan Order
    
    //p1
//    func addOrder(_ order: Order, completion: @escaping (Error?) -> Void) {
//        do {
//            let _ = try db.collection("orders").addDocument(from: order, completion: { error in
//                completion(error)
//            })
//        } catch {
//            completion(error)
//        }
//    }
    
    // Mendapatkan Semua Order
//    func fetchOrders(completion: @escaping ([Order]?, Error?) -> Void) {
//           db.collection("orders").getDocuments { snapshot, error in
//               if let error = error {
//                   completion(nil, error)
//               } else {
//                   let orders = snapshot?.documents.compactMap { document -> Order? in
//                       guard let data = document.data() as? [String: Any],
//                             let itemsData = data["items"] as? [[String: Any]],
//                             let total = data["total"] as? Double,
//                             let paymentMethod = data["paymentMethod"] as? String,
//                             let address = data["address"] as? String,
//                             let timestamp = data["date"] as? Timestamp else { return nil }
//
//                       let items = itemsData.compactMap { itemData -> OrderItem? in
//                           guard let productID = itemData["productID"] as? String,
//                                 let productName = itemData["productName"] as? String,
//                                 let quantity = itemData["quantity"] as? Int,
//                                 let price = itemData["price"] as? Double else { return nil }
//                           return OrderItem(productID: productID, productName: productName, quantity: quantity, price: price)
//                       }
//
//                       return Order(
//                           id: document.documentID,
//                           items: items,
//                           total: total,
//                           paymentMethod: paymentMethod,
//                           address: address,
//                           date: timestamp.dateValue()
//                       )
//                   }
//                   completion(orders, nil)
//               }
//           }
//       }
}
