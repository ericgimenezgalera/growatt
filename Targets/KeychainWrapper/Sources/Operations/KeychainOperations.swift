//
//  KeychainOperations.swift
//  KeychainWrapper
//
//  Created by Eric Gimènez Galera on 23/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation

enum KeychainOperations {
    static func add(value: Data, account: String) throws {
        let status = SecItemAdd([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
            kSecValueData: value,
        ] as NSDictionary, nil)
        guard status == errSecSuccess else { throw KeyChainWrapperError.adding(status) }
    }

    static func update(value: Data, account: String) throws {
        let status = SecItemUpdate([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
        ] as NSDictionary, [
            kSecValueData: value,
        ] as NSDictionary)
        guard status == errSecSuccess else { throw KeyChainWrapperError.updating(status) }
    }

    static func retreive(account: String) throws -> Data? {
        var result: AnyObject?

        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: true,
        ] as NSDictionary, &result)

        switch status {
        case errSecSuccess:
            return result as? Data
        case errSecItemNotFound:
            return nil
        default:
            throw KeyChainWrapperError.retriving(status)
        }
    }

    static func delete(account: String) throws {
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
        ] as NSDictionary)
        guard status == errSecSuccess else { throw KeyChainWrapperError.deleting(status) }
    }

    static func deleteAll() throws {
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword,
        ] as NSDictionary)
        guard status == errSecSuccess else { throw KeyChainWrapperError.deletingAll(status) }
    }

    static func exists(account: String) throws -> Bool {
        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: false,
        ] as NSDictionary, nil)

        switch status {
        case errSecSuccess:
            return true
        case errSecItemNotFound:
            return false
        default:
            return true
            // throw KeyChainWrapperError.exists(status)
        }
    }
}
