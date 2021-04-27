//
//  HomeView.swift
//  iStore
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct HomeView: View {
    @State private var search = ""
    @State private var isProfileShown = false
    @State private var isFavorite = false
    
    var background: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
    }
    
    private let columns = [
        GridItem(.flexible() ),
        GridItem(.flexible() )
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                background.ignoresSafeArea()
                
                VStack(spacing: 10) {
                    QuickSearchView()
                    
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(Product.example) { product in
                                NavigationLink(
                                    destination: ItemDetailsView(product: product),
                                    label: {
                                        ItemView(product: product)
                                    })
                            }
                        }.padding(.bottom, 20)
                    }.padding(.horizontal)
                }
                
            }.navigationTitle("Recent")
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    SearchView(search: $search)
                }
                
            }
            
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



fileprivate struct QuickSearchView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                QuickSearchItemView(emoji: "📣", title: "Popular")
                QuickSearchItemView(emoji: "🔥", title: "Top Rated")
                QuickSearchItemView(emoji: "📱", title: "Phone")
                QuickSearchItemView(emoji: "👟", title: "Sneakers")
                QuickSearchItemView(emoji: "🚙", title: "Cars")
                QuickSearchItemView(emoji: "⌚️", title: "Accessories")
            }.padding(.horizontal)
        }
    }
}




fileprivate struct QuickSearchItemView: View {
    @State private var isTapped = false
    
    let emoji: String
    let title: String
    
    var body: some View {
        HStack(spacing: 2) {
            Text(emoji)
            
            Text(title)
            
            if isTapped {
                Image(systemName: "chevron.right")
            }
            
        }.font(.system(size: isTapped ? 13: 12, weight: .medium))
        .foregroundColor(isTapped ? .white: .black).padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(isTapped ? Color(#colorLiteral(red: 0.1254615486, green: 0.0728232339, blue: 0.2126503289, alpha: 1)) : Color.clear)
        .cornerRadius(40)
        .onTapGesture {
            isTapped.toggle()
        }
    }
}
