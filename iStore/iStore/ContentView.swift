//
//  ContentView.swift
//  iStore
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1)))
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
            
            AccountView()
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
