//
//  Home.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//

import SwiftUI
import SceneKit

struct Home: View {
    var product: Product
    @State var scene: SCNScene? /*= .init(named: "wooden_chair.scn")*/
    @EnvironmentObject var baseData: BaseViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
    
    init(product: Product) {
        self.product = product
        // Muat scene berdasarkan produk
        _scene = State(initialValue: SCNScene(named: product.scnFileName))
    }
    
    var body: some View {
        VStack{
            HeaderView()
            // MARK: 3
            CustomSceneView(scene: $scene)
                .frame(height: 320)
            CustomSeeker()
            FurniPropertiesView()
            
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .onAppear {
            withAnimation {
                baseData.showDetail = true // Sembunyikan tab bar
            }
        }
        .onDisappear {
            withAnimation {
                baseData.showDetail = false // Tampilkan tab bar kembali
            }
        }
        
        .overlay(
            Group {
                if showToast {
                    VStack {
                        Text(toastMessage)
                            .padding()
                            .background(Color.green.opacity(0.8))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .transition(.opacity)
                            .padding(.top, 20) // Mengatur jarak dari atas
                        Spacer() // Menghilangkan Spacer() untuk memastikan toast tidak terhalang bagian bawah
                    }
                    .frame(maxWidth: .infinity, alignment: .top) // Memastikan pesan muncul di atas
                    .padding(.top, 60) // Sesuaikan padding sesuai kebutuhan
                    .animation(.easeInOut, value: showToast)
                }
            }
        )
    }
    
    @ViewBuilder
    func FurniPropertiesView() -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                // Nama Produk
                Text(product.name)
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                Text("Price: RM \(product.price)")
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray)
                Text(product.description)
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .padding(.top, 10)
                
                
                // Rating dan Ikon Suka
                HStack(spacing: 20) {
                    // Rating dengan Bintang
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Image(systemName: "star")
                            .foregroundColor(.yellow)
                        Text("23")
//                        Text("\(product.rating)")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    
                    // Tanda Suka (Favorite)
                    Button(action: {
                        cartViewModel.likeProduct(product: product)
                        toastMessage = "\(product.name) added to liked Product."
                        withAnimation {
                            showToast = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showToast = false
                            }
                        }
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                }
                .padding(.top, 10)
                
                // Tombol Add to Cart
                Button(action: {
                    cartViewModel.addToCart(product: product)// Aksi untuk menambahkan ke favorit// Aksi untuk menambahkan ke keranjang
                    toastMessage = "\(product.name) added to cart."
                    withAnimation {
                        showToast = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            showToast = false
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "cart.fill")
                            .foregroundColor(.black)
                        Text("Add to Cart")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.black.opacity(0.2))
                    }
                    .cornerRadius(10)
                }
                .padding(.top, 20)
                

            }
            .padding(.top, 30)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
    
    @ViewBuilder
    func CustomSeeker() -> some View{
        GeometryReader{_ in
            Rectangle()
                .trim(from: 0, to: 0.474)
                .stroke(.linearGradient(colors: [
                    .clear,
                    .clear,
                    .black.opacity(0.2),
                    .black.opacity(0.6),
                    .black,
                    .black.opacity(0.6),
                    .black.opacity(0.2),
                    .clear,
                    .clear
                ],startPoint: .leading,endPoint: .trailing),style: StrokeStyle(lineWidth: 2,lineCap: .round,lineJoin: .round, miterLimit: 1, dash: [3], dashPhase: 1))
        }
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
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

            Button {
                // Tindakan untuk tombol kedua, jika diperlukan
            } label: {
                Image(systemName: "arrow.left.and.right.righttriangle.left.righttriangle.right.fill")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
                    .background{
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.black.opacity(0.2))
                    }
            }
        }
    }


}

#Preview {
    ContentView()
}

