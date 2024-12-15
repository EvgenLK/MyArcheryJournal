//
//  SnackbarView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 29.11.2024.
//

import SwiftUI

struct SnackbarView: View {
    let message: String
    let icon: Image
    let color: Color
    @Binding var isShowing: Bool

    var body: some View {
        VStack {
            if isShowing {
                HStack {
                    icon 
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20) // Задаем размер иконки
                        .foregroundColor(color) // Цвет иконки
                        .padding(.leading, 16)
                    
                    Text(message)
                        .foregroundColor(PaletteApp.adaptiveBGPrimary)
                        .padding(.leading, 14) // Отступ между иконкой и текстом
                        .padding(.vertical) // Вертикальные отступы
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(PaletteApp.adaptiveBGSnackBar)
                .cornerRadius(12)
                .padding()
                .transition(.move(edge: .top))
                .onAppear {
                    // Скрыть Snackbar через 3 секунды
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            self.isShowing = false
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: isShowing) // Анимация изменения состояния
        .frame(maxWidth: .infinity) // Растягиваем на всю ширину
    }
}
