//
//  KeychainWrapper.swift
//  KeychainWrapper
//
//  Created by Eric Gimenez on 13/06/2022.
//

import Foundation

public protocol KeychainWrapper {
    func set(value: Data, account: String) throws
    func set(value: String, account: String) throws
    func set(value: Int, account: String) throws
    func get(account: String) throws -> Data?
    func get(account: String) throws -> String?
    func get(account: String) throws -> Int?
    func delete(account: String) throws
    func deleteAll() throws
}
