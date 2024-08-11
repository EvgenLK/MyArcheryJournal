//
//  EnumTarget.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 29.07.2024.
//

enum EnumTarget: String, CaseIterable {
    case notSelected = "Не выбрано"
    case compoundFita40mm5Circle = "comp. Fita 40mm 5 Circle"
    case recurceFita40mm5Circle = "rec. Fita 40 mm 5 Circle"
    case fita40mm = "Fita 80mm"
    case fita122mm = "Fita 122mm"
    case recurceFita3x20Ver = "rec. Fita 3x20 Vertical"
    case universalFita3x20Ver = "universal Fita 3x20 Ver"
    
    func caseName() -> String {
        return String(describing: self)
    }
    
    func sizeTargerCase() -> SizeTarget {
        switch self {
        case .compoundFita40mm5Circle, .recurceFita40mm5Circle:
            return .fita40mm5Circle
        case .fita40mm:
            return .fita80mm
        case .fita122mm:
            return .fita122mm
        case .recurceFita3x20Ver, .universalFita3x20Ver:
            return .fita3x20Ver
        case .notSelected:
            return .nottarget
        }
    }
}

enum SizeTarget: String {
    case fita40mm5Circle = "40"
    case fita80mm = "80"
    case fita122mm = "122"
    case fita3x20Ver = "20"
    case nottarget = "Не выбрано"
}
