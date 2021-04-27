//
//  CheckoutView.swift
//  iShop
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isTapped = false
    @State private var addressLine = ""
    @State private var city = ""
    @State private var postalCode = ""
    
    var background: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Cell:")
                                .font(.headline)
                            
                            Text("Phone: +8801710000000")
                                .font(.footnote)
                                .padding(.horizontal, 10)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(5)
                            
                        }.font(.system(size: 15, weight: .medium))
                        .padding(.bottom, 20)
                        
                        Text("Biling Address:")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            TextField("address", text: $addressLine)
                                .padding(4)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.25))
                            
                            TextField("city", text: $city)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.25))
                            
                            TextField("postal code", text: $postalCode)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.25))
                            
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        self.isTapped.toggle()
                                        
                                        if isTapped {
                                            self.addressLine = "123, ABC Avenue"
                                            self.city = "ABC"
                                            self.postalCode = "00-11-22"
                                        } else {
                                            self.addressLine = ""
                                            self.city = ""
                                            self.postalCode = ""
                                        }
                                    }
                                    
                                }, label: {
                                    Image(systemName: isTapped ? "checkmark.circle" : "circle")
                                        .font(.title3)
                                        .foregroundColor(.primary)
                                })
                                
                                Text("Use account address")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }.padding(.vertical, 10)
                            .font(.footnote)
                        }
                        
                    }.font(.system(size: 14))
                    
                    
                    VStack(alignment: .leading) {
                        Text("Order Summary:")
                            .font(.headline)
                        
                        VStack(spacing: 4) {
                            ForEach(Product.cart) { product in
                                CheckoutItemView(product: product)
                                
                            }
                        }
                    }
                    
                    Spacer()
                }.padding(.top, 20)
                .padding(.horizontal)
                
                VStack {
                    Rectangle()
                        .fill(Color.clear)
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text("Total: ")
                                    .font(.system(size: 15, weight: .regular))
                                Text("৳1,45000")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.primary)
                            }
                            
                            Text("VAT and SD included")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                        }
                        
                        Spacer()
                        
                        Button(action: { }, label: {
                            Text("Proceed to Pay")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.black)
                                .clipShape(Capsule())
                                .shadow(radius: 2, y: 1)
                        })
                    }.padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.black.opacity(0.07))
                    .cornerRadius(10)
                }.padding(.horizontal)
            }
            .navigationBarTitle("Checkout")
            .navigationBarItems(trailing: Button("Cancel") { self.presentationMode.wrappedValue.dismiss()}.foregroundColor(.primary) )
        }
    }

}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}


struct CheckoutItemView: View {
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
                
                Text("1 X")
                    .font(.system(size: 13, weight: .semibold))
                    .padding(.horizontal)
                
            }
            .frame(width: 350 , height: 46)
            .background(Color.secondary.opacity(0.075))
            .clipShape(RoundedRectangle(cornerRadius: 8))        }
    }
}
