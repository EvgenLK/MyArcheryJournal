//
//  String+Extension.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 30.07.2024.
//

import SwiftUI

extension String {
    func fromStringInImage() -> Image {
        switch self {
        case "compoundFita40mm5Circle":
            return ListImages.Target.compoundFita40mm5Circle
        case "recurceFita40mm5Circle":
            return ListImages.Target.recurceFita40mm5Circle
        case "fita40mm":
            return ListImages.Target.fita40mm
        case "fita122mm":
            return ListImages.Target.fita122mm
        case "recurceFita3x20Ver":
            return ListImages.Target.recurceFita3x20Ver
        case "universalFita3x20Ver":
            return ListImages.Target.universalFita3x20Ver
        default:
            return ListImages.Target.notSelected
        }
    }
}
