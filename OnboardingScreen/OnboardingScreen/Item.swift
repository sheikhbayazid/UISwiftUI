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
    let description: String
    let image: String
    let isLast: Bool
    
    static let example = [
        Item(title: "Get Inspired", description: "Don't know how to organize your tasks? Write your tasks and we'll remind you to complete the task.", image: "Saly-1", isLast: false),
        Item(title: "Easy and Fast", description: "All your tasks are sync with iCloud. Access from any device, anywhere.", image: "Saly-4", isLast: false),
        Item(title: "Save Your Favorites", description: "Save your favorite tasks, it will give higher priority over other tasks.", image: "Saly-5", isLast: true)
    ]
}
