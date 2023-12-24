//
//  NeumorphicStyleButton.swift
//  RemoteControl
//
//  Created by Akın Özcan on 2.12.2023.
//

import SwiftUI

struct NeumorphicStyleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.background)
                    .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
                    .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
