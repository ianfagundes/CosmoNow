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
            traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.039, green: 0.0, blue: 0.137, alpha: 1.0) : #colorLiteral(red: 0.984, green: 0.988, blue: 0.89, alpha: 1.0)
        })
    }()

    static let primaryColor: Color = {
        return Color(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.598, green: 0.986, blue: 0.827, alpha: 1.0) : #colorLiteral(red: 0.071, green: 0.306, blue: 0.451, alpha: 1.0)
        })
    }()

    static let secondaryColor: Color = {
        return Color(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.598, green: 0.986, blue: 0.827, alpha: 1.0) : #colorLiteral(red: 0.071, green: 0.306, blue: 0.451, alpha: 1.0)
        })
    }()
    
    static let textColor: Color = {
        return Color(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.984, green: 0.988, blue: 0.89, alpha: 1.0) : #colorLiteral(red: 0.039, green: 0.0, blue: 0.137, alpha: 1.0)
        })
    }()
    
    static let ProgressIndicator: Color = {
        return Color(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.984, green: 0.988, blue: 0.89, alpha: 1.0) : #colorLiteral(red: 0.039, green: 0.0, blue: 0.137, alpha: 1.0)
        })
    }()
}
