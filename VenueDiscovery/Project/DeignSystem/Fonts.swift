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
    
enum appFontSize {
    static let h1: CGFloat = 29
    static let h2: CGFloat = 23
    static let small: CGFloat = 9
    static let span: CGFloat = 8
    static let body: CGFloat = 12
    static let paragraph: CGFloat = 10
    static let button: CGFloat = 10
}

extension Color {
    static let blackText = Color(
        red: 23/255,
        green: 23/255,
        blue: 23/255
    )

    static let whiteText = Color(
        red: 255/255,
        green: 255/255,
        blue: 255/255
    )

    static let appWhite = Color(
        red: 255/255,
        green: 255/255,
        blue: 255/255
    )

    static let darkGrayText = Color(
        red: 118/255,
        green: 118/255,
        blue: 127/255
    )
    
    static let lightGrayText = Color(
        red: 139/255,
        green: 139/255,
        blue: 148/255
    )
    
    static let lightGrayBoarder = Color(
        red: 222/255,
        green: 222/255,
        blue: 226/255
    )

    static let blackBackground = Color(
        red: 34/255,
        green: 34/255,
        blue: 37/255
    )
    
    static let lightBackground = Color(
        red: 247/255,
        green: 247/255,
        blue: 248/255
    )
    
    static let blueIcon = Color(
        red: 86/255,
        green: 81/255,
        blue: 219/255
    )
}


enum appIcons{
    static let magnifyingGlass: String = "magnifyingglass"
    static let heartFill: String = "heart.fill"
    static let heart: String = "heart"
    static let starFill: String = "star.fill"
}
