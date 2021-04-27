//
//  ProductsItemView.swift
//  iStore
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct ItemView: View {
    let product: Product
    
    var body: some View {
        ZStack {
            AvailableView(availability: product.dayAndWeek)
            
            ProductImageView(image: product.image)
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Spacer()
                    
                    Text(product.name)
                        .font(.system(size: 11))
                    HStack(spacing: 1) {
                        Text("৳")
                            .font(.system(size: 14, weight: .medium))
                        Text("\(product.price)")
                            .font(.system(size: 15, weight: .bold))
                    }
                    
                    Text(product.estimateShipping)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }.padding(.leading, 20)
                
                Spacer()
                
            }.padding(.bottom, 10)
            
        }.frame(width: 170, height: 180)
        .foregroundColor(.primary)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color(#colorLiteral(red: 0.8526860873, green: 0.8895145654, blue: 1, alpha: 0.45)),radius: 4, y: 2)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(product: Product.example[0])
    }
}


fileprivate struct AvailableView: View {
    let availability: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack(spacing: 2) {
                    Image(systemName: "calendar")
                    Text(availability)
                }
                .font(.system(size: 10))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color(#colorLiteral(red: 0.8526860873, green: 0.8895145654, blue: 1, alpha: 0.15)))
                .cornerRadius(25)
                .padding(.trailing, 8)
            }.padding(.top, 8)
            
            Spacer()
        }
    }
}

fileprivate struct ProductImageView: View {
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .shadow(radius: 2, y: 1)
            .frame(width: 110, height: 110)
            .offset(y: -25)
    }
}
