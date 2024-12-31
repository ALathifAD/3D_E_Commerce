//
//  ItemView.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//

import SwiftUI

struct ItemView: View {
    @Binding var item: CartItem
    @Binding var items: [CartItem]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [Color("lightblue"), Color("blue")]), startPoint: .leading, endPoint: .trailing)
            
            HStack {
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn) { deleteItem() }
                }) {
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 90, height: 50)
                }
            }
            
            HStack(spacing: 15) {
                Image(item.product.ImgProduct)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 130)
                    .cornerRadius(15)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.product.name)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text(item.product.description)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                    
                    HStack(spacing: 15) {
                        Text("Rp\(item.product.price)")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {
                            if item.quantity > 1 { item.quantity -= 1 }
                        }) {
                            Image(systemName: "minus")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(.black)
                        }
                        
                        Text("\(item.quantity)")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.black.opacity(0.06))
                        
                        Button(action: { item.quantity += 1 }) {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .padding()
            .background(Color("gray"))
            .contentShape(Rectangle())
            .offset(x: item.offset)
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width < 0 {
            if item.isSwiped {
                item.offset = value.translation.width - 90
            } else {
                item.offset = value.translation.width
            }
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            if value.translation.width < 0 {
                if -value.translation.width > UIScreen.main.bounds.width / 2 {
                    item.offset = -1000
                    deleteItem()
                } else if -item.offset > 50 {
                    item.isSwiped = true
                    item.offset = -90
                } else {
                    item.isSwiped = false
                    item.offset = 0
                }
            } else {
                item.isSwiped = false
                item.offset = 0
            }
        }
    }
    
    func deleteItem() {
        // Tidak perlu `guard let` karena `item.id` sudah bertipe String
        let itemID = item.id

        let firestoreManager = FirestoreManager()
        
        // Hapus dari array lokal
        items.removeAll { $0.id == itemID }
        
        // Hapus dari Firebase
        firestoreManager.deleteCartItem(itemID: itemID) { error in
            if let error = error {
                print("Error deleting item from Firebase: \(error.localizedDescription)")
            } else {
                print("Item deleted successfully from Firebase.")
            }
        }
    }

    
//    func deleteItem() {
//        guard let itemID = item.id else {
//            print("Error: Item ID is nil.")
//            return
//        }
//        
//        let firestoreManager = FirestoreManager()
//        
//        // Hapus dari array lokal
//        items.removeAll { $0.id == item.id }
//        
//        // Hapus dari Firebase
//        firestoreManager.deleteCartItem(itemID: itemID) { result in
//            switch result {
//            case .success:
//                print("Item deleted successfully from Firebase.")
//            case .failure(let error):
//                print("Error deleting item from Firebase: \(error.localizedDescription)")
//            }
//        }
//    }

    
//    func deleteItem() {
//        items.removeAll { $0.id == item.id }
//    }
}
