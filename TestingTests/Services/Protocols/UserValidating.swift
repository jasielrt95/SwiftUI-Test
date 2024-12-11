//
//  UserValidating.swift
//  TestingTests
//
//  Created by Jasiel Rivera Trinidad on 12/11/24.
//


import Foundation

protocol UserValidating {
    func validate(_ details: UserRegistrationDetails) throws
}