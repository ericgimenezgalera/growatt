//
//  KeychainWrapperStub.swift
//  APITests
//
//  Created by Eric Gimènez Galera on 26/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import KeychainWrapper

enum KeychainWrapperError: Error {
    case invalidValue
}

class KeychainWrapperStub: KeychainWrapper {
    var values: [String: Data] = [:]

    func set(value: Data, account: String) throws {
        values[account] = value
    }

    func set(value: String, account: String) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainWrapperError.invalidValue
        }

        try set(value: data, account: account)
    }

    func set(value: Int, account: String) throws {
        try set(value: "\(value)", account: account)
    }

    func get(account: String) throws -> Data? {
        values[account]
    }

    func get(account: String) throws -> String? {
        guard let data: Data = try get(account: account) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func get(account: String) throws -> Int? {
        guard let string: String = try get(account: account) else {
            return nil
        }

        return Int(string)
    }

    func delete(account: String) throws {
        values.removeValue(forKey: account)
    }

    func deleteAll() throws {
        values = [:]
    }
}