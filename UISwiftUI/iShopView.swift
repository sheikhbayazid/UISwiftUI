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
    @State private var count = 0
    @State private var cartItem = 0
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView(count: $count, cartItem: $cartItem)
                
                ProductView(selectedItem: $selectedItem, isActive: $isActive)
            }
            
            if isActive && selectedItem != nil  {
                ItemDetailsView(product: $selectedItem, isActive: $isActive, count: $count, cartItem: $cartItem)
            }
        }.ignoresSafeArea(.all, edges: .top)
    }
}

struct iShopView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            iShopView()
            ItemDetailsView(product: .constant(Product.example[1]), isActive: .constant(false), count: .constant(0), cartItem: .constant(0))
            CartView()
            CheckoutView()
        }
    }
}

//MARK: - HeaderView
struct HeaderView: View {
    @Binding var count: Int
    @Binding var cartItem: Int
    @State private var isCartShown = false
    
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
                        Button(action: {self.isCartShown.toggle()}, label: {
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
            VStack(alignment: .center, spacing: 3) {
                Text(title)
                    .font(.system(size: selectedTab == title ? 14 : 11))
                    .fontWeight(.bold)
                    .foregroundColor(selectedTab == title ? .primary : .secondary)
                
                
                ZStack {
                    Capsule()
                        .fill(Color.clear)
                        .frame(width: 35, height: 3)
                    if selectedTab == title {
                        Capsule()
                            .fill(Color.primary)
                            .frame(width: 35, height: 4)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
                
            }.padding(.horizontal, 5)
            .padding(.bottom, 10)
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
                    .frame(width: 90, height: 90)
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
            }.frame(height: 50, alignment: .center)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
        }.frame(width: 150, height: 160)
        .background(product.color)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}


fileprivate struct ItemDetailsView: View {
    @Binding var product: Product!
    @Binding var isActive: Bool
    //var animation: Namespace.ID
    @State private var color = Color.green
    @State private var isTapped = false
    @Binding var count: Int
    @Binding var cartItem: Int
    
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
                        
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                            Button(action: {}, label: {
                                Image(systemName: "cart")
                            })
                            
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
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
                    .padding()
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    
                    //MARK: - HeaderView
                    VStack(alignment: .leading, spacing: 5) {
                        Text(product.brand)
                            .fontWeight(.semibold)
                            .padding(.top )
                        
                        Text(product.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    
                    
                    //MARK: - ImageView and Price
                    VStack {
                        Image(product.image)
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 6, y: 3)
                            .frame(width: 300, height: 200)
                            .frame(maxWidth: .infinity, alignment: .center)
                        //.matchedGeometryEffect(id: product.image, in: animation)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Price")
                                        //.fontWeight(.medium)
                                        .foregroundColor(.primary)
                                    
                                    Text("৳\(product.price)")
                                        .fontWeight(.heavy)
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                                
                                VStack(spacing: 5) {
                                    Text("Shipping")
                                        .foregroundColor(.gray)
                                    
                                    
                                    Text(product.estimateShipping)
                                        .fontWeight(.medium)
                                }
                            }.padding(.vertical)
                            
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Color")
                                    .foregroundColor(.gray)
                                
                                HStack(spacing: 10) {
                                    ColorButton(color: Color.green, selectedColor: $color)
                                    ColorButton(color: Color.yellow, selectedColor: $color)
                                    ColorButton(color: Color.purple, selectedColor: $color)
                                }
                            }
                            
                            
                            Text(product.description)
                                .font(.callout)
                                .foregroundColor(.gray)
                                .padding(.top)
                            
                            HStack {
                                HStack(spacing: 10) {
                                    Image(systemName: "minus")
                                        .frame(width: 30, height: 20)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                                        .onTapGesture {
                                            if count > 0 {
                                                count -= 1
                                            }
                                        }
                                    
                                    Text("\(count)")
                                        .frame(width: 25)
                                    Image(systemName: "plus")
                                        .frame(width: 30, height: 20)
                                        .overlay(RoundedRectangle(cornerRadius: 2).stroke(lineWidth: 1))
                                        .onTapGesture {
                                            count += 1
                                        }
                                }
                                
                                Spacer()
                                
                                Circle().fill(isTapped ? Color.red : Color.black.opacity(0.8)).frame(width: 30, height: 30)
                                    .overlay(Image(systemName: "heart.fill").foregroundColor(Color.white).font(.system(size: 17, weight: .medium)))
                                    .onTapGesture {
                                        self.isTapped.toggle()
                                    }
                                
                                
                            }.padding(.top)
                            .font(.title3)
                            .foregroundColor(Color.black.opacity(0.75))
                        }.padding(.horizontal)
                        .padding(.top, 20)
                        
                        Button(action: {
                            withAnimation { self.cartItem = count }
                        }, label: {
                            Text("ADD TO CART")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .semibold))
                                .frame(maxWidth: .infinity, maxHeight: 45, alignment: .center)
                                .background(Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding([.horizontal, .top])
                        })
                        
                        
                        Spacer()
                    }///.frame(height: UIScreen.main.bounds.size.height / 1.5)
                    .background(Color.white.padding(.top, -100)) //Color.pink.opacity(0.05).padding(.top, -100)
                    .cornerRadius(30)
                    .padding([.top, .bottom], 20)
                    
                }
            }
            
            //Spacer()
            
        }//.padding(.horizontal)
        .frame(height: UIScreen.main.bounds.size.height)
        .background(product.color)
        .ignoresSafeArea(.all, edges: .all)
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
                    Text(product.title)
                        .foregroundColor(.secondary)
                        .font(.system(size: 12, weight: .semibold))
                    Text("৳\(product.price)")
                        .font(.system(size: 13, weight: .semibold))
                    //.foregroundColor(.blue)
                }
                
                Spacer()
                
                HStack(spacing: 2) {
                    Button(action: {
                        if numberOfItem > 0 {
                            numberOfItem -= 1
                        }
                    }, label: {
                        Image(systemName: "minus")
                            .frame(width: 23, height: 17)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                    })
                    
                    
                    Text("\(numberOfItem)")
                        .frame(width: 25)
                    
                    Button(action: {
                        numberOfItem += 1
                    }, label: {
                        Image(systemName: "plus")
                            .frame(width: 23, height: 17)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                    })
                }.font(.system(size: 13, weight: .medium))
                .foregroundColor(.primary)
                .padding(.horizontal)
                
            }
            .frame(width: 350 , height: 46)
            .background(Color.secondary.opacity(0.075))
            .clipShape(RoundedRectangle(cornerRadius: 8))        }
    }
}



fileprivate struct CartView: View {
    @Environment(\.presentationMode) var presentationMode
    fileprivate let products:[Product] = Product.cart
    
    @State private var totalPrice = 0
    @State private var isCheckoutShown = false
    
    var background: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.9399157139, green: 0.9614128444, blue: 1, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(products) { product in
                            CartItemView(product: product)
                                .onAppear {
                                    self.totalPrice = product.price
                                }
                        }
                    }
                }.offset(y: 30)
                
                VStack {
                    Rectangle()
                        .fill(Color.clear)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Shipping: Free")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            HStack {
                                Text("Total:")
                                    .font(.system(size: 15, weight: .medium))
                                Text("৳\(totalPrice)")
                                    .font(.system(size: 18, weight: .semibold))
                                //.foregroundColor(.blue)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.isCheckoutShown.toggle()
                        }, label: {
                            Text("Check Out")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.black)
                                .clipShape(Capsule())
                                .shadow(radius: 2, y: 1)
                        }).sheet(isPresented: $isCheckoutShown) {
                            CheckoutView()
                        }
                    }.padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                }
            }.navigationTitle("Cart items")
            .navigationBarItems(trailing: Button("Cancel") { self.presentationMode.wrappedValue.dismiss()}.foregroundColor(.primary) )
        }
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
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Cell:")
                                .font(.headline)
                            
                            Text("Phone: +8801710000000")
                                .font(.footnote)
                                .padding(.horizontal, 10)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(5)
                            
                        }.font(.system(size: 15, weight: .medium))
                        .padding(.bottom, 20)
                        
                        Text("Biling Address:")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            TextField("address", text: $addressLine)
                                .padding(4)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
                            
                            TextField("city", text: $city)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
                            
                            TextField("postal code", text: $postalCode)
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
                                
                                Text("Use account address")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }.padding(.vertical, 10)
                            .font(.footnote)
                        }
                        
                    }.font(.system(size: 14))
                    
                    
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
                                    .font(.system(size: 15, weight: .regular))
                                Text("৳1,45000")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.primary)
                            }
                            
                            Text("VAT and SD included")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                        }
                        
                        Spacer()
                        
                        Button(action: { }, label: {
                            Text("Proceed to Pay")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.black)
                                .clipShape(Capsule())
                                .shadow(radius: 2, y: 1)
                        })
                    }.padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.black.opacity(0.07))
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
    let title: String
    let brand: String
    let color: Color
    let price: Int
    let estimateShipping: String
    let dayAndWeek: String
    let description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse nec quam commodo, consectetur felis id, lobortis massa. Donec efficitur nisi id feugiat porta. Morbi luctus viverra semper. Duis sed mi in dolor molestie maximus ut eget lacus. Maecenas dapibus eu sapien et dignissim. Maecenas rutrum mi in interdum consectetur. Nullam vestibulum nunc diam, vitae auctor sapien ultricies eget. Morbi viverra luctus lorem, vitae suscipit mauris rhoncus vel."
    let type = "Technology"
    
    static let example: [Product] = [
        Product(image: "yeezy-500", title: "Yeezy Boost 500", brand: "Adidas", color: Color(#colorLiteral(red: 0.5974173546, green: 0.6317743659, blue: 0.6106539369, alpha: 1)), price: 27_000, estimateShipping: "Today", dayAndWeek: "D"),
        Product(image: "iphone-12", title: "iPhone 12 Purple", brand: "Apple", color: Color(#colorLiteral(red: 0.8154860139, green: 0.7859579921, blue: 0.8829900622, alpha: 1)), price: 1_10000, estimateShipping: "Tomorrow", dayAndWeek: "D"),
        Product(image: "ipad-pro-21", title: "M1 iPad Pro", brand: "Apple", color: Color(#colorLiteral(red: 0.9803065658, green: 0.9804469943, blue: 0.9802758098, alpha: 1)), price: 1_10000, estimateShipping: "This Week", dayAndWeek: "W"),
        Product(image: "imac-21-1", title: "M1 iMac", brand: "Apple", color: Color(#colorLiteral(red: 0.979149878, green: 0.935824275, blue: 1, alpha: 1)), price: 1_45000, estimateShipping: "This Week", dayAndWeek: "W"),
        Product(image: "airtag", title: "Airtags", brand: "Apple", color: Color(#colorLiteral(red: 0.8861966729, green: 0.8863243461, blue: 0.8861686587, alpha: 1)), price: 3_000, estimateShipping: "Today", dayAndWeek: "D,W"),
        Product(image: "bmw", title: "Model i8", brand: "BMW", color: Color(#colorLiteral(red: 0.6916418672, green: 0.0513773039, blue: 0.08828204125, alpha: 1)), price: 50_00000, estimateShipping: "Next Week", dayAndWeek: "W"),
        Product(image: "ps5", title: "PS5", brand: "Sony", color: Color(#colorLiteral(red: 0.5266396999, green: 0.5377212167, blue: 0.969317615, alpha: 1)), price: 6_0000, estimateShipping: "Today", dayAndWeek: "D"),
        Product(image: "canon5d", title: "EOS 5D Mark IV", brand: "Canon", color: Color(#colorLiteral(red: 0.1651098132, green: 0.1681086421, blue: 0.1892572641, alpha: 1)), price: 1_20000, estimateShipping: "Tomorrow", dayAndWeek: "W"),
        Product(image: "apple-watch-6", title: "Watch Series 6", brand: "Apple", color: Color(#colorLiteral(red: 0.2075617015, green: 0.2041387558, blue: 0.1955869496, alpha: 1)), price: 4_5000, estimateShipping: "Today", dayAndWeek: "D,W"),
        Product(image: "vespa-2", title: "Model 2", brand: "Vespa", color: Color(#colorLiteral(red: 0.3970476985, green: 0.4470000863, blue: 0.5866626501, alpha: 1)), price: 1_55000, estimateShipping: "Next Week", dayAndWeek: "W")
    ]
    
    static let favorites: [Product] = [
        Product(image: "iphone-12", title: "iPhone 12 Purple", brand: "Apple", color: Color(#colorLiteral(red: 0.8154860139, green: 0.7859579921, blue: 0.8829900622, alpha: 1)), price: 1_10000, estimateShipping: "Tomorrow", dayAndWeek: "D"),
        Product(image: "imac-21-1", title: "M1 iMac", brand: "Apple", color: Color(#colorLiteral(red: 0.979149878, green: 0.935824275, blue: 1, alpha: 1)), price: 1_45000, estimateShipping: "This Week", dayAndWeek: "W"),
        Product(image: "airtag", title: "Airtags", brand: "Apple", color: Color(#colorLiteral(red: 0.8861966729, green: 0.8863243461, blue: 0.8861686587, alpha: 1)), price: 3_000, estimateShipping: "Today", dayAndWeek: "D,W")
    ]
    
    static let cart: [Product] = [
        Product(image: "ipad-pro-21", title: "M1 iPad Pro", brand: "Apple", color: Color(#colorLiteral(red: 0.9803065658, green: 0.9804469943, blue: 0.9802758098, alpha: 1)), price: 1_10000, estimateShipping: "This Week", dayAndWeek: "W"),
        Product(image: "imac-21-1", title: "M1 iMac", brand: "Apple", color: Color(#colorLiteral(red: 0.979149878, green: 0.935824275, blue: 1, alpha: 1)), price: 1_45000, estimateShipping: "This Week", dayAndWeek: "W"),
        Product(image: "airtag", title: "Airtags", brand: "Apple", color: Color(#colorLiteral(red: 0.8861966729, green: 0.8863243461, blue: 0.8861686587, alpha: 1)), price: 3_000, estimateShipping: "Today", dayAndWeek: "D,W")
    ]
}

fileprivate var scrollTabs = ["All ", "Computer", "Smartphone", "Footwear", "Backpack", "Clothing"]
