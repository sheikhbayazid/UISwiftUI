//
//  ItemDetailsView.swift
//  iShop
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct ItemDetailsView: View {
    @Binding var product: Product!
    @Binding var isActive: Bool
    var animation: Namespace.ID
    @Binding var cartItem: Int
    
    @State private var count: Int = 0
    @State private var color = Color.green
    @State private var isTapped = false
    @State private var isCartShown = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            VStack(alignment: .leading, spacing: 5) {
                VStack(alignment: .leading, spacing: 5) {
                    //MARK: - Navigation Bar
                    HeaderView(isActive: $isActive, count: $count, cartItem: $cartItem)
                        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    
                    //MARK: - Product Brand, Title
                    VStack(alignment: .leading, spacing: 5) {
                        Text(product.brand)
                            .fontWeight(.semibold)
                            .padding(.top )
                        
                        Text(product.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    
                    
                    //MARK: - Image and Price
                    VStack {
                        Image(product.image)
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 6, y: 3)
                            .frame(width: 300, height: 200)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .matchedGeometryEffect(id: product.image, in: animation)
                    }
                    
                    //MARK: - Product Description
                    VStack(alignment: .leading) {
                        BottomCardView(product: product, cartItem: $cartItem, count: $count)
                        
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
                    }.background(Color.white.padding(.top, -100)) //Color.pink.opacity(0.05).padding(.top, -100)
                    .cornerRadius(30)
                    .padding([.top, .bottom], 20)
                    
                    
                    
                    
                    
                }
            }
            
        }
        .frame(height: UIScreen.main.bounds.size.height)
        .background(product.color)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    struct TestView: View {
        @Namespace var animation
        
        var body: some View {
            ItemDetailsView(product: .constant(Product.example[0]), isActive: .constant(false), animation: animation, cartItem: .constant(1))
        }
    }
    
    static var previews: some View {
        TestView()
    }
}


fileprivate struct HeaderView: View {
    @Binding var isActive: Bool
    @Binding var count: Int
    @Binding var cartItem: Int
    
    @State private var isCartShown = false
    
    var body: some View {
        //MARK: - Navigation Bar
        HStack {
            Button(action: {
                self.isActive.toggle()
            }, label: {
                Image(systemName: "chevron.left")
            })
            
            Spacer()
            
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
        .font(.system(size: 24, weight: .medium))
        .foregroundColor(.primary)
        .padding()
    }
}

fileprivate struct ColorButton: View {
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


fileprivate struct BottomCardView: View {
    let product: Product
    @Binding var cartItem: Int
    @Binding var count: Int
    
    @State private var color = Color.green
    @State private var isTapped = false
    
    var body: some View {
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
    }
}
