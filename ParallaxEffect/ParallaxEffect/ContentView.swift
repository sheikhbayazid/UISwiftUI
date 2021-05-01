//
//  ContentView.swift
//  ParallaxEffect
//
//  Created by Sheikh Bayazid on 5/1/21.
//

import SwiftUI

struct ContentView: View {
    let text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    let screen = UIScreen.main.bounds.size
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { geo in
                ZStack {
                    Image("p1")
                        .resizable()
                        .scaledToFill()
                    
                    BlurView(style: .systemChromeMaterial)
                        .frame(width: 230, height: 230)
                        .clipShape(Circle())
                        .overlay(
                            Image("profile")
                                .resizable()
                                .frame(width: 180, height: 180)
                        )
                }
                .offset(y: -geo.frame(in: .global).minY)
                .frame(width: screen.width, height: geo.frame(in: .global).minY + 480)
            }
            .frame(height: 480)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("High On SwiftUI")
                    .font(.system(size: 22, weight: .semibold))
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(averageColor(), lineWidth: 2))
                
                HStack {
                    HStack(spacing: 2) {
                        ForEach(0..<5) {_ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.orange)
                        }
                    }
                    
                    Text("Rating: 5/5")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
                
                Text("Learns, Builds, Creates SwiftUI")
                    .foregroundColor(.secondary)
                    .font(.footnote)
                
                Text(text)
                    .fontWeight(.light)
                    .padding(.bottom)
                
            }.padding(.horizontal)
            .padding(.top, 30)
            .background(BlurView(style: .systemThickMaterial))
            .cornerRadius(25)
            .offset(y: -30)
            
        }
        .background(averageColor())
        .ignoresSafeArea()
    }
    
    
    func averageColor() -> Color {
        let uiColor = UIImage(named: "p1")? .averageColor ?? .clear
        return Color(uiColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
    
    
}
