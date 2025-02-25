//
//  SettingCardView.swift
//  Archery Journal
//
//  Created by Evgenii on 23.02.2025.
//

import SwiftUI

struct SettingCardView: View {
    let card: CartTarget
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                card.image.fromStringInImage()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                Text(card.title)
                    .font(OurFonts.fontSFProTextRegular14)
                    .padding(.top, 8)
            }
            .frame(width: 174, height: 196)
            .padding(1)
            .background(PaletteApp.adaptiveBGPrimary)
            .cornerRadius(12)
            .onTapGesture {
                action()
            }

            if isSelected {
                ListImages.Other.checkmark
                    .foregroundColor(.blue)
                    .padding(8)
                    .onTapGesture {
                        action() 
                    }
            }
        }
    }
}
