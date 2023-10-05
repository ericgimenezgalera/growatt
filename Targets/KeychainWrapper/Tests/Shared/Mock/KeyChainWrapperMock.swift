//
//  KeyChainWrapperMock.swift
//  KeychainWrapperTests
//
//  Created by Eric Gimènez Galera on 3/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import KeychainWrapper

public enum KeychainWrapperError: Error {
    case invalidValue
}

public class KeychainWrapperMock: KeychainWrapper {
    public var values: [String: Data] = [:]

    public func exists(account: String) throws -> Bool {
        values[account] != nil
    }

    public func set(value: Data, account: String) throws {
        values[account] = value
    }

    public func set(value: String, account: String) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainWrapperError.invalidValue
        }

        try set(value: data, account: account)
    }

    public func set(value: Int, account: String) throws {
        try set(value: "\(value)", account: account)
    }

    public func set(value: Bool, account: String) throws {
        try set(value: value.description, account: account)
    }

    public func get(account: String) throws -> Data? {
        values[account]
    }

    public func get(account: String) throws -> String? {
        guard let data: Data = try get(account: account) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    public func get(account: String) throws -> Int? {
        guard let string: String = try get(account: account) else {
            return nil
        }

        return Int(string)
    }

    public func get(account: String) throws -> Bool? {
        guard let string: String = try get(account: account) else {
            return nil
        }

        return Bool(string)
    }

    public func delete(account: String) throws {
        values.removeValue(forKey: account)
    }

    public func deleteAll() throws {
        values = [:]
    }
}
