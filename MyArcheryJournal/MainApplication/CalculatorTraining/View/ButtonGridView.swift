//
//  ButtonGridView.swift
//  Archery Journal
//
//  Created by Evgenii on 26.02.2025.
//

import SwiftUI

struct ButtonGridView: View {
    var onButtonTap: (Int) -> Void
    var numberButton: [String]

    // Массивы цветов кнопок
    private var buttonColors: [Color]
    private var textColors: [Color]

    // Инициализатор
    init(onButtonTap: @escaping (Int) -> Void, numberButton: [String]) {
        self.onButtonTap = onButtonTap
        self.numberButton = numberButton

        // Вычисляем цвета заранее
        self.buttonColors = numberButton.map { EnumColorMark.fromValue($0).color }
        self.textColors = numberButton.map { EnumColorMark.fromForegroundColor($0).color }
    }

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<numberButton.count, id: \.self) { index in
                if index % 4 == 0 {
                    HStack {
                        ForEach(index..<min(index + 4, numberButton.count), id: \.self) { innerIndex in
                            Button(action: {
                                onButtonTap(innerIndex)
                            }) {
                                Text("\(numberButton[innerIndex])")
                                    .font(OurFonts.fontSFProTextRegular17)
                                    .frame(width: 83, height: 60)
                                    .background(buttonColors[innerIndex]) // Используем заранее вычисленный цвет
                                    .foregroundColor(textColors[innerIndex]) // Используем заранее вычисленный цвет
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(PaletteApp.adaptiveBGSecondary)
    }
}
