//
//  ListImages.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 02.07.2024.
//

import SwiftUI

enum ListImages {
    enum TapBar {
        static let target = Image("target")
        static let setting = Image("setting")
        static let statictic = Image("statictics")
    }
    enum Other {
        static let emptyTraining = Image("EmptyListTr")
    }
    enum Target {
        static let compoundFita40mm5Circle = Image("compound FITA 40mm 5 circle")
        static let recurceFita40mm5Circle = Image("FITA 40mm 5 circle")
        static let fita40mm = Image("FITA 80mm")
        static let fita122mm = Image("FITA 122mm")
        static let recurceFita3x20Ver = Image("Recurce FITA 3x20 Vertical")
        static let universalFita3x20Ver = Image("Universal target FITA 3x20 Vertical")
    }
    enum IconButton {
        static let calculator = Image("calculator")
        static let target_mark = Image("target_mark")

    }
}
