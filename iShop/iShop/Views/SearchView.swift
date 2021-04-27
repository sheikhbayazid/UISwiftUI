//
//  SearchView.swift
//  iShop
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct SearchView: View {
    @State private var search = ""
    @Binding var isSearchShown: Bool
    
    var body: some View {
        HStack {
            HStack {
                Button(action: { isSearchShown.toggle() }, label: {
                    Image(systemName: "magnifyingglass")
                })
                
                TextField("Search", text: $search, onCommit: searchItem)
                
            }
            
            Button(action: { isSearchShown.toggle() }, label: {
                Image(systemName: "qrcode.viewfinder")
                    
            })
        }
        .font(.title3)
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Color.white)
        .cornerRadius(10)
        
        
        
    }
    
    func searchItem() {
        self.isSearchShown.toggle()
    }
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isSearchShown: .constant(false))
    }
}
