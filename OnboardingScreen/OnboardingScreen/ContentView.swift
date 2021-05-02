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
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                Text("Library")
                    .tabItem {
                        Image(systemName: "rectangle.stack.fill")
                        Text("Library")
                    }
                
                Text("Settings")
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
            }.accentColor(Color(#colorLiteral(red: 0.986761868, green: 0.6856738329, blue: 0.3046730459, alpha: 1)))
            
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
