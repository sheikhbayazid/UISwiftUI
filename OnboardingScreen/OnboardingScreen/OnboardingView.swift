//
//  OnboardingView.swift
//  OnboardingScreen
//
//  Created by Sheikh Bayazid on 5/2/21.
//

import SwiftUI

struct OnboardingView: View {
    let item: Item
    @Binding var isOnboarding: Bool
    
    let screen = UIScreen.main.bounds
    @State private var isShowing = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.986761868, green: 0.6856738329, blue: 0.3046730459, alpha: 1)).ignoresSafeArea()
            
            if isShowing  {
                VStack(spacing: 20) {
                    
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screen.width * 0.85, height: screen.width * 0.85)
                        .padding(.bottom)
                    
                    Text(item.title)
                        .font(.system(size: 30, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text(item.description)
                        .font(.system(size: 16, weight: .light))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    HStack {
                        if item.isLast {
                            if isShowing {
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                       isOnboarding = false
                                    }
                                    
                                }, label: {
                                    Text("Get Started")
                                        .font(.system(size: 20, weight: .medium))
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color.black)
                                        .clipShape(Capsule())
                                        .padding(.vertical, 30)
                                })
                            }
                        } else {
                            Spacer()
                            
                            Image(systemName: "arrow.forward.circle.fill")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.vertical)
                            
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                }
            }
        }.onAppear { withAnimation(.easeInOut) { self.isShowing = true }}
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(item: Item.example[2], isOnboarding: .constant(false))
    }
}
