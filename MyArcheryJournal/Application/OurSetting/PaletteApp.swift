//
//  PaletteApp.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 02.07.2024.
//
import SwiftUI

struct PaletteApp {
    // MARK: - Target
    static let targetBlue = Color(hex: "#01ADEF")
    static let targetRed = Color(hex: "#EE1C25")
    static let targetYellow = Color(hex: "#FEF201")
    static let targetBlack = Color(hex: "#131313")
    static let targetWhite = Color(hex: "#FFFFFF")
    // MARK: - LabelsLight
    static let labelPrimaryLight = Color(hex: "#000000")
    static let labelSecondaryLight = Color(hex: "#3C3C43").opacity(0.6)
    static let labelTertiaryLight = Color(hex: "#3C3C43").opacity(0.3)
    static let labelQuaternaryLight = Color(hex: "#3C3C43").opacity(0.18)
    // MARK: - LabelsDark
    static let labelPrimaryDark = Color(hex: "#FFFFFF")
    static let labelSecondaryDark = Color(hex: "#EBEBF5").opacity(0.6)
    static let labelTertiaryDark = Color(hex: "#EBEBF5").opacity(0.3)
    static let labelQuaternaryDark = Color(hex: "#EBEBF5").opacity(0.18)
    // MARK: - Blue
    static let blueLight = Color(hex: "#0076F6")
    static let blueDark = Color(hex: "#0A84FF")
    // MARK: - BGLight
    static let bgPrimaryLight = Color(hex: "#FFFFFF")
    static let bgSecondaryLight = Color(hex: "#F2F2F7")
    // MARK: - BGDark
    static let bgPrimaryDark = Color(hex: "#000000")
    static let bgSecondaryDark = Color(hex: "#1C1C1E")
    // MARK: - GreysLight
    static let systemGrey2Light = Color(hex: "#AEAEB2")
    static let systemGrey5Light = Color(hex: "#E5E5EA")
    // MARK: - GreysDark
    static let systemGrey2Dark = Color(hex: "#636366")
    static let systemGrey5Dark = Color(hex: "#2C2C2E")
    // MARK: - IconSnackBar
    static let iconGreenLigth = Color(hex: "#15B812")
    static let iconGreenDark = Color(hex: "#08B105")
    // MARK: - Adaptive label Lihgt/Dark
    static var adaptiveLabelPrimary: Color {
        return Color(UIColor { adaptive in
            return adaptive.userInterfaceStyle == .dark ? UIColor(labelPrimaryDark) : UIColor(labelPrimaryLight)
        })
    }
    static var adaptiveLabelSecondary: Color {
        return Color(UIColor { adaptive in
            return adaptive.userInterfaceStyle == .dark ? UIColor(labelSecondaryDark) : UIColor(labelSecondaryLight)
        })
    }
    static var adaptiveLabelTertiary: Color {
        return Color(UIColor { adaptive in
            return adaptive.userInterfaceStyle == .dark ? UIColor(labelTertiaryDark) : UIColor(labelTertiaryLight)
        })
    }
    
    // MARK: - Adaptive Blue Lihgt/Dark
    static var adaptiveBlue: Color {
        return Color(UIColor { adaptive in
            return adaptive.userInterfaceStyle == .dark ? UIColor(blueDark) : UIColor(blueLight)
        })
    }
    
    // MARK: - Adaptive BG Lihgt/Dark
    static var adaptiveBGPrimary: Color {
        return Color(UIColor { adaptive in
            return adaptive.userInterfaceStyle == .dark ? UIColor(bgPrimaryDark) : UIColor(bgPrimaryLight)
        })
    }
    static var adaptiveBGSecondary: Color {
        return Color(UIColor { adaptive in
            return adaptive.userInterfaceStyle == .dark ? UIColor(bgSecondaryDark) : UIColor(bgSecondaryLight)
        })
    }
    
    // MARK: - Adaptive Greys Lihgt/Dark
    static var adaptiveGreysSysGrey2: Color {
        return Color(UIColor { adaptive in
            return adaptive.userInterfaceStyle == .dark ? UIColor(systemGrey2Dark) : UIColor(systemGrey2Light)
        })
    }
    static var adaptiveGreysSysGrey5: Color {
        return Color(UIColor { adaptive in
            return adaptive.userInterfaceStyle == .dark ? UIColor(systemGrey5Dark) : UIColor(systemGrey5Light)
        })
    }
    static var adaptiveBGSnackBar: Color {
        return Color(UIColor { adaptive in
            return adaptive.userInterfaceStyle == .light ? UIColor(labelPrimaryLight) : UIColor(labelPrimaryDark)
        })
    }
    static var adaptiveBGSuccessIcon: Color {
        return Color(UIColor { adaptive in
            return adaptive.userInterfaceStyle == .light ? UIColor(iconGreenLigth) : UIColor(iconGreenDark)
        })
    }
}
