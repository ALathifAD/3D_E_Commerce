//
//  BaseViewModel.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//

import Foundation

import SwiftUI

class BaseViewModel: ObservableObject {
    // MARK: - TAB BAR
    @Published var currentTab: Tab = .Home
    
    @Published var homeTab = "Facewash"
    @Published var showCart: Bool = false
    
    // MARK: - DETAIL VIEW
    @Published var currentProduct: Product?
    @Published var showDetail = false
}

// MARK: - TAB ITEM CASE
enum Tab: String {
    case Home = "home"
    case Heart = "heart"
    case ClipBoard = "clipboard"
    case Person = "person"
}
