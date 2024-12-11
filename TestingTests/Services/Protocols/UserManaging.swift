//
//  UserManaging.swift
//  TestingTests
//
//  Created by Jasiel Rivera Trinidad on 12/11/24.
//


import Foundation

protocol UserManaging {
    func registerUser(_ details: UserRegistrationDetails) throws
    func authenticateUser(email: String, password: String) throws -> Bool
}