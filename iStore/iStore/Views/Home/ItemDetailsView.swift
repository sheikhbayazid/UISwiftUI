//
//  ProductDetailsView.swift
//  iStore
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct ItemDetailsView: View {
    let product: Product
    @State private var isFavorite = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 15) {
                    //MARK: - Product Image
                    Image(product.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5, y: 2.5)
                    //MARK: - Product Price and Share
                    HStack {
                        HStack(spacing: 2) {
                            Text("৳")
                            Text("\(product.price)")
                        }.font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.blue)
                        
                        Spacer()
                        
                        HStack(spacing: 10) {
                            Button(action: {
                                self.isFavorite.toggle()
                            }, label: {
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(isFavorite ? .red : .gray)
                            })
                            
                            Button(action: { }, label: {
                                Image(systemName: "square.and.arrow.up")
                            })
                            
                        }.font(.title3)
                        .foregroundColor(.gray)
                        
                    }.padding(.horizontal)
                    
                    //MARK: - Product Label
                    HStack {
                        Text(product.name)
                            .font(.system(size: 22, weight: .semibold))
                        Spacer()
                    }.padding(.horizontal)
                    
                    HStack(spacing: 5) {
                        HStack(spacing: 1) {
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            
                        }.foregroundColor(.yellow)
                        Text("Rating: 5/5")
                        Spacer()
                    }.padding(.horizontal)
                    .font(.system(size: 15, weight: .semibold))
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Product Description:")
                                .font(.headline)
                            Text(product.description)
                                .font(.system(size: 14, weight: .regular))
                        }
                        Spacer()
                    }.padding(.horizontal)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Key Features:")
                                .font(.headline)
                        }
                        Spacer()
                    }.padding(.horizontal)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Specifications:")
                                .font(.headline)
                        }
                        Spacer()
                    }.padding(.horizontal)
                    
                    
                    
                }
            }
            
            VStack {
                Rectangle()
                    .fill(Color.clear)
                
                Button(action: {}, label: {
                    Label("Add to Cart", systemImage: "cart")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                })
            }
        }
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailsView(product: Product.example[0])
    }
}
