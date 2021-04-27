//
//  CartItemView.swift
//  iStore
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct CartItemView: View {
    let product: Product
    @State private var numberOfItem = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40 , height: 40)
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.name)
                        .font(.system(size: 12, weight: .semibold))
                    Text("৳\(product.price)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                HStack(spacing: 5) {
                    Button(action: {
                        if numberOfItem > 0 {
                            numberOfItem -= 1
                        }
                    }, label: {
                        Image(systemName: "minus")
                            .padding(.horizontal, 2)
                            .padding(.vertical, 4)
                    })
                    
                    
                    Text("\(numberOfItem)")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.25))
                        .cornerRadius(5)
                    
                    Button(action: {
                        numberOfItem += 1
                    }, label: {
                        Image(systemName: "plus")
                            .padding(.horizontal, 2)
                            .padding(.vertical, 4)
                    })
                }.font(.system(size: 14, weight: .regular))
                .foregroundColor(.primary)
                .padding(.horizontal)
                
            }
            .frame(width: 350 , height: 45)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 5))        }
    }
}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView(product: Product.example[0])
    }
}
