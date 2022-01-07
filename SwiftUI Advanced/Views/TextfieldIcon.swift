//
//  TextFieldIcon.swift
//  SwiftUI Advanced
//
//  Created by Tony on 06/01/2022.
//

import SwiftUI

struct TextfieldIcon: View {
    var iconName: String
    @Binding var currentlyEditing: Bool
    @State private var colorAngle: Double = 0.0
    
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .dark){
                ZStack {
                    if currentlyEditing {
                        AngularGradient(gradient: Gradient(colors: gradient1), center: .center, angle: .degrees(colorAngle))
                            .blur(radius: 10.0)
                            .onAppear() {
                                withAnimation(.linear(duration: 7.0)) {
                                    self.colorAngle += 350
                                }
                            }
                    }
                    
                    Color("tertiaryBackground")
                        .cornerRadius(12)
                        .opacity(0.8)
                    .blur(radius: 3.0)
                }
            }
        }
        .cornerRadius(12)
        .overlay(
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white, lineWidth: 1)
                    .blendMode(.overlay)
                Image(systemName: iconName)
                    .gradientForeground(colors: [Color("pink-gradient-1"), Color("pink-gradient-2")])
                    .font(.system(size: 17, weight: .medium))
            }
        )
        .frame(width: 36, height: 36, alignment: .center)
        .padding([.vertical, .leading], 8)
    }
}

struct TextfieldIcon_Previews: PreviewProvider {
    static var previews: some View {
        TextfieldIcon(iconName: "key.fill", currentlyEditing: .constant(true))
    }
}
