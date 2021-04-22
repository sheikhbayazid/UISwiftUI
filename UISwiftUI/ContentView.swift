//
//  ContentView.swift
//  UISwiftUI
//
//  Created by Sheikh Bayazid on 4/21/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            iStoreView()
                .tabItem {
                    Image(systemName: "house")
                        Text("Home")
                }
            
            CartView()
                .tabItem {
                    Image(systemName: "cart")
                        Text("Cart")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                        Text("Account")
                }
        }.accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
