//
//  ContentView.swift
//  OnboardingScreen
//
//  Created by Sheikh Bayazid on 5/2/21.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboarding") var isOnboarding = true
    
    var body: some View {
        ZStack {
            TabView {
                Text("Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                Text("Library")
                    .tabItem {
                        Image(systemName: "rectangle.stack.fill")
                        Text("Library")
                    }
                
                Text("Settings")
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
            }.accentColor(.primary)
            
            if isOnboarding {
                ZStack {
                    OnboardingScreenView(isOnboarding: $isOnboarding)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
