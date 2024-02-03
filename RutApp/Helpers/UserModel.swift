//
//  UserMode.swift
//  RutApp
//
//  Created by Michael Kivo on 03/02/2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class UserModel {
    
    private enum UserKeys: String {
        case userEmail, userPassword, userFio, userInstitute, userUID
    }
    
    static var email: String {
        get {
            return UserDefaults.standard.string(forKey: UserKeys.userEmail.rawValue) ?? ""
        } set {
            let defaults = UserDefaults.standard
            let key = UserKeys.userEmail.rawValue
            
            if Validate.emailIsValid(newValue) {
                defaults.set(newValue, forKey: key)
                print("value: \(newValue) was added to key: \(key)")
            } else {
                print("Invalid email to set UserDefaults")
            }
        }
    }
    
    static var password: String {
        get {
            return UserDefaults.standard.string(forKey: UserKeys.userPassword.rawValue) ?? ""
        } set {
            let defaults = UserDefaults.standard
            let key = UserKeys.userPassword.rawValue
            
            if Validate.passwordIsValid(newValue) {
                defaults.set(newValue, forKey: key)
                print("value: \(newValue) was added to key: \(key)")
            } else {
                print("Invalid password to set UserDefaults")
            }
        }
    }
    
    static var fio: String {
        get {
            return UserDefaults.standard.string(forKey: UserKeys.userFio.rawValue) ?? ""
        } set {
            let defaults = UserDefaults.standard
            let key = UserKeys.userFio.rawValue
            
            if Validate.fioIsValid(newValue) {
                defaults.set(newValue, forKey: key)
                print("value: \(newValue) was added to key: \(key)")
            } else {
                print("Invalid fio to set UserDefaults")
            }
        }
    }
    
    static var institute: String {
        get {
            return UserDefaults.standard.string(forKey: UserKeys.userInstitute.rawValue) ?? ""
        } set {
            let defaults = UserDefaults.standard
            let key = UserKeys.userInstitute.rawValue
            
            if Validate.instituteIsValid(newValue) {
                defaults.set(newValue, forKey: key)
                print("value: \(newValue) was added to key: \(key)")
            } else {
                print("Invalid institute to set UserDefaults")
            }
        }
    }
    
    static var uid: String {
        get {
            return UserDefaults.standard.string(forKey: UserKeys.userUID.rawValue) ?? ""
        } set {
            let defaults = UserDefaults.standard
            let key = UserKeys.userUID.rawValue
            
            defaults.set(newValue, forKey: key)
            print("value: \(newValue) was added to key: \(key)")
            
        }
    }
}
