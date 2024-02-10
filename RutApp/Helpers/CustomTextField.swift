//
//  CustomTextField.swift
//  RutApp
//
//  Created by Michael Kivo on 10/02/2024.
//

import UIKit

class CustomTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let offsetX: CGFloat = 10
        return bounds.insetBy(dx: offsetX, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
