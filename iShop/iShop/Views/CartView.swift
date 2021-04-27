//
//  CartView.swift
//  iShop
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct CartView: View {
    @Environment(\.presentationMode) var presentationMode
    fileprivate let products:[Product] = Product.cart
    
    @State private var totalPrice = 0
    @State private var isCheckoutShown = false
    
    var background: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(products) { product in
                            CartItemView(product: product)
                                .onAppear {
                                    self.totalPrice = product.price
                                }
                        }
                    }
                }.offset(y: 30)
                
                VStack {
                    Rectangle()
                        .fill(Color.clear)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Shipping: Free")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            HStack {
                                Text("Total:")
                                    .font(.system(size: 15, weight: .medium))
                                Text("৳\(totalPrice)")
                                    .font(.system(size: 18, weight: .semibold))
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.isCheckoutShown.toggle()
                        }, label: {
                            Text("Check Out")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.black)
                                .clipShape(Capsule())
                                .shadow(radius: 2, y: 1)
                        }).sheet(isPresented: $isCheckoutShown) {
                            CheckoutView()
                        }
                    }.padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                }
            }.navigationTitle("Cart items")
            .navigationBarItems(trailing: Button("Cancel") { self.presentationMode.wrappedValue.dismiss()}.foregroundColor(.primary) )
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}


struct CartItemView: View {
    fileprivate let product: Product
    @State private var numberOfItem = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40 , height: 40)
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.title)
                        .foregroundColor(.secondary)
                        .font(.system(size: 12, weight: .semibold))
                    Text("৳\(product.price)")
                        .font(.system(size: 13, weight: .semibold))
                    //.foregroundColor(.blue)
                }
                
                Spacer()
                
                HStack(spacing: 2) {
                    Button(action: {
                        if numberOfItem > 0 {
                            numberOfItem -= 1
                        }
                    }, label: {
                        Image(systemName: "minus")
                            .frame(width: 23, height: 17)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                    })
                    
                    
                    Text("\(numberOfItem)")
                        .frame(width: 25)
                    
                    Button(action: {
                        numberOfItem += 1
                    }, label: {
                        Image(systemName: "plus")
                            .frame(width: 23, height: 17)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                    })
                }.font(.system(size: 13, weight: .medium))
                .foregroundColor(.primary)
                .padding(.horizontal)
                
            }
            .frame(width: 350 , height: 46)
            .background(Color.secondary.opacity(0.075))
            .clipShape(RoundedRectangle(cornerRadius: 8))        }
    }
}
