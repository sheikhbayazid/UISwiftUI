//
//  Item.swift
//  OnboardingScreen
//
//  Created by Sheikh Bayazid on 5/2/21.
//

import Foundation

struct Item: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been in the industry."
    let image: String
    let isLast: Bool
    
    static let example = [
        Item(title: "Get Inspired", image: "Saly-1", isLast: false),
        Item(title: "Easy and Healthy", image: "Saly-3", isLast: false),
        Item(title: "Save Your Favorites", image: "Saly-4", isLast: true)
    ]
}
