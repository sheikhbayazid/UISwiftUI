//
//  SearchView.swift
//  iStore
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct SearchView: View {
    @Binding var search: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                
                TextField("Search", text: $search, onCommit: searchItem)
                
            }
            
            Button(action: {}, label: {
                Image(systemName: "qrcode.viewfinder")
                    .font(.title3)
                    .foregroundColor(.primary)
            })
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .frame(width: UIScreen.main.bounds.size.width - 40)
        .background(Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)))
        .cornerRadius(25)
        .padding(.horizontal)
        
    }
    
    
    func searchItem() {
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(search: .constant(""))
    }
}
