//
//  Fonts.swift
//  VenueDiscovery
//
//  Created by Ghadeer Alkubaish on 11/3/26.
//


import SwiftUI


extension Font {
    static func inter(
        size: CGFloat,
        weight: Font.Weight = .regular
    ) -> Font {
        let fontName: String

        switch weight {
        case .medium:
            fontName = "Inter18pt-Medium"
        case .semibold:
            fontName = "Inter18pt-SemiBold"
        case .bold:
            fontName = "Inter18pt-Bold"
        case .heavy, .black:
            fontName = "Inter18pt-ExtraBold"
        default:
            fontName = "Inter18pt-Regular"
        }

        return .custom(fontName, size: size)
    }
}
