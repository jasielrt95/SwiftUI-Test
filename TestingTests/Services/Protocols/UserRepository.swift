//
//  UserRepository.swift
//  TestingTests
//
//  Created by Jasiel Rivera Trinidad on 12/11/24.
//


import Foundation

protocol UserRepository {
    func saveUser(_ user: User) throws
    func getUserByEmail(_ email: String) -> User?
}
