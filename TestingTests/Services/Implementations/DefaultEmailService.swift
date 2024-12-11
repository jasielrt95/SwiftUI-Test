//
//  DefaultEmailService.swift
//  TestingTests
//
//  Created by Jasiel Rivera Trinidad on 12/11/24.
//


import Foundation

class DefaultEmailService: EmailService {
    func sendWelcomeEmail(to email: String) {
        print("Welcome email sent to \(email)")
    }
}