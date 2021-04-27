//
//  ItemView.swift
//  iShop
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct ItemView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Color(product.image)
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(y: 5)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(product.title)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
                
                Text("৳\(product.price)")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }.frame(height: 45, alignment: .center)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.horizontal)
            .background(Color.white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
        }.frame(width: 160, height: 160)
        .background(product.color)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(product: Product.example[0])
    }
}
