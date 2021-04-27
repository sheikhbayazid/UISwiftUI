//
//  ContentView.swift
//  iShop
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedItem: Product!
    @State private var isActive = false
    @State private var cartItem = 0
    
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack {
                NavBarView(cartItem: $cartItem)
                
                ProductsView(selectedItem: $selectedItem, isActive: $isActive)
            }
            
            if isActive && selectedItem != nil  {
                ItemDetailsView(product: $selectedItem, isActive: $isActive, animation: animation, cartItem: $cartItem)
            }
        }.ignoresSafeArea(.all, edges: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Made changes
