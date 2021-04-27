//
//  Model.swift
//  iStore
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import Foundation

struct Product: Identifiable {
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
