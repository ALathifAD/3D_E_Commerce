//
//  Product.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//


import Foundation
import FirebaseFirestore

struct Product: Identifiable, Codable {
    /*@DocumentID */var id: String?
    let name: String
    let ImgProduct: String
    let price: String
    let description: String
    var rating: Double
    let scnFileName: String
}




//// Update Product struct to conform to Codable and support Firestore
//struct Product: Identifiable, Codable {
//    @DocumentID var id: String?
//    let name: String
//    let imgProduct: String
//    let price: String
//    let description: String
//    let rating: Double
//    let scnFileName: String
//    
//    // Custom CodingKeys to match Firestore field names
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case imgProduct
//        case price
//        case description
//        case rating
//        case scnFileName
//    }
//}
//
//




//import Foundation
//
//
//struct Product: Identifiable {
//    let id: UUID
//    let name: String
//    let ImgProduct: String
//    let price: String
//    let description: String
//    let rating: Double
//    let scnFileName: String
//}
//
//let products = [
//    Product(id: UUID(uuidString: "76aebb0c-0b78-4d78-9e70-1a39f2c38af9")!, name: "Adjust Table", ImgProduct: "adjust_table_IMG", price: "400", description: "A modern adjustable table.", rating: 4.5, scnFileName: "adjust_table.scn"),
//    Product(id: UUID(uuidString: "f5d9c3ea-10c4-4e48-a7d9-bd920e4ed7b8")!, name: "Saber Lily - Distant Avalon Figure", ImgProduct: "Fate_IMG", price: "1800", description: "A beautiful Saber Lily collectible figure.", rating: 5.0, scnFileName: "Saber_Lily_-_Distant_Avalon_Figure.scn"),
//    Product(id: UUID(uuidString: "e12b6f4d-1c88-414e-83d9-4dc63724aaf3")!, name: "Anime Girl Tech Priest", ImgProduct: "anime_girl_IMG", price: "1200", description: "A collectible figurine.", rating: 5.0, scnFileName: "anime_girl_tech_priest_umm_warhammer_40000.scn"),
//    Product(id: UUID(uuidString: "b7c946de-2c78-4231-b598-3013e9301735")!, name: "Vintage Chair", ImgProduct: "bovenkamp_vintage_chair_1950s_IMG", price: "850", description: "A vintage chair from the 1950s.", rating: 4.7, scnFileName: "bovenkamp_vintage_chair_1950s.scn"),
//    Product(id: UUID(uuidString: "e4a9cce6-89c5-4a9e-a6f2-c5ec6dcbdfb8")!, name: "Desk", ImgProduct: "deskop_or_IMG", price: "600", description: "A sleek and modern desk.", rating: 4.2, scnFileName: "deskop_or.scn"),
//    Product(id: UUID(uuidString: "d1f3ed5e-74b6-42be-a5d1-588dc7a5cb4e")!, name: "Eat Table", ImgProduct: "eat_table_IMG", price: "500", description: "A durable and stylish dining table.", rating: 4.3, scnFileName: "eat_table.scn"),
//    Product(id: UUID(uuidString: "c85b6a02-99ec-47b5-b1b3-1d64077d9af6")!, name: "Figure", ImgProduct: "figure1_IMG", price: "300", description: "An abstract decorative figure.", rating: 4.0, scnFileName: "figure1.scn"),
//    Product(id: UUID(uuidString: "ef98badd-e7b3-46db-b41a-dc8ed7743bde")!, name: "Glass Table", ImgProduct: "glass_table_IMG", price: "750", description: "A modern glass table.", rating: 4.6, scnFileName: "glass_table.scn"),
//    Product(id: UUID(uuidString: "a3b2c148-6e88-426d-9c90-8e3329cdd0a5")!, name: "Hand Carved Wood Statue", ImgProduct: "hand_carved_wood_statue_IMG", price: "900", description: "A detailed hand-carved wood statue.", rating: 4.8, scnFileName: "hand_carved_wood_statue_fbx.scn"),
//    Product(id: UUID(uuidString: "d824c72c-d716-476d-b705-c8b80bb3af7e")!, name: "Hourglass", ImgProduct: "hourglass_IMG", price: "150", description: "A classic hourglass for decoration.", rating: 4.1, scnFileName: "hourglass.scn"),
//    Product(id: UUID(uuidString: "90b645f4-c816-4dbd-8b62-d2383475dc2f")!, name: "Modern Chair", ImgProduct: "modern_chair_IMG", price: "650", description: "A stylish modern chair.", rating: 4.4, scnFileName: "modern_chair.scn"),
//    Product(id: UUID(uuidString: "a69c19c7-7c4e-4198-bb34-bf620b88282d")!, name: "School Chair", ImgProduct: "school_chair_IMG", price: "200", description: "A comfortable school chair.", rating: 4.0, scnFileName: "school_chair.scn"),
//    Product(id: UUID(uuidString: "33f36a71-6a02-4d3a-bf29-dc98eaf0c3fa")!, name: "School Table", ImgProduct: "school_table_IMG", price: "350", description: "A durable school table.", rating: 4.2, scnFileName: "school_table.scn"),
//    Product(id: UUID(uuidString: "76a12590-8f64-4b9f-a9e2-fc5b279c5c44")!, name: "Sense and Teapot", ImgProduct: "sense_and_teapot_sousou_no_frieren_IMG", price: "300", description: "A decorative teapot.", rating: 4.5, scnFileName: "sense_and_teapot_sousou_no_frieren.scn"),
//    Product(id: UUID(uuidString: "c46fba35-0dbb-4c1b-8f6b-b1e177c799d2")!, name: "Small Clock", ImgProduct: "sm_clock_IMG", price: "100", description: "A compact decorative clock.", rating: 3.9, scnFileName: "sm_clock.scn"),
//    Product(id: UUID(uuidString: "b97d62ff-56d7-4b17-859f-cb158e4a5095")!, name: "Smiling Cat Figurine", ImgProduct: "smiling_cat_figurine_free_3d_IMG", price: "120", description: "A cute smiling cat figurine.", rating: 4.7, scnFileName: "smiling_cat_figurine_free_3d_download.scn"),
//    Product(id: UUID(uuidString: "2f65462c-12c3-42af-925b-1f948a5b6bcf")!, name: "Standard Chair", ImgProduct: "standart_chair_IMG", price: "300", description: "A classic standard chair.", rating: 4.3, scnFileName: "standart_chair.scn"),
//    Product(id: UUID(uuidString: "8a65f33f-c70f-47b7-80b1-46a9d9f71c96")!, name: "Swivel Chair", ImgProduct: "swivel_chair._IMG", price: "700", description: "A comfortable swivel chair.", rating: 4.6, scnFileName: "swivel_chair.scn"),
//    Product(id: UUID(uuidString: "b6af7e58-517e-452f-8472-d51cc54f6317")!, name: "Mimikyu Pokémon Figure", ImgProduct: "pokemon_IMG", price: "500", description: "A cute Mimikyu Pokémon collectible.", rating: 4.8, scnFileName: "Mimikyu_Pokemon.scn"),
//    Product(id: UUID(uuidString: "bb28c6cf-b328-41b2-b2a2-c6b95e7fae94")!, name: "Wooden Chair", ImgProduct: "wooden_chair_IMG", price: "550", description: "A durable wooden chair.", rating: 4.5, scnFileName: "wooden_chair.scn")
//]
