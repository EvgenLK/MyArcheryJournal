//
//  ListImages.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 02.07.2024.
//

import SwiftUI

enum ListImages {
    enum TapBar {
        static let target = Image(systemName: "target")
        static let setting = Image(systemName: "gearshape")
        static let statictic = Image(systemName: "chart.bar.xaxis")
    }
    enum Other {
        static let emptyTraining = Image("EmptyListTr")
        static let addTraining = Image(systemName: "plus.circle.fill")
        static let markTrash = Image(systemName: "trash")
        static let markchevron_right = Image(systemName: "chevron.right")
        static let checkmark = Image(systemName: "checkmark.circle.fill")
    }
    enum Target {
        static let compoundFita40mm5Circle = Image("compound FITA 40mm 5 circle")
        static let recurceFita40mm5Circle = Image("FITA 40mm 5 circle")
        static let fita40mm = Image("FITA 80mm")
        static let fita122mm = Image("FITA 122mm")
        static let recurceFita3x20Ver = Image("Recurce FITA 3x20 Vertical")
        static let universalFita3x20Ver = Image("Universal target FITA 3x20 Vertical")
        static let notSelected = Image(systemName: "eye.slash.fill")
    }
    enum IconButton {
        static let calculator = Image("calculator")
        static let target_mark = Image("target_mark")
        static let icon_pro = Image("icon_pro")
        static let target_pro = Image("target_pro")
    }
    enum IconSnackBar {
        static let markSuccess = Image(systemName: "checkmark.circle")
        static let markXFail = Image(systemName: "xmark.circle")
        static let markInformation = Image(systemName: "exclamationmark.circle")
    }
}
