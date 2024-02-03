//
//  UserModel.swift
//  RutApp
//
//  Created by Michael Kivo on 03/02/2024.
//

import Foundation

final class UserModel {
    
    private enum UserKeys: String {
        case userEmail, userPassword, userFio, userInstitute, userUID
    }
    
    private static let defaults = UserDefaults.standard
    
    static var email: String {
        get {
            return defaults.string(forKey: UserKeys.userEmail.rawValue) ?? ""
        } set {
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
            return defaults.string(forKey: UserKeys.userPassword.rawValue) ?? ""
        } set {
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
            return defaults.string(forKey: UserKeys.userFio.rawValue) ?? ""
        } set {
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
            return defaults.string(forKey: UserKeys.userInstitute.rawValue) ?? ""
        } set {
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
            return defaults.string(forKey: UserKeys.userUID.rawValue) ?? ""
        } set {
            let key = UserKeys.userUID.rawValue
            
            defaults.set(newValue, forKey: key)
            print("value: \(newValue) was added to key: \(key)")
            
        }
    }
    
    static func synchronize() {
        defaults.synchronize()
    }
    
    static func deleteUser() {
        defaults.removeObject(forKey: UserKeys.userEmail.rawValue)
        defaults.removeObject(forKey: UserKeys.userPassword.rawValue)
        defaults.removeObject(forKey: UserKeys.userFio.rawValue)
        defaults.removeObject(forKey: UserKeys.userInstitute.rawValue)
        defaults.removeObject(forKey: UserKeys.userUID.rawValue)
        
        synchronize()
    }
}
