//
//  NavBarView.swift
//  iShop
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct NavBarView: View {
    @Binding var cartItem: Int
    
    @State private var isCartShown = false
    @State private var isSearchShown = false
    
    var body: some View {
        ZStack {
            HStack(spacing: 15) {
                Button(action: {}, label: {
                    Image(systemName: "line.horizontal.3")
                })
                
                Spacer(minLength: 0)
                
                HStack(spacing: 15) {
                    Button(action: { self.isSearchShown.toggle() }, label: {
                        Image(systemName: "magnifyingglass")
                    })
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        Button(action: { self.isCartShown.toggle() }, label: {
                            Image(systemName: "cart")
                        })
                        .sheet(isPresented: $isCartShown) {
                            CartView()
                        }
                        
                        if cartItem > 0 {
                            ZStack {
                                Circle()
                                    .fill(Color.red)
                                Text("\(cartItem)")
                                    .font(.footnote)
                                    //.fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 18, height: 18)
                            .offset(x: 5, y: -5)
                        }
                    }
                }
            }
            
            Text("highonswiftui")
                .font(.system(size: 26, weight: .medium))
            
            if isSearchShown {
                SearchView(isSearchShown: $isSearchShown)
            }
            
        }.font(.system(size: 24, weight: .medium))
        .foregroundColor(.primary)
        .padding()
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        //.background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView(cartItem: .constant(1))
    }
}
