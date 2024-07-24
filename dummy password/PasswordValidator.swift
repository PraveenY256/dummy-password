//
//  PasswordValidator.swift
//  dummy password
//
//  Created by Praveen Yeddu on 23/07/24.
//

import Foundation

struct PasswordValidator {
    static func isValidLength(password: String) -> Bool {
        return password.count >= 8
    }
    
    static func containsUppercase(password: String) -> Bool {
        let uppercaseLetter = CharacterSet.uppercaseLetters
        return password.rangeOfCharacter(from: uppercaseLetter) != nil
    }
    
    static func containsLowercase(password: String) -> Bool {
        let lowercaseLetter = CharacterSet.lowercaseLetters
        return password.rangeOfCharacter(from: lowercaseLetter) != nil
    }
    
    static func containsDigit(password: String) -> Bool {
        let digit = CharacterSet.decimalDigits
        return password.rangeOfCharacter(from: digit) != nil
    }
    
    static func containsSpecialCharacter(password: String) -> Bool {
        let specialCharacter = CharacterSet(charactersIn: "!@#$%^&*()_-+=<>?")
        return password.rangeOfCharacter(from: specialCharacter) != nil
    }
    
    static func validate(password: String) -> [String] {
        var errors = [String]()
        
        if !isValidLength(password: password) {
            errors.append("Password must be at least 8 characters long")
        }
        if !containsUppercase(password: password) {
            errors.append("Password must contain at least one uppercase letter")
        }
        if !containsLowercase(password: password) {
            errors.append("Password must contain at least one lowercase letter")
        }
        if !containsDigit(password: password) {
            errors.append("Password must contain at least one digit")
        }
        if !containsSpecialCharacter(password: password) {
            errors.append("Password must contain at least one special character")
        }
        
        return errors
    }
}
