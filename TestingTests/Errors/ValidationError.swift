//
//  ValidationError.swift
//  TestingTests
//
//  Created by Jasiel Rivera Trinidad on 12/11/24.
//


import Foundation

enum ValidationError: Error, Equatable {
    case emptyField(String)
    case invalidEmail
    case invalidPassword
    case invalidAge
}
