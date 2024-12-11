//
//  TestingTestsTests.swift
//  TestingTestsTests
//
//  Created by Jasiel Rivera Trinidad on 12/11/24.
//

import XCTest
@testable import TestingTests

class MockUserValidator: UserValidating {
    var shouldValidate = true
    
    func validate(_ details: UserRegistrationDetails) throws {
        if !shouldValidate {
            throw ValidationError.invalidEmail
        }
    }
}

class MockUserRepository: UserRepository {
    var savedUsers: [User] = []
    var userToReturn: User?
    
    func saveUser(_ user: User) throws {
        savedUsers.append(user)
    }
    
    func getUserByEmail(_ email: String) -> User? {
        return userToReturn
    }
}

class MockEmailService: EmailService {
    var emailsSent: [String] = []
    
    func sendWelcomeEmail(to email: String) {
        emailsSent.append(email)
    }
}

class UserManagerTests: XCTestCase {
    var userManager: UserManager!
    var mockValidator: MockUserValidator!
    var mockRepository: MockUserRepository!
    var mockEmailService: MockEmailService!
    
    override func setUp() {
        super.setUp()
        mockValidator = MockUserValidator()
        mockRepository = MockUserRepository()
        mockEmailService = MockEmailService()
        userManager = UserManager(
            validator: mockValidator,
            repository: mockRepository,
            emailService: mockEmailService
        )
    }
    
    func testSuccessfulUserRegistration() throws {
        let details = UserRegistrationDetails(
            firstName: "John",
            lastName: "Doe",
            email: "john@example.com",
            password: "password123",
            age: 25
        )
        mockValidator.shouldValidate = true
        
        try userManager.registerUser(details)
        
        XCTAssertEqual(mockRepository.savedUsers.count, 1)
        XCTAssertEqual(mockEmailService.emailsSent.count, 1)
        XCTAssertEqual(mockEmailService.emailsSent.first, details.email)
    }
    
    func testRegistrationFailsWithInvalidData() {
        let details = UserRegistrationDetails(
            firstName: "John",
            lastName: "Doe",
            email: "invalid-email",
            password: "password123",
            age: 25
        )
        mockValidator.shouldValidate = false
        
        XCTAssertThrowsError(try userManager.registerUser(details)) { error in
            XCTAssertEqual(error as? ValidationError, .invalidEmail)
        }
        XCTAssertEqual(mockRepository.savedUsers.count, 0)
        XCTAssertEqual(mockEmailService.emailsSent.count, 0)
    }
    
    func testSuccessfulAuthentication() throws {
        let email = "john@example.com"
        let password = "password123"
        let user = User(firstName: "John", lastName: "Doe", email: email, password: password, age: 25)
        mockRepository.userToReturn = user
        
        let result = try userManager.authenticateUser(email: email, password: password)
        
        XCTAssertTrue(result)
    }
    
    func testAuthenticationFailsWithWrongPassword() {
        let email = "john@example.com"
        let user = User(firstName: "John", lastName: "Doe", email: email, password: "correctpass", age: 25)
        mockRepository.userToReturn = user
        
        XCTAssertThrowsError(try userManager.authenticateUser(email: email, password: "wrongpass")) { error in
            XCTAssertEqual(error as? UserError, .invalidCredentials)
        }
    }
    
    func testAuthenticationFailsWithNonexistentUser() {
        mockRepository.userToReturn = nil
        
        XCTAssertThrowsError(try userManager.authenticateUser(email: "nonexistent@example.com", password: "any")) { error in
            XCTAssertEqual(error as? UserError, .userNotFound)
        }
    }
}
