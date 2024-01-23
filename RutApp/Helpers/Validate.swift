//
//  Validate.swift
//  RutApp
//
//  Created by Michael Kivo on 20/01/2024.
//

import UIKit

class Validate {
    
    static func emailIsValid(_ email: String?) -> Bool {
        guard let email = email else { return false }
        if email == "" { return false }
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPred.evaluate(with: email)
    }
    
    static func passwordIsValid(_ password: String?) -> Bool {
        guard let password = password else { return false }
        if password == "" { return false }
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%;*?&])[А-Яа-яA-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func fioIsValid(_ fio: String?) -> Bool {
        guard let fio = fio else { return false }
        if fio == "" { return false }
        
        let whiteSpacesCount = fio.split(separator: " ").count
        
        if whiteSpacesCount == 3 || whiteSpacesCount == 2 {
            return true
        }
        
        return false
    }
    
    static func instituteIsValid(_ institute: String?) -> Bool {
        guard let institute = institute else { return false }
        if institute == "" { return false }
        
        let institutes = ["АБП", "АВТ", "АВИШ", "ВИШ", "АГА", "АДХ", "АИТСвАДК", "ИМТК", "ИПСС", "ИТТСУ", "ИУЦТ", "ИЭФ", "РАПС", "РОАТ", "ЮИ"]
        
        let upperInstitute = institute.uppercased()
                
        for value in institutes {
            if value == upperInstitute {
                return true
            }
        }
        return false
    }
    
    static func showError(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: { action in
            print("Alert successful")
        }))
        
        return alert
    }
    
}
