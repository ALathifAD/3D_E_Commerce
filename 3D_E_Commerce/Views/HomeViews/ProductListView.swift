//
//  ProductListView.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//


import SwiftUI

struct ProductListView: View {
    @Namespace var animation
    //    @State private var products: [Product] = []
    @State private var currentSlider: Int = 0
    @State private var sliders: [Slider] = []
    @EnvironmentObject var baseData: BaseViewModel
    @State private var searchQuery: String = ""
    @State private var selectedCategory: String = "All Product"
    
    @StateObject private var viewModel = ProductViewModel()
    
    //    private let firestoreManager = FirestoreManager()
    
    
    var filteredProducts: [Product] {
        var results = viewModel.products
        
        // Filter by category
        if selectedCategory != "All Product" {
            results = results.filter { product in
                product.name.lowercased().contains(selectedCategory.lowercased())
            }
        }
        
        // Additional search query filter
        if !searchQuery.isEmpty {
            results = results.filter { product in
                product.name.lowercased().contains(searchQuery.lowercased())
            }
        }
        
        return results
    }
    
    
    //    var filteredProducts: [Product] {
    //        if searchQuery.isEmpty {
    //            return viewModel.products
    //        } else {
    //            return viewModel.products.filter { product in
    //                product.name.lowercased().contains(searchQuery.lowercased())
    //            }
    //        }
    //    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) { // Memberikan jarak antar section utama
                    // MARK: - APP BAR
                    HStack {
                        Image("logo1")
                            .resizable()
                            .frame(width: 90, height: 80)
                        
                        Spacer()
                        
                        HStack {
                            TextField("Search products...", text: $searchQuery)
                                .padding(.leading, 10)
                                .frame(height: 40)
                                .onChange(of: searchQuery) { newValue in
                                    print("Search query updated: \(newValue)")
                                }
                            
                            
                            // Ikon kaca pembesar di dalam TextField
                            Button(action: {
                                // Aksi pencarian
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .font(.title2)
                                    .padding(.trailing, 10)
                                    .foregroundColor(.gray)
                            }
                        }
                        .background(Color(.systemGray6)) // Warna latar TextField
                        .cornerRadius(10) // Membuat sudut melengkung
                        
                    }
                    .padding(.horizontal, 20) // Memberikan padding horizontal untuk App Bar
                    .padding(.top, 10) // Tambahkan padding atas
                    
                    // MARK: - SLIDER
                    VStack(spacing: 15) {
                        HomeSlider(trailingSpace: 40, index: $currentSlider, items: sliders) { slider in
                            GeometryReader { proxy in
                                let sliderWidth = proxy.size.width
                                let sliderHeight = sliderWidth * 0.6 // Sesuaikan rasio aspek (contoh: 16:9)
                                
                                Image(slider.sliderImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: sliderWidth, height: sliderHeight)
                                    .clipped() // Memastikan tidak ada bagian gambar yang keluar
                                    .cornerRadius(12)
                            }
                            .frame(height: UIScreen.main.bounds.width * 0.6) // Tetapkan tinggi untuk slider secara eksplisit
                        }
                        .padding(.vertical, 10)
                        
                        Text("")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 60)
                            .onAppear {
                                if sliders.isEmpty {
                                    for index in 1...4 {
                                        sliders.append(Slider(sliderImage: "sliderr\(index)"))
                                    }
                                }
                            }
                    }
                    
                    
                    
                    // Slider Indicators
                    HStack(spacing: 10) {
                        ForEach(sliders.indices, id: \.self) { index in
                            Circle()
                                .fill(Color.black.opacity(currentSlider == index ? 1 : 0.1))
                                .frame(width: 7, height: 7)
                                .scaleEffect(currentSlider == index ? 1.4 : 1)
                                .animation(.spring(), value: currentSlider)
                        }
                    }
                    .padding(.top, 5)
                    
                    
                    // MARK: - CATEGORY SLIDER
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 18) {
                            CategoryItem(
                                image: "square.grid.2x2",
                                title: "All Product",
                                isSelected: selectedCategory == "All Product",
                                action: {
                                    selectedCategory = "All Product"
                                    searchQuery = ""
                                }
                            )
                            
                            CategoryItem(
                                image: "chair",
                                title: "Chair",
                                isSelected: selectedCategory == "Chair",
                                action: {
                                    selectedCategory = "Chair"
                                    searchQuery = ""
                                }
                            )
                            
                            CategoryItem(
                                image: "square.grid.3x2",
                                title: "Table",
                                isSelected: selectedCategory == "Table",
                                action: {
                                    selectedCategory = "Table"
                                    searchQuery = ""
                                }
                            )
                            
                            CategoryItem(
                                image: "figure.walk",
                                title: "Figure",
                                isSelected: selectedCategory == "Figure",
                                action: {
                                    selectedCategory = "Figure"
                                    searchQuery = ""
                                }
                            )
                        }
                        //                        HStack(spacing: 18) {
                        //                            CategoryItem(image: "square.grid.2x2", title: "All Product") // Ikon grid
                        //                            CategoryItem(image: "chair", title: "Chair") // Ikon kursi
                        //                            CategoryItem(image: "square.grid.3x2", title: "Table") // Ikon meja
                        //                            CategoryItem(image: "figure.walk", title: "Figure") // Ikon figure
                        //                        }
                        .padding(.horizontal, 20) // Tambahkan padding horizontal
                        .padding(.vertical, 10) // Tambahkan padding vertikal
                    }
                    
                    // MARK: - PRODUCT LIST
                    Text("Our Products")
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20) // Tambahkan padding horizontal
                    
                    let columns = [
                        GridItem(.flexible(), spacing: 15),
                        GridItem(.flexible(), spacing: 15)
                    ]
                    
                    
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(filteredProducts) { product in
                            NavigationLink(destination: Home(product: product)) {
                                CardView(product: product)
                                    .padding(.vertical, 10)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    
                    
                    
                }
                .padding(.vertical, 10) // Tambahkan padding vertikal untuk seluruh konten
                /*.background(Color.gray.opacity(0.1))*/ // Warna latar belakang
                .cornerRadius(20)
                .onAppear {
                    viewModel.loadProducts()
                }
            }
            .background(Color.gray.opacity(0.2).ignoresSafeArea())
            .navigationBarHidden(true)
        }
        //        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
    }
    
    // MARK: - CARD VIEW
    @ViewBuilder
    func CardView(product: Product) -> some View {
        VStack(spacing: 15) {
            Button {
                // Aksi like
            } label: {
                Image(systemName: "")
                    .font(.system(size: 13))
                    .padding(5)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Image(product.ImgProduct)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .padding()
            
            Text(product.name)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            Text("Rp \(product.price)")
                .font(.title2.bold())
        }
        .padding()
        .background(Color.white, in: RoundedRectangle(cornerRadius: 12))
        .frame(height: 250)
    }
    
    // MARK: - CATEGORY ITEM
    
    @ViewBuilder
    func CategoryItem(image: String, title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button {
            action()
            withAnimation {
                baseData.homeTab = title
            }
        } label: {
            HStack(spacing: 8) {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 27, height: 27)
                    .foregroundColor(isSelected ? .white : .cyan)
                
                Text(title)
                    .font(.system(size: 12.5))
                    .fontWeight(.bold)
                    .foregroundColor(isSelected ? .white : .black)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                isSelected ? Color.cyan : Color.gray.opacity(0.2),
                in: RoundedRectangle(cornerRadius: 8)
            )
        }
    }
    
    
    
    //    @ViewBuilder
    //    func CategoryItem(image: String, title: String) -> some View {
    //        Button {
    //            withAnimation { baseData.homeTab = title }
    //        } label: {
    //            HStack(spacing: 8) {
    //                Image(systemName: image) // Menggunakan SF Symbols
    //                    .resizable()
    //                    .aspectRatio(contentMode: .fit)
    //                    .frame(width: 27, height: 27)
    //                    .foregroundColor(.cyan) // Menambahkan warna untuk ikon
    //
    //                Text(title)
    //                    .font(.system(size: 12.5))
    //                    .fontWeight(.bold)
    //                    .foregroundColor(.black)
    //            }
    //            .padding(.vertical, 8)
    //            .padding(.horizontal, 12)
    //            .background(Color.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
    //        }
    //    }
    //
    //}
    
    //
    //#Preview {
    //    ProductListView()
    //}
}
