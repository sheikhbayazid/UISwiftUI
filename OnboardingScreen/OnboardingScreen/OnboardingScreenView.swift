//
//  OnboardingScreenView.swift
//  OnboardingScreen
//
//  Created by Sheikh Bayazid on 5/2/21.
//

import SwiftUI

struct OnboardingScreenView: View {
    @Binding var isOnboarding: Bool
    
    let yExtension: CGFloat = 50
    let items = Item.example
    
    var body: some View {
        GeometryReader { g in
            TabView {
                OnboardingView(item: items[0], isOnboarding: $isOnboarding)
                    .tag(0)
                OnboardingView(item: items[1], isOnboarding: $isOnboarding)
                    .tag(1)
                
                OnboardingView(item: items[2], isOnboarding: $isOnboarding)
                    .tag(2)
            }
            .frame(width: g.size.width, height: g.size.height + yExtension)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
        .offset(y: -yExtension)
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct OnboardingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreenView(isOnboarding: .constant(false))
    }
}

