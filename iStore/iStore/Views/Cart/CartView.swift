//
//  CartView.swift
//  iStore
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct CartView: View {
    let products:[Product] = Product.cart
    @State private var totalPrice = 0
    @State private var isProductDetailsShown = false
    @State private var isCheckoutShown = false
    
    var background: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(products) { product in
                            CartItemView(product: product)
                                .onAppear {
                                    self.totalPrice = product.price
                                }
                                .onTapGesture { self.isProductDetailsShown.toggle() }
                                .sheet(isPresented: $isProductDetailsShown) {
                                    ItemDetailsView(product: product)
                                }
                        }
                    }
                }
                
                VStack {
                    Rectangle()
                        .fill(Color.clear)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Shipping: Free")
                                .foregroundColor(.gray)
                            HStack {
                                Text("Total: ")
                                Text("৳\(totalPrice)")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.isCheckoutShown.toggle()
                        }, label: {
                            Text("Check Out")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .shadow(radius: 2, y: 1)
                        }).sheet(isPresented: $isCheckoutShown) {
                            CheckoutView()
                        }
                    }.padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.secondary.opacity(0.1))
                }
            }.navigationTitle("Cart Items")
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
