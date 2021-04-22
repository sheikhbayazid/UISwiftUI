//
//  CarRentView.swift
//  UISwiftUI
//
//  Created by Sheikh Bayazid on 4/21/21.
//

import SwiftUI

struct iStoreView: View {
    
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
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
        }.accentColor(.primary)
    }
    
    
}



struct iStore_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            iStoreView()
            CartView()
            CheckoutView()
        }
    }
}


fileprivate struct HomeView: View {
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
                                    destination: ProductDetailsView(product: product),
                                    label: {
                                        ProductView(product: product)
                                    })
                            }
                        }.padding(.bottom, 20)
                    }.padding(.horizontal)
                }
                
            }//.navigationTitle("Home")
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    SearchView(search: $search)
                }
                
            }
            
        }
    }
}


fileprivate struct ProfileView: View {
    var background: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
    }
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1)))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                background.ignoresSafeArea()
                VStack {
                    Image("emoji")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                    //.clipShape(Circle())
                    
                    VStack(spacing: 5) {
                        Text("Sheikh Bayazid")
                            .font(.title2)
                        Text("Address: 123, ABC Avenue, ABC , 00-11-22")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    
                    
                    Form {
                        Section {
                            NavigationLink(
                                destination: Form {
                                    ForEach(1..<4) { index in
                                        HStack {
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text("Order: #\(index)")
                                                Text(Date(), style: .date)
                                                    .font(.footnote)
                                                    .foregroundColor(.gray)
                                            }
                                            
                                            Spacer()
                                            
                                            Text("Delivered")
                                                .font(.footnote)
                                                .foregroundColor(.gray)
                                        }
                                        
                                    }
                                },
                                label: {
                                    Text("Orders")
                                })
                            
                            NavigationLink(
                                destination: Form {
                                    ForEach(Product.favorites) { product in
                                        NavigationLink(
                                            destination: ProductDetailsView(product: product),
                                            label: {
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 1) {
                                                        Text(product.name)
                                                            .font(.subheadline)
                                                        
                                                        Text("৳\(product.price)")
                                                            .font(.footnote)
                                                            .foregroundColor(.gray)
                                                    }
                                                    
                                                    Spacer()
                                                    
                                                    Image(product.image)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 35, height: 35)
                                                        .foregroundColor(.primary)
                                                }
                                            })
                                        
                                    }
                                },
                                label: {
                                    Text("My Favorites")
                                })
                        }
                    }
                }
            }
            .navigationTitle("Account")
        }
    }
}



fileprivate struct SearchView: View {
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



fileprivate struct ProductView: View {
    fileprivate let product: Product
    
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



fileprivate struct ProductDetailsView: View {
    fileprivate let product: Product
    @State private var isFavorite = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 15) {
                    //MARK: - Product Image
                    Image(product.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5, y: 2.5)
                    //MARK: - Product Price and Share
                    HStack {
                        HStack(spacing: 2) {
                            Text("৳")
                            Text("\(product.price)")
                        }.font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.blue)
                        
                        Spacer()
                        
                        HStack(spacing: 10) {
                            Button(action: {
                                self.isFavorite.toggle()
                            }, label: {
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(isFavorite ? .red : .gray)
                            })
                            
                            Button(action: { }, label: {
                                Image(systemName: "square.and.arrow.up")
                            })
                            
                        }.font(.title3)
                        .foregroundColor(.gray)
                        
                    }.padding(.horizontal)
                    
                    //MARK: - Product Label
                    HStack {
                        Text(product.name)
                            .font(.system(size: 22, weight: .semibold))
                        Spacer()
                    }.padding(.horizontal)
                    
                    HStack(spacing: 5) {
                        HStack(spacing: 1) {
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            
                        }.foregroundColor(.yellow)
                        Text("Rating: 5/5")
                        Spacer()
                    }.padding(.horizontal)
                    .font(.system(size: 15, weight: .semibold))
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Product Description:")
                                .font(.headline)
                            Text(product.description)
                                .font(.system(size: 14, weight: .regular))
                        }
                        Spacer()
                    }.padding(.horizontal)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Key Features:")
                                .font(.headline)
                        }
                        Spacer()
                    }.padding(.horizontal)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Specifications:")
                                .font(.headline)
                        }
                        Spacer()
                    }.padding(.horizontal)
                    
                    
                    
                }
            }
            
            VStack {
                Rectangle()
                    .fill(Color.clear)
                
                Button(action: {}, label: {
                    Label("Add to Cart", systemImage: "cart")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                })
            }
        }
    }
}



//MARK: - CartView
fileprivate struct CartView: View {
    fileprivate let products:[Product] = Product.cart
    @State private var totalPrice = 0
    @State private var isProductDetailsShown = false
    @State private var isCheckoutShown = false
    
    var background: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(products) { product in
                            CartItemView(product: product)
                                .onAppear {
                                    self.totalPrice = product.price
                                }
                                .onTapGesture { self.isProductDetailsShown.toggle() }
                                .sheet(isPresented: $isProductDetailsShown) {
                                    ProductDetailsView(product: product)
                                }
                        }
                    }
                }
                
                VStack {
                    Rectangle()
                        .fill(Color.clear)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Shipping: Free")
                                .foregroundColor(.gray)
                            HStack {
                                Text("Total: ")
                                Text("৳\(totalPrice)")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.isCheckoutShown.toggle()
                        }, label: {
                            Text("Check Out")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .shadow(radius: 2, y: 1)
                        }).sheet(isPresented: $isCheckoutShown) {
                            CheckoutView()
                        }
                    }.padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.secondary.opacity(0.1))
                }
            }.navigationTitle("Items")
        }
    }
}



fileprivate struct CartItemView: View {
    fileprivate let product: Product
    @State private var numberOfItem = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40 , height: 40)
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.name)
                        .font(.system(size: 12, weight: .semibold))
                    Text("৳\(product.price)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                HStack(spacing: 5) {
                    Button(action: {
                        if numberOfItem > 0 {
                            numberOfItem -= 1
                        }
                    }, label: {
                        Image(systemName: "minus")
                            .padding(.horizontal, 2)
                            .padding(.vertical, 4)
                    })
                    
                    
                    Text("\(numberOfItem)")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.25))
                        .cornerRadius(5)
                    
                    Button(action: {
                        numberOfItem += 1
                    }, label: {
                        Image(systemName: "plus")
                            .padding(.horizontal, 2)
                            .padding(.vertical, 4)
                    })
                }.font(.system(size: 14, weight: .regular))
                .foregroundColor(.primary)
                .padding(.horizontal)
                
            }
            .frame(width: 350 , height: 45)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 5))        }
    }
}

fileprivate struct CheckoutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isTapped = false
    @State private var addressLine = ""
    @State private var city = ""
    @State private var postalCode = ""
    
    var background: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                background.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Biling Address:")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            TextField("Address", text: $addressLine)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
                            
                            TextField("City", text: $city)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
                            
                            TextField("Postal Code", text: $postalCode)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
                            
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        self.isTapped.toggle()
                                        
                                        if isTapped {
                                            self.addressLine = "123, ABC Avenue"
                                            self.city = "ABC"
                                            self.postalCode = "00-11-22"
                                        } else {
                                            self.addressLine = ""
                                            self.city = ""
                                            self.postalCode = ""
                                        }
                                    }
                                    
                                }, label: {
                                    Image(systemName: isTapped ? "checkmark.circle" : "circle")
                                        .font(.title3)
                                        .foregroundColor(.primary)
                                })
                                
                                Text("Account Address")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                            }.padding(.vertical, 10)
                            .font(.footnote)
                        }
                        
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Contact:")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Phone: +8801710000000")
                            Text("Email: johnappleseed@apple.com")
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Summary:")
                            .font(.headline)
                        
                        VStack(spacing: 4) {
                            ForEach(Product.cart) { product in
                                CartItemView(product: product)
                                
                            }
                        }
                    }
                    
                    Spacer()
                }.padding(.top, 20)
                .padding(.horizontal)
                
                VStack {
                    Rectangle()
                        .fill(Color.clear)
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text("Total: ")
                                Text("৳ 1,45000")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.blue)
                            }
                            
                            Text("VAT and SD included")
                                .font(.footnote)
                                .foregroundColor(.gray)
                           
                        }
                        
                        Spacer()
                        
                        Button(action: { }, label: {
                            Text("Proceed to Pay")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .shadow(radius: 2, y: 1)
                        })
                    }.padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.pink.opacity(0.05))
                    .cornerRadius(10)
                }.padding(.horizontal)
            }
            .navigationBarTitle("Checkout")
            .navigationBarItems(trailing: Button("Cancel") { self.presentationMode.wrappedValue.dismiss()}.foregroundColor(.primary) )
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
