//
//  Model.swift
//  iShop
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

var scrollTabs = ["All ", "Computer", "Smartphone", "Footwear", "Backpack", "Clothing"]

struct Product: Identifiable {
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
        Product(image: "ipad-pro-21", title: "M1 iPad Pro", brand: "Apple", color: Color(#colorLiteral(red: 0.9803065658, green: 0.9804469943, blue: 0.9802758098, alpha: 1)), price: 1_10000, estimateShipping: "This Week", dayAndWeek: "W"),
        Product(image: "airtag", title: "Airtags", brand: "Apple", color: Color(#colorLiteral(red: 0.8861966729, green: 0.8863243461, blue: 0.8861686587, alpha: 1)), price: 3_000, estimateShipping: "Today", dayAndWeek: "D,W"),
        Product(image: "imac-21-1", title: "M1 iMac", brand: "Apple", color: Color(#colorLiteral(red: 0.979149878, green: 0.935824275, blue: 1, alpha: 1)), price: 1_45000, estimateShipping: "This Week", dayAndWeek: "W"),
        Product(image: "iphone-12", title: "iPhone 12 Purple", brand: "Apple", color: Color(#colorLiteral(red: 0.8154860139, green: 0.7859579921, blue: 0.8829900622, alpha: 1)), price: 1_10000, estimateShipping: "Tomorrow", dayAndWeek: "D"),
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
