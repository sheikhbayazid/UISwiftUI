//
//  iShopView.swift
//  UISwiftUI
//
//  Created by Sheikh Bayazid on 4/23/21.
//

import SwiftUI

struct iShopView: View {
    @State private var selectedItem: Product!
    @State private var isActive = false
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                
                ProductView(selectedItem: $selectedItem, isActive: $isActive)
            }
            
            if isActive && selectedItem != nil  {
                ItemDetailsView(product: $selectedItem, isActive: $isActive)
            }
        }.ignoresSafeArea(.all, edges: .top)
    }
}

struct iShopView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            iShopView()
            ItemDetailsView(product: .constant(Product.example[1]), isActive: .constant(false))
        }
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
    @Binding var selectedItem: Product!
    @Namespace var animation
    @Binding var isActive: Bool
    
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
                
                AllProductsView(selectedItem: $selectedItem, isActive: $isActive)
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
    @Binding var selectedItem: Product!
    @Binding var isActive: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(products) { product in
                    ItemView(product: product)
                        .onTapGesture {
                            //withAnimation(.spring()) {
                            self.selectedItem = product
                            self.isActive.toggle()
                            //}
                        }
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


fileprivate struct ItemDetailsView: View {
    @Binding var product: Product!
    @Binding var isActive: Bool
    //var animation: Namespace.ID
    @State private var color = Color.green
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            VStack(alignment: .leading, spacing: 5) {
                VStack(alignment: .leading, spacing: 5) {
                    //MARK: - Navigation Bar
                    HStack {
                        Button(action: {
                            self.isActive.toggle()
                        }, label: {
                            Image(systemName: "chevron.left")
                        })
                        
                        
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image(systemName: "cart")
                        })
                    }
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
                    .padding()
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    
                    //MARK: - HeaderView
                    VStack(alignment: .leading, spacing: 5) {
                        Text(product.name)
                            .fontWeight(.semibold)
                            .padding(.top )
                        
                        Text(product.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    
                    
                    //MARK: - ImageView and Price
                    HStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Price")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            Text("$\(product.price)")
                                .fontWeight(.heavy)
                                .foregroundColor(.primary)
                        }
                        
                        Image(product.image)
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 6, y: 3)
                            .frame(width: 220, height: 220)
                        //.matchedGeometryEffect(id: product.image, in: animation)
                    }.padding(.horizontal)
                    .padding(.top)
                    
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Color")
                                        .foregroundColor(.gray)
                                    
                                    HStack(spacing: 10) {
                                        ColorButton(color: Color.green, selectedColor: $color)
                                        ColorButton(color: Color.yellow, selectedColor: $color)
                                        ColorButton(color: Color.purple, selectedColor: $color)
                                    }
                                }
                                
                                Spacer()
                                
                                VStack(spacing: 8) {
                                    Text("Size")
                                        .foregroundColor(.gray)
                                    
                                    
                                    Text("12cm")
                                        .fontWeight(.semibold)
                                }
                            }
                            
                            Text(product.description)
                                .font(.callout)
                                .foregroundColor(.gray)
                                .padding(.top)
                            
                            HStack {
                                HStack(spacing: 15) {
                                    Image(systemName: "minus")
                                        .frame(width: 30, height: 20)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                                    
                                     Text("2")
                                    
                                    Image(systemName: "plus")
                                        .frame(width: 30, height: 20)
                                        .overlay(RoundedRectangle(cornerRadius: 2).stroke(lineWidth: 1))
                                    
                                }
                                
                                Spacer()
                                
                                Circle().fill(Color.red).frame(width: 35, height: 35)
                                    .overlay(Image(systemName: "heart.fill").foregroundColor(Color.white))
                                
                                
                            }.padding(.top)
                            .font(.title3)
                            .foregroundColor(Color.black.opacity(0.75))
                        }.padding(.horizontal)
                        .padding(.top, 20)
                        
                        Button(action: {}, label: {
                            Text("BUY NOW")
                                .foregroundColor(.white)
                        }).frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .padding([.horizontal, .top])
                        
                        
                        Spacer()
                    }///.frame(height: UIScreen.main.bounds.size.height / 1.5)
                    .background(Color.pink.opacity(0.05).padding(.top, -100))
                    .cornerRadius(30)
                    .padding([.top, .bottom], 20)
                    
                }
            }
            
            //Spacer()
            
        }//.padding(.horizontal)
        .frame(height: UIScreen.main.bounds.size.height)
        .ignoresSafeArea(.all, edges: .all)
        .background(Color.white)
    }
}


struct ColorButton: View {
    var color: Color
    @Binding var selectedColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
            
            Circle()
                .stroke(Color.black.opacity(selectedColor == color ? 1: 0))
                .frame(width: 25, height: 25)
        }.onTapGesture {
            withAnimation {
                selectedColor = color
            }
        }
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
