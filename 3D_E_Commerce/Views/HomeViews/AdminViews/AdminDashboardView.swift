//
//  AdminDashboardView.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 14/12/24.
//

import SwiftUI

struct AdminDashboardView: View {
    @State private var selectedTab: Tab = .product
    @StateObject private var productViewModel = ProductViewModel()
    @StateObject private var orderViewModel = OrderViewModel()
    @State private var isAddProductPresented = false
    @State private var selectedProduct: Product? = nil
    @State private var showNotification = false
    @State private var notificationMessage = ""
    @State private var notificationType: NotificationType = .success

    enum Tab {
        case product
        case orders
    }

    enum NotificationType {
        case success
        case error
        
        var color: Color {
            switch self {
            case .success: return .green
            case .error: return .red
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    // Tab Selector
                    HStack {
                        Button(action: {
                            selectedTab = .product
                        }) {
                            Text("Products")
                                .font(.headline)
                                .foregroundColor(selectedTab == .product ? .white : .blue)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedTab == .product ? Color.blue : Color.clear)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            selectedTab = .orders
                        }) {
                            Text("Orders")
                                .font(.headline)
                                .foregroundColor(selectedTab == .orders ? .white : .blue)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedTab == .orders ? Color.blue : Color.clear)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    
                    // Content based on selected tab
                    if selectedTab == .product {
                        productManagementView
                    } else {
                        AdminOrder()
                            .environmentObject(orderViewModel)
                    }
                }
                
                // Notification View
                if showNotification {
                    notificationView
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Product Management View
    private var productManagementView: some View {
        VStack(spacing: 0) {
            List {
                Section(header: Text("Product Management").font(.headline)) {
                    ForEach(productViewModel.products) { product in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.headline)
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 10) {
                                Button(action: {
                                    selectedProduct = product
                                    isAddProductPresented = true
                                }) {
                                    Text("Edit")
                                        .foregroundColor(.blue)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(8)
                                }
                                
                                Button(action: {
                                    if let productId = product.id {
                                        productViewModel.deleteProduct(productId: productId)
                                        showNotification(message: "Produk Berhasil Dihapus", type: .success)
                                        productViewModel.loadProducts() // Refresh products
                                    }
                                }) {
                                    Text("Delete")
                                        .foregroundColor(.red)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(Color.red.opacity(0.1))
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(PlainListStyle())
            
            Button("Add Product") {
                selectedProduct = nil
                isAddProductPresented = true
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("Product Management")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddProductPresented) {
            AddEditProductView(product: $selectedProduct, onSave: { product in
                if let existingProduct = product {
                    if existingProduct.id == nil {
                        productViewModel.addProduct(product: existingProduct)
                        showNotification(message: "Produk Berhasil Ditambahkan", type: .success)
                    } else {
                        productViewModel.updateProduct(product: existingProduct)
                        showNotification(message: "Produk Berhasil Diperbarui", type: .success)
                    }
                    
                    // Reload products and dismiss sheet
                    productViewModel.loadProducts()
                    isAddProductPresented = false
                }
            })
        }
        .onAppear {
            productViewModel.loadProducts()
        }
    }
    
    // Orders View
    private var ordersView: some View {
        VStack {
            Text("Orders Management")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
    }
    
    // Notification View
    private var notificationView: some View {
        VStack {
            Spacer()
            HStack {
                Text(notificationMessage)
                    .foregroundColor(.white)
                    .padding()
            }
            .background(notificationType.color)
            .cornerRadius(10)
            .transition(.move(edge: .bottom))
            .zIndex(1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showNotification = false
                }
            }
        }
    }
    
    // Helper method to show notification
    private func showNotification(message: String, type: NotificationType) {
        notificationMessage = message
        notificationType = type
        showNotification = true
    }
}






//import SwiftUI
//
//struct AdminDashboardView: View {
//    @StateObject private var productViewModel = ProductViewModel()
//    @State private var isAddProductPresented = false
//    @State private var selectedProduct: Product? = nil
//    @State private var showNotification = false
//    @State private var notificationMessage = ""
//    @State private var notificationType: NotificationType = .success
//
//    enum NotificationType {
//        case success
//        case error
//        
//        var color: Color {
//            switch self {
//            case .success: return .green
//            case .error: return .red
//            }
//        }
//    }
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                VStack(spacing: 0) {
//                    List {
//                        Section(header: Text("Product Management").font(.headline)) {
//                            ForEach(productViewModel.products) { product in
//                                HStack {
//                                    VStack(alignment: .leading) {
//                                        Text(product.name)
//                                            .font(.headline)
//                                    }
//                                    
//                                    Spacer()
//                                    
//                                    HStack(spacing: 10) {
//                                        Button(action: {
//                                            selectedProduct = product
//                                            isAddProductPresented = true
//                                        }) {
//                                            Text("Edit")
//                                                .foregroundColor(.blue)
//                                                .padding(.vertical, 8)
//                                                .padding(.horizontal, 12)
//                                                .background(Color.blue.opacity(0.1))
//                                                .cornerRadius(8)
//                                        }
//                                        
//                                        Button(action: {
//                                            if let productId = product.id {
//                                                productViewModel.deleteProduct(productId: productId)
//                                                showNotification(message: "Produk Berhasil Dihapus", type: .success)
//                                                productViewModel.loadProducts() // Refresh products
//                                            }
//                                        }) {
//                                            Text("Delete")
//                                                .foregroundColor(.red)
//                                                .padding(.vertical, 8)
//                                                .padding(.horizontal, 12)
//                                                .background(Color.red.opacity(0.1))
//                                                .cornerRadius(8)
//                                        }
//                                    }
//                                }
//                                .padding(.vertical, 8)
//                            }
//                        }
//                    }
//                    .listStyle(PlainListStyle())
//                    
//                    Button("Tambah Produk") {
//                        selectedProduct = nil
//                        isAddProductPresented = true
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .padding()
//                }
//                .navigationTitle("Product Management")
//                .navigationBarTitleDisplayMode(.inline)
//                .sheet(isPresented: $isAddProductPresented) {
//                    AddEditProductView(product: $selectedProduct, onSave: { product in
//                        if let existingProduct = product {
//                            if existingProduct.id == nil {
//                                productViewModel.addProduct(product: existingProduct)
//                                showNotification(message: "Produk Berhasil Ditambahkan", type: .success)
//                            } else {
//                                productViewModel.updateProduct(product: existingProduct)
//                                showNotification(message: "Produk Berhasil Diperbarui", type: .success)
//                            }
//                            
//                            // Important: Reload products and dismiss sheet
//                            productViewModel.loadProducts()
//                            isAddProductPresented = false
//                        }
//                    })
//                }
//                .onAppear {
//                    productViewModel.loadProducts()
//                }
//                
//                // Notification View
//                if showNotification {
//                    notificationView
//                }
//            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//    }
//    
//    // Notification View
//    private var notificationView: some View {
//        VStack {
//            Spacer()
//            HStack {
//                Text(notificationMessage)
//                    .foregroundColor(.white)
//                    .padding()
//            }
//            .background(notificationType.color)
//            .cornerRadius(10)
//            .transition(.move(edge: .bottom))
//            .zIndex(1)
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//        .edgesIgnoringSafeArea(.bottom)
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                withAnimation {
//                    showNotification = false
//                }
//            }
//        }
//    }
//    
//    // Helper method to show notification
//    private func showNotification(message: String, type: NotificationType) {
//        notificationMessage = message
//        notificationType = type
//        showNotification = true
//    }
//}















//import SwiftUI
//
//struct AdminDashboardView: View {
//    @StateObject private var productViewModel = ProductViewModel()
//    @State private var isAddProductPresented = false
//    @State private var selectedProduct: Product? = nil
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 0) {
//                // Full-screen List with more padding and improved styling
//                List {
//                    Section(header: Text("Product Management").font(.headline)) {
//                        ForEach(productViewModel.products) { product in
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    Text(product.name)
//                                        .font(.headline)
//                                    // You can add more product details here if needed
//                                }
//                                
//                                Spacer()
//                                
//                                HStack(spacing: 10) {
//                                    Button(action: {
//                                        selectedProduct = product
//                                        isAddProductPresented = true
//                                    }) {
//                                        Text("Edit")
//                                            .foregroundColor(.blue)
//                                            .padding(.vertical, 8)
//                                            .padding(.horizontal, 12)
//                                            .background(Color.blue.opacity(0.1))
//                                            .cornerRadius(8)
//                                    }
//                                    
//                                    Button(action: {
//                                        if let productId = product.id {
//                                            productViewModel.deleteProduct(productId: productId)
//                                        }
//                                    }) {
//                                        Text("Delete")
//                                            .foregroundColor(.red)
//                                            .padding(.vertical, 8)
//                                            .padding(.horizontal, 12)
//                                            .background(Color.red.opacity(0.1))
//                                            .cornerRadius(8)
//                                    }
//                                }
//                            }
//                            .padding(.vertical, 8)
//                        }
//                    }
//                }
//                .listStyle(PlainListStyle())
//                
//                // Add Product Button
//                Button("Add Product") {
//                    selectedProduct = nil
//                    isAddProductPresented = true
//                }
//                .buttonStyle(.borderedProminent)
//                .padding()
//            }
//            .navigationTitle("Manage Products")
//            .navigationBarTitleDisplayMode(.inline)
//            .sheet(isPresented: $isAddProductPresented) {
//                AddEditProductView(product: $selectedProduct) { product in
//                    if let existingProduct = product {
//                        if existingProduct.id == nil {
//                            productViewModel.addProduct(product: existingProduct)
//                        } else {
//                            productViewModel.updateProduct(product: existingProduct)
//                        }
//                    }
//                }
//            }
//            .onAppear {
//                productViewModel.loadProducts()
//            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//    }
//}



















//import SwiftUI
//
//struct AdminDashboardView: View {
//    @StateObject private var productViewModel = ProductViewModel()
//    @State private var isAddProductPresented = false
//    @State private var selectedProduct: Product? = nil
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List(productViewModel.products) { product in
//                    HStack {
//                        Text(product.name)
//                        Spacer()
//                        Button(action: {
//                            selectedProduct = product
//                            isAddProductPresented = true
//                        }) {
//                            Text("Edit")
//                        }
//                        .padding(.trailing)
//                        Button(action: {
//                            if let productId = product.id {
//                                productViewModel.deleteProduct(productId: productId)
//                            }
//                        }) {
//                            Text("Delete")
//                                .foregroundColor(.red)
//                        }
//                    }
//                }
//                .onAppear {
//                    productViewModel.loadProducts()
//                }
//
//                Button("Add Product") {
//                    selectedProduct = nil
//                    isAddProductPresented = true
//                }
//                .padding()
//            }
//            .navigationTitle("Manage Products")
//            .sheet(isPresented: $isAddProductPresented) {
//                AddEditProductView(product: $selectedProduct) { product in
//                    if let existingProduct = product {
//                        if existingProduct.id == nil {
//                            productViewModel.addProduct(product: existingProduct)
//                        } else {
//                            productViewModel.updateProduct(product: existingProduct)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}







//---------------------------
//import SwiftUI
//
//
//
//import SwiftUI
//
//struct AdminDashboardView: View {
//    @StateObject private var viewModel = ProductViewModel()
//
//    @State private var name: String = ""
//    @State private var ImgProduct: String = ""
//    @State private var price: String = ""
//    @State private var description: String = ""
//    @State private var rating: Double = 0.0
//    @State private var scnFileName: String = ""
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                TextField("Product Name", text: $name)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                TextField("Image URL", text: $ImgProduct)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                TextField("Price", text: $price)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                TextField("Description", text: $description)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                TextField("Scene File Name", text: $scnFileName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                Text("Rating: \(String(format: "%.1f", rating))")
//
//                Button(action: {
//                    let newProduct = Product(
//                        id: UUID().uuidString,
//                        name: name,
//                        ImgProduct: ImgProduct,
//                        price: price,
//                        description: description,
//                        rating: rating,
//                        scnFileName: scnFileName
//                    )
//                    viewModel.addProduct(product: newProduct)
//                }) {
//                    Text("Add Product")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//
//                if let error = viewModel.addProductError {
//                    Text("Error: \(error)")
//                        .foregroundColor(.red)
//                }
//
//                Spacer()
//
//                List(viewModel.products) { product in
//                    VStack(alignment: .leading) {
//                        Text(product.name).font(.headline)
//                        Text("Price: \(product.price)")
//                        Text("Rating: \(product.rating, specifier: "%.1f")")
//                    }
//                }
//                .onAppear {
//                    viewModel.loadProducts()
//                }
//            }
//            .padding()
//            .navigationTitle("Admin Page")
//        }
//    }
//}
//















//import FirebaseFirestore
//
//struct AdminDashboardView: View {
//    enum AdminSection {
//            case products
//            case cartItems
//            case orders
//        }
//        
//        // State variables
//        @State private var selectedSection: AdminSection = .products
//        @State private var products: [Product] = []
//        @State private var cartItems: [CartItem] = []
//        @State private var orders: [Order] = []
//        
//        // Modal states for adding/editing
//        @State private var showAddProductModal = false
//        @State private var showEditProductModal = false
//        @State private var selectedProduct: Product?
//    @StateObject private var managementModel = FirestoreManager()
//    @StateObject private var orderModel = OrderViewModel()
//
//        // Firestore reference
//        private let db = Firestore.firestore()
//        
//        var body: some View {
//            HStack {
//                // Left Side Navigation
//                VStack(alignment: .leading, spacing: 10) {
//                    navigationItem(title: "Products", section: .products)
//                    navigationItem(title: "Liked Items", section: .cartItems)
//                    navigationItem(title: "Orders", section: .orders)
//                    
//                    Spacer()
//                }
//                .frame(width: 200)
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                
//                // Main Content Area
//                VStack {
//                    switch selectedSection {
////                    case .products:
////                        ProductManagementView(
////                            products: $products,
////                            showAddModal: $showAddProductModal,
////                            showEditModal: $showEditProductModal,
////                            selectedProduct: $selectedProduct
////                        )
////                    case .likedItems:
////                        CartManagementView(likedItems: $likedItems)
////                    case .orders:
////                        OrderManagementView(orders: $orders)
//                    }
//                }
//                .frame(maxWidth: .infinity)
//            }
//            .onAppear {
//                managementModel.fetchProducts()
//                managementModel.fetchCartItems()
//                orderModel.fetchOrders()
//            }
//        }
//    
//    private func navigationItem(title: String, section: AdminSection) -> some View {
//            HStack {
//                Text(title)
//                    .fontWeight(selectedSection == section ? .bold : .regular)
//                    .foregroundColor(selectedSection == section ? .blue : .black)
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(8)
//            .background(selectedSection == section ? Color.blue.opacity(0.1) : Color.clear)
//            .cornerRadius(8)
//            .onTapGesture {
//                selectedSection = section
//            }
//        }
//}
//
//#Preview {
//    AdminDashboardView()
//}
