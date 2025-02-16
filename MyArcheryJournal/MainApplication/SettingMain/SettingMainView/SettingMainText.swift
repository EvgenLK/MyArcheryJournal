//
//  SettingMainText.swift
//  MyArcheryJournal
//
//  Created by Evgenii on 16.02.2025.
//

import SwiftUI

struct SettingMainTextDoc: View {
    var text: String

    var body: some View {
        ScrollView {
            Text(text)
                .padding()
                .font(.body)
            Spacer()
        }
        .padding()
    }
}
