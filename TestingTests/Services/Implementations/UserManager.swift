//
//  UserManager.swift
//  TestingTests
//
//  Created by Jasiel Rivera Trinidad on 12/11/24.
//


import Foundation

class UserManager: UserManaging {
    private let validator: UserValidating
    private let repository: UserRepository
    private let emailService: EmailService
    
    init(
        validator: UserValidating = UserValidator(),
        repository: UserRepository = InMemoryUserRepository(),
        emailService: EmailService = DefaultEmailService()
    ) {
        self.validator = validator
        self.repository = repository
        self.emailService = emailService
    }
    
    func registerUser(_ details: UserRegistrationDetails) throws {
        try validator.validate(details)
        
        let user = User(
            firstName: details.firstName,
            lastName: details.lastName,
            email: details.email,
            password: details.password,
            age: details.age
        )
        
        try repository.saveUser(user)
        emailService.sendWelcomeEmail(to: details.email)
    }
    
    func authenticateUser(email: String, password: String) throws -> Bool {
        guard let user = repository.getUserByEmail(email) else {
            throw UserError.userNotFound
        }
        
        guard user.password == password else {
            throw UserError.invalidCredentials
        }
        
        return true
    }
}