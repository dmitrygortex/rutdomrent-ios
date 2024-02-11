//
//  PaddedLabel.swift
//  RutApp
//
//  Created by Michael Kivo on 17/01/2024.
//

import UIKit

final class PaddedLabel: UILabel {
    let padding: CGFloat = 12
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        super.drawText(in: rect.inset(by: insets))
    }
}
