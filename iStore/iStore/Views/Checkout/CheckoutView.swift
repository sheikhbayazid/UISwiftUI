//
//  CheckoutView.swift
//  iStore
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
                background.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Biling Address:")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            TextField("Address", text: $addressLine)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
                            
                            TextField("City", text: $city)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
                            
                            TextField("Postal Code", text: $postalCode)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
                            
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
                                
                                Text("Account Address")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                            }.padding(.vertical, 10)
                            .font(.footnote)
                        }
                        
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Contact:")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Phone: +8801710000000")
                            Text("Email: johnappleseed@apple.com")
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Summary:")
                            .font(.headline)
                        
                        VStack(spacing: 4) {
                            ForEach(Product.cart) { product in
                                CartItemView(product: product)
                                
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
                                Text("৳ 1,45000")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.blue)
                            }
                            
                            Text("VAT and SD included")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                        }
                        
                        Spacer()
                        
                        Button(action: { }, label: {
                            Text("Proceed to Pay")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .shadow(radius: 2, y: 1)
                        })
                    }.padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.pink.opacity(0.05))
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
