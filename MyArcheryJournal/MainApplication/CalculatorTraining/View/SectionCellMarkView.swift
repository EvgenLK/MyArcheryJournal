//
//  SectionCellMarkView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 27.09.2024.
//

import SwiftUICore

struct SectionCellMarkView: View {
    let roundCellAttempt: RoundSection
    
    var body: some View {
        HStack {
            Text("\(Tx.CalculatorView.round.localized()) \(roundCellAttempt.roundNumber)")
                .font(OurFonts.fontSFProTextRegular17)
                .foregroundColor(PaletteApp.gray)
            
            Spacer()
            
            Text("\(roundCellAttempt.roundSum)")
                .font(OurFonts.fontSFProTextRegular17)
                .foregroundColor(PaletteApp.gray)
        }
    }
}
