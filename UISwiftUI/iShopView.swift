//
//  iShopView.swift
//  UISwiftUI
//
//  Created by Sheikh Bayazid on 4/23/21.
//

import SwiftUI

struct iShopView: View {
    
    
    var body: some View {
        VStack {
            HeaderView()
            
            ProductView()
        }.ignoresSafeArea(.all, edges: .top)
    }
}

struct iShopView_Previews: PreviewProvider {
    static var previews: some View {
        iShopView()
    }
}

//MARK: - HeaderView
struct HeaderView: View {
    var body: some View {
        ZStack {
            HStack(spacing: 15) {
                Button(action: {}, label: {
                    Image(systemName: "line.horizontal.3.decrease")
                })
                
                Spacer(minLength: 0)
                
                HStack(spacing: 15) {
                    Button(action: {}, label: {
                        Image(systemName: "magnifyingglass")
                    })
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        Button(action: {}, label: {
                            Image(systemName: "cart")
                        })
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 15, height: 15)
                            .offset(x: 5, y: -5)
                    }
                }
            }
            
            Text("iShop")
                .font(.system(size: 26, weight: .medium))
            
        }.font(.system(size: 24, weight: .medium))
        .foregroundColor(.primary)
        .padding()
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        //.background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2.5)
    }
    
    
}


//MARK: - TabButtonView

fileprivate struct TabButtonView: View {
    @Binding var selectedTab: String
    var title: String
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = title
            }
        }, label: {
            VStack(alignment: .center) {
                Text(title)
                    .font(.system(size: selectedTab == title ? 14 : 11))
                    .fontWeight(.bold)
                    .foregroundColor(selectedTab == title ? .primary : .secondary)
                
                
                ZStack {
                    Capsule()
                        .fill(Color.clear)
                        .frame(width: 35, height: 4)
                    if selectedTab == title {
                        Capsule()
                            .fill(Color.primary)
                            .frame(width: 35, height: 4)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
                
            }.padding(.horizontal, 5)
        })
    }
}


//MARK: - ProductView
fileprivate struct ProductView: View {
    @State private var selectedTab = scrollTabs[0]
    @Namespace var animation
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                HStack {
                    Text("Recent")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }.padding()
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(scrollTabs, id: \.self) { tab in
                            TabButtonView(selectedTab: $selectedTab, title: tab, animation: animation)
                        }
                    }.padding(.horizontal)
                }
                
                AllProductsView()
            }
        }
    }
}


//MARK: - ProductCellView
fileprivate struct AllProductsView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let products = Product.example
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(products) { product in
                    ItemView(product: product)
                }
            }.padding(.horizontal)
            
        }
    }
}


fileprivate struct ItemView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Color(product.image)
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(product.name)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
                
                Text("৳\(product.price)")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding(.bottom, 10)
            }.padding(.horizontal)
            
        }.frame(width: 170, height: 160)
        
        .background(Color.purple.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

//MARK: - Model
fileprivate struct Product: Identifiable {
    let id = UUID()
    let image: String
    let name: String
    let price: Int
    let estimateShipping: String
    let dayAndWeek: String
    let description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse nec quam commodo, consectetur felis id, lobortis massa. Donec efficitur nisi id feugiat porta. Morbi luctus viverra semper. Duis sed mi in dolor molestie maximus ut eget lacus. Maecenas dapibus eu sapien et dignissim. Maecenas rutrum mi in interdum consectetur. Nullam vestibulum nunc diam, vitae auctor sapien ultricies eget. Morbi viverra luctus lorem, vitae suscipit mauris rhoncus vel."
    let type = "Technology"
    
    static let example: [Product] = [
        Product(image: "ipad-pro-21", name: "M1 iPad Pro", price: 1_10000, estimateShipping: "This Week", dayAndWeek: "W"),
        Product(image: "imac-21", name: "M1 iMac", price: 1_45000, estimateShipping: "This Week", dayAndWeek: "W"),
        Product(image: "airtag", name: "Airtags", price: 3_000, estimateShipping: "Today", dayAndWeek: "D,W"),
        Product(image: "iphone-12", name: "iPhone 12 Purple", price: 1_10000, estimateShipping: "Tomorrow", dayAndWeek: "D"),
        Product(image: "yeezy-500", name: "Yeezy Boost 500", price: 27_000, estimateShipping: "Today", dayAndWeek: "D"),
        Product(image: "bmw", name: "BMW i8", price: 50_00000, estimateShipping: "Next Week", dayAndWeek: "W"),
        Product(image: "ps5", name: "PS5", price: 6_0000, estimateShipping: "Today", dayAndWeek: "D"),
        Product(image: "canon5d", name: "Canon EOS 5D Mark IV", price: 1_20000, estimateShipping: "Tomorrow", dayAndWeek: "W"),
        Product(image: "apple-watch-6", name: "Apple Watch Series 6", price: 4_5000, estimateShipping: "Today", dayAndWeek: "D,W"),
        Product(image: "vespa-2", name: "Vespa 2", price: 1_55000, estimateShipping: "Next Week", dayAndWeek: "W")
    ]
    
    static let favorites: [Product] = [
        Product(image: "iphone-12", name: "iPhone 12 Pro Max", price: 1_10000, estimateShipping: "Today", dayAndWeek: "D"),
        Product(image: "imac-21", name: "M1 iMac", price: 1_45000, estimateShipping: "This Week", dayAndWeek: "W"),
        Product(image: "airtag", name: "Airtags", price: 3_000, estimateShipping: "Today", dayAndWeek: "D,W")
    ]
    
    static let cart: [Product] = [
        Product(image: "imac-21", name: "M1 iMac", price: 1_45000, estimateShipping: "This Week", dayAndWeek: "W"),
        Product(image: "airtag", name: "Airtags", price: 3_000, estimateShipping: "Today", dayAndWeek: "D,W"),
        Product(image: "iphone-12", name: "iPhone 12 Purple", price: 1_10000, estimateShipping: "Today", dayAndWeek: "D")
    ]
}

fileprivate var scrollTabs = ["All ", "Computer", "Smartphone", "Footwear", "Backpack", "Clothing"]