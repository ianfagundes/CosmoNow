//
//  ThemeManager.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import SwiftUI

struct ThemeManager {
    static let backgroundColor: Color = {
        return Color(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .black : .white
        })
    }()

    static let primaryColor: Color = {
        return Color(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? UIColor.systemGreen : UIColor.systemPurple
        })
    }()

    static let secondaryColor: Color = {
        return Color(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? UIColor(red: 0.6, green: 1.0, blue: 0.3, alpha: 1) : UIColor(red: 0.5, green: 0, blue: 0.8, alpha: 1)
        })
    }()
}
