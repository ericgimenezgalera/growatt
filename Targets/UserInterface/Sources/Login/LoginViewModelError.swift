//
//  Untitled.swift
//  Growatt
//
//  Created by Eric Gimenez on 16/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//
import Foundation

enum LoginViewModelError: LocalizedError {
    case invalidPassword

    var errorDescription: String? {
        switch self {
        case .invalidPassword:
            return "Invalid password, please try again"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .invalidPassword:
            return "Login failed with this user and password, please change it and try again"
        }
    }
}
