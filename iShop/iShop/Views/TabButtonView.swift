//
//  TabButtonView.swift
//  iShop
//
//  Created by Sheikh Bayazid on 4/27/21.
//

import SwiftUI

struct TabButtonView: View {
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

