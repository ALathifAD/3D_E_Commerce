//
//  OrderDetailView.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//



//import SwiftUI
//import FirebaseFirestore
//
//struct OrderDetailView: View {
//    let order: Order
//    @State private var products: [Product] = []
//    @State private var isLoading = true
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            if isLoading {
//                ProgressView()
//            } else {
//                Text("Order Details")
//                    .font(.title)
//                    .fontWeight(.bold)
//
//                Text("Total: RM \(order.total, specifier: "%.2f")")
//                    .font(.headline)
//
//                Text("Payment Method: \(order.paymentMethod)")
//                    .font(.subheadline)
//
//                Text("Shipping Address: \(order.address)")
//                    .font(.subheadline)
//                    .padding(.bottom)
//
//                Text("Products:")
//                    .font(.headline)
//                
//                ScrollView {
//                    ForEach(order.productIds, id: \.self) { productId in
//                        if let product = products.first(where: { $0.id == productId }) {
//                            HStack {
//                                AsyncImage(url: URL(string: product.imgProduct)) { image in
//                                    image.resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: 130, height: 130)
//                                        .cornerRadius(15)
//                                } placeholder: {
//                                    ProgressView()
//                                }
//                                
//                                VStack(alignment: .leading) {
//                                    Text(product.name)
//                                        .font(.headline)
//                                    Text("Price: RM \(product.price)")
//                                        .font(.subheadline)
//                                }
//                                
//                                Spacer()
//                            }
//                            .padding(.vertical, 5)
//                        }
//                    }
//                }
//                
//                Spacer()
//            }
//        }
//        .padding()
//        .onAppear {
//            fetchProducts()
//        }
//    }
//    
//    private func fetchProducts() {
//        let db = Firestore.firestore()
//        
//        // Fetch all products referenced in the order
//        db.collection("products").whereField("id", in: order.productIds).getDocuments { (querySnapshot, error) in
//            if let error = error {
//                print("Error fetching products: \(error.localizedDescription)")
//                isLoading = false
//                return
//            }
//            
//            self.products = querySnapshot?.documents.compactMap { document in
//                do {
//                    return try document.data(as: Product.self)
//                } catch {
//                    print("Error decoding product: \(error)")
//                    return nil
//                }
//            } ?? []
//            
//            isLoading = false
//        }
//    }
//}
//
//// Optionally, if you want a preview
//struct OrderDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Create a mock order for preview
//        let mockOrder = Order(
//            productIds: ["product1", "product2"],
//            total: 1500.00,
//            paymentMethod: "Credit Card",
//            address: "123 Main St, Anytown, USA",
//            userId: "user123",
//            createdAt: Date()
//        )
//        
//        OrderDetailView(order: mockOrder)
//    }
//}





import SwiftUI

struct OrderDetailView: View {
    let order: Order

    @Environment(\.presentationMode) private var presentationMode
    @State private var selectedRating: Double = 0.0 // Menyimpan nilai rating pengguna
    @StateObject private var productViewModel = ProductViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 20) {
                Button {
                    // Kembali ke halaman sebelumnya
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16, weight: .heavy))
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)
                        .background{
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(.black.opacity(0.2))
                        }
                }
                Spacer()
            }
            Text("Order Details")
                .font(.title)
                .fontWeight(.bold)

            Text("Total: RM \(order.total, specifier: "%.2f")")
                .font(.headline)

            Text("Payment Method: \(order.paymentMethod)")
                .font(.subheadline)

            Text("Shipping Address: \(order.address)")
                .font(.subheadline)
                .padding(.bottom)
            
            Text("Products:")
                .font(.headline)
            
            ForEach(order.items, id: \.product.id) { item in
                
                HStack {
                    // Jika ada URL atau nama gambar, gunakan `Image`.
//                    Image(item.product.ImgProduct)
                    Image(item.product.ImgProduct)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                    // Untuk sementara tampilkan nama produk.
                    Text(item.productName)
                        .font(.body)
                        .fontWeight(.medium)
                    Spacer()
                    Text("x\(item.quantity)")
                    Text("RM \(item.price)")
                }
                HStack {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= Int(selectedRating) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                selectedRating = Double(star)
                                updateRating() // Panggil fungsi untuk menyimpan ke Firebase
                            }
                    }
                }
                                    Text("Rating: \(String(format: "%.1f", selectedRating))")
                                        .font(.subheadline)
                                        .padding(.top, 4)
            }
            
//            ForEach(order.products) { item in
//                HStack {
//                    Image(item.product.ImgProduct)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 130, height: 130)
//                        .cornerRadius(15)
//                    Text(item.product.name)
//                    Spacer()
//                    Text("x\(item.quantity)")
//                }
//            }
            Spacer()
            
        }
        .padding()
        .navigationBarHidden(true)
        .onAppear {
            if let productRating = order.items.first?.product.rating {
                selectedRating = productRating
            }
        }

    }
    func updateRating() {
        productViewModel.updateRating(for: order.items.first?.product.id ?? "", newRating: selectedRating)
    }

}


