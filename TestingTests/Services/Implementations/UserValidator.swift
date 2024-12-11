//
//  UserValidator.swift
//  TestingTests
//
//  Created by Jasiel Rivera Trinidad on 12/11/24.
//


import Foundation

class UserValidator: UserValidating {
    func validate(_ details: UserRegistrationDetails) throws {
        if details.firstName.isEmpty {
            throw ValidationError.emptyField("First name")
        }
        if details.lastName.isEmpty {
            throw ValidationError.emptyField("Last name")
        }
        if details.email.isEmpty {
            throw ValidationError.emptyField("Email")
        }
        if !isValidEmail(details.email) {
            throw ValidationError.invalidEmail
        }
        if details.password.count < 6 {
            throw ValidationError.invalidPassword
        }
        if details.age < 18 {
            throw ValidationError.invalidAge
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        return email.contains("@")
    }
}