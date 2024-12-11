//
//  InMemoryUserRepository.swift
//  TestingTests
//
//  Created by Jasiel Rivera Trinidad on 12/11/24.
//


import Foundation

class InMemoryUserRepository: UserRepository {
    private var users: [User] = []
    
    func saveUser(_ user: User) throws {
        users.append(user)
    }
    
    func getUserByEmail(_ email: String) -> User? {
        return users.first { $0.email == email }
    }
}