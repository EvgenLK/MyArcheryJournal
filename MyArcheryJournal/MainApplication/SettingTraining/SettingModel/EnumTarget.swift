//
//  EnumTarget.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 29.07.2024.
//

enum EnumTarget: String, CaseIterable {
    case notSelected = "Не выбрано"
    case compoundFita40mm5Circle = " Com. FITA 40 mm"
    case recurceFita40mm5Circle = "Rec. FITA 40 mm"
    case fita40mm = "FITA 80mm"
    case fita122mm = "FITA 122mm"
    case recurceFita3x20Ver = "Rec. FITA 3x20 mm Vertical"
    case universalFita3x20Ver = "Uni. FITA 3x20 mm Vertical"
    
    var localized: String {
        switch self {
        case .notSelected:
            return Tx.AddTraining.notSelected.localized()
        default:
            return self.rawValue
        }
    }
    
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
    func caseNameByIndex(_ index: Int) -> String {
        guard index >= 0 && index < EnumTarget.allCases.count else {
            return "\(Tx.System.error)"
        }
        let selectedCase = EnumTarget.allCases[index]
        return selectedCase.caseName()
    }
}

enum SizeTarget: String {
    case fita40mm5Circle = "40"
    case fita80mm = "80"
    case fita122mm = "122"
    case fita3x20Ver = "20"
    case nottarget = "Не выбрано"
}
