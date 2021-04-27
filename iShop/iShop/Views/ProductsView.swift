//
//  ProductsView.swift
//  iShop
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct ProductsView: View {
    @State private var selectedTab = scrollTabs[0]
    @Binding var selectedItem: Product!
    @Namespace var animation
    @Binding var isActive: Bool
    
    let products = Product.example
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                HStack {
                    Text("Recent")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }.padding()
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(scrollTabs, id: \.self) { tab in
                            TabButtonView(selectedTab: $selectedTab, title: tab, animation: animation)
                        }
                    }.padding(.horizontal)
                }
                
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(products) { product in
                            ItemView(product: product)
                                .onTapGesture {
                                    //withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                    self.selectedItem = product
                                    self.isActive.toggle()
                                    //}
                                }
                        }
                    }.padding(.horizontal)
                    
                }
            }
        }
    }
}


struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(selectedItem: .constant(Product.example[0]), isActive: .constant(false))
    }
}
