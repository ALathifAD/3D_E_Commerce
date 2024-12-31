//
//  CheckoutView.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//


import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var cartData: CartViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel
    @State private var address: String = "123 Default Street, City, Country"
    @State private var isEditingAddress: Bool = false
    @State private var selectedPaymentMethod: PaymentMethod? = nil
    @State private var isPaymentMethodSheetPresented = false
    
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    @State private var navigateToOrderDetail = false
    
    @Environment(\.presentationMode) private var presentationMode

    // Enum untuk metode pembayaran
    enum PaymentMethod: String, CaseIterable {
        case creditCard = "Credit Card"
        case touchNGo = "Touch 'n Go"
        case masterCard = "Master Card"
        case debitCard = "Debit Card"
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 26, weight: .heavy))
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding()
                Text("Checkout")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding()
                
                // List Produk (seperti sebelumnya)
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 10) {
                        ForEach(cartData.items) { item in
                            HStack {
                                Image(systemName: "cube.box")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(item.product.name)
                                        .font(.headline)
                                    
                                    Text("RM \(Float(item.product.price) ?? 0, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text("x\(item.quantity)")
                                    .font(.subheadline)
                            }
                            .padding()
                        }
                    }
                }
                .padding(.horizontal)
                .overlay(
                    Group {
                        if showToast {
                            GeometryReader { geo in
                                VStack {
                                    Text(toastMessage)
                                        .padding()
                                        .background(Color.green.opacity(0.8))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .shadow(radius: 5)
                                        .transition(.opacity)
                                        .animation(.easeInOut(duration: 0.5), value: showToast)
                                }
                                .frame(width: geo.size.width * 0.9)
                                .position(x: geo.size.width / 2, y: geo.safeAreaInsets.top + 50)
                            }
                        }
                    }
                )

                
                // Pilih Metode Pembayaran
                VStack(alignment: .leading, spacing: 10) {
                    Text("Payment Method")
                        .font(.headline)
                    
                    Button(action: {
                        isPaymentMethodSheetPresented = true
                    }) {
                        HStack {
                            Text(selectedPaymentMethod?.rawValue ?? "Select Payment Method")
                                .foregroundColor(selectedPaymentMethod == nil ? .gray : .black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                }
                .padding()
                
                // Alamat Pengiriman (seperti sebelumnya)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Shipping Address")
                        .font(.headline)
                    
                    if isEditingAddress {
                        TextField("Enter new address", text: $address)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(address)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        isEditingAddress.toggle()
                    }) {
                        Text(isEditingAddress ? "Save Address" : "Edit Address")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                Spacer()
                
                // Tombol Place Order
                Button(action: {
                    placeOrder()
                }) {
                    Text("Place Order")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(15)
                }
                
                .padding()
            }
            
            .background(Color("gray").ignoresSafeArea())
            .navigationDestination(isPresented: $navigateToOrderDetail) {
                if let lastOrder = orderViewModel.orders.last {
                    DetailOrderView(order: lastOrder)
                } else {
                    Text("Order details not available.")
                }
                   
            }

            .sheet(isPresented: $isPaymentMethodSheetPresented) {
                PaymentMethodSelectionView(selectedMethod: $selectedPaymentMethod)
                    .presentationDetents([.large])
            }
        }
        .navigationBarHidden(true)
    }
    
    func placeOrder() {
        guard let paymentMethod = selectedPaymentMethod else {
            print("Please select a payment method")
            return
        }

        // Menghitung total harga
        let total = cartData.items.reduce(0) { total, item in
            let price = Double(item.product.price) ?? 0.0
            return total + price * Double(item.quantity)
        }

        // Menambahkan pesanan ke database
        
        // Menambahkan pesanan ke database
        let orderItems = cartData.items.map { item in
            // Pastikan nilai dari item.product.price adalah Double yang valid
            let price = Double(item.product.price) ?? 0.0 // Menggunakan ?? untuk memberi nilai default jika nil
            return OrderItem(
                id: item.product.id ?? UUID().uuidString,
                product: item.product, // Gunakan product objek langsung
                productName: item.product.name, // Unwrap nama produk, atau beri nilai default jika nil
                quantity: item.quantity,
                price: price
            )
        }
        
        // cara 1
//        let orderItems = cartData.items.map { item in
//            // Pastikan nilai dari item.product.price adalah Double yang valid
//            let price = Double(item.product.price) ?? 0.0 // Menggunakan ?? untuk memberi nilai default jika nil
//            return OrderItem(
//                productID: item.product.id ?? "", // Pastikan id bukan opsional, atau beri nilai default
//                productName: item.product.name, // Unwrap nama produk, atau beri nilai default jika nil
//                quantity: item.quantity,
//                price: price
//            )
//        }

        
//        let orderItems = cartData.items.map { item in
//            OrderItem(productID: item.product.id, productName: item.product.name, quantity: item.quantity, price: item.product.price)
//        }
        
        let newOrder = Order(
            id: UUID().uuidString, // Membuat ID unik untuk order
            items: orderItems,
            total: total,
            paymentMethod: paymentMethod.rawValue,
            address: address,
            date: Date()
        )
        
        orderViewModel.addOrder(newOrder: newOrder) { success in
            if success {
                // Hapus semua barang dari keranjang setelah pesanan berhasil dibuat
                DispatchQueue.main.async {
                    cartData.items.removeAll()
                    toastMessage = "Order placed successfully!"
                    withAnimation {
                        showToast = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            showToast = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            navigateToOrderDetail = true
                        }
                    }
                }
            } else {
                print("Failed to place order. Please try again.")
            }
        }
    }

    
//    func placeOrder() {
//        guard let paymentMethod = selectedPaymentMethod else {
//            print("Please select a payment method")
//            return
//        }
//        let total = cartData.items.reduce(0) { total, item in
//            let price = Double(item.product.price) ?? 0.0
//            return total + price * Double(item.quantity)
//        }
//        orderViewModel.addOrder(products: cartData.items, total: total, paymentMethod: paymentMethod.rawValue, address: address)
//        cartData.items.removeAll()
//        toastMessage = "Order placed successfully!"
//        withAnimation {
//            showToast = true
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            withAnimation {
//                showToast = false
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                navigateToOrderDetail = true
//            }
//        }
//    }
    
}

// View untuk memilih metode pembayaran
struct PaymentMethodSelectionView: View {
    @Binding var selectedMethod: CheckoutView.PaymentMethod?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Text("Select Payment Method")
                .font(.title2)
                .fontWeight(.bold)
                .padding()

            ScrollView {
                VStack(spacing: 15) {
                    ForEach(CheckoutView.PaymentMethod.allCases, id: \.self) { method in
                        Button(action: {
                            selectedMethod = method
                            dismiss()
                        }) {
                            HStack {
                                if UIImage(systemName: paymentMethodIcon(for: method)) != nil {
                                    Image(systemName: paymentMethodIcon(for: method))
                                        .foregroundColor(.blue)
                                } else {
                                    Image(paymentMethodIcon(for: method))
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                                Text(method.rawValue)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
                    }
                }
                .padding()
            }
        }
    }

    // Fungsi untuk mendapatkan icon sesuai metode pembayaran
    func paymentMethodIcon(for method: CheckoutView.PaymentMethod) -> String {
        switch method {
        case .creditCard: return "creditcard"
        case .touchNGo: return "TnG"
        case .masterCard: return "creditcard.fill"
        case .debitCard: return "creditcard.and.123"
        }
    }
}

#Preview {
    CheckoutView()
        .environmentObject(CartViewModel())
}
