//
//  KeychainWrapperImpl.swift
//  KeychainWrapper
//
//  Created by Eric Gimenez on 13/06/2022.
//

import Foundation

public enum KeychainWraperImpl: KeychainWrapper {
    public func set(value: Data, account: String) throws {
        if try KeychainOperations.exists(account: account) {
            try KeychainOperations.update(value: value, account: account)
        } else {
            try KeychainOperations.add(value: value, account: account)
        }
    }

    public func set(value: String, account: String) throws {
        guard let value = value.data(using: .utf8) else {
            throw KeyChainWrapperError.setting
        }

        try set(value: value, account: account)
    }

    public func set(value: Int, account: String) throws {
        try set(value: value.description, account: account)
    }

    public func get(account: String) throws -> Data? {
        if try KeychainOperations.exists(account: account) {
            return try KeychainOperations.retreive(account: account)
        } else {
            throw KeyChainWrapperError.getting
        }
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

    public func delete(account: String) throws {
        if try KeychainOperations.exists(account: account) {
            return try KeychainOperations.delete(account: account)
        }
    }

    public func deleteAll() throws {
        try KeychainOperations.deleteAll()
    }
}
