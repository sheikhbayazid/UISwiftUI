//
//  ProfileView.swift
//  iStore
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct AccountView: View {
    var background: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                background.ignoresSafeArea()
                
                VStack {
                    Image("animoji")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                    
                    VStack(spacing: 5) {
                        Text("highonswiftui")
                            .font(.title2)
                        Text("Address: 123, ABC Avenue, ABC , 00-11-22")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    
                    
                    Form {
                        Section {
                            NavigationLink(
                                destination: Form {
                                    ForEach(1..<4) { index in
                                        HStack {
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text("Order: #\(index)")
                                                Text(Date(), style: .date)
                                                    .font(.footnote)
                                                    .foregroundColor(.gray)
                                            }
                                            Spacer()
                                            
                                            Text("Delivered")
                                                .font(.footnote)
                                                .foregroundColor(.gray)
                                        }
                                        
                                    }
                                },
                                label: {
                                    Text("Orders")
                                }
                            )
                            
                            NavigationLink(
                                destination: Form {
                                    ForEach(Product.favorites) { product in
                                        NavigationLink(
                                            destination: ItemDetailsView(product: product),
                                            label: {
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 1) {
                                                        Text(product.name)
                                                            .font(.subheadline)
                                                        
                                                        Text("৳\(product.price)")
                                                            .font(.footnote)
                                                            .foregroundColor(.gray)
                                                    }
                                                    Spacer()
                                                    
                                                    Image(product.image)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 35, height: 35)
                                                        .foregroundColor(.primary)
                                                }
                                            }
                                        )
                                        
                                    }
                                },
                                label: {
                                    Text("My Favorites")
                                })
                        }
                    }
                }
            }
            .navigationTitle("Account")
        }
    }
}


struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
