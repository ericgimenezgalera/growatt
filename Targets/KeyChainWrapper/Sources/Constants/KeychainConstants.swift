//
//  KeychainConstants.swift
//  KeychainWrapper
//
//  Created by Eric Gimènez Galera on 23/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation

let service: String = "GrowattService"

enum KeyChainWrapperError: Error {
    case creating
    case getting
    case setting
    case adding(_ osStatus: OSStatus)
    case updating(_ osStatus: OSStatus)
    case retriving(_ osStatus: OSStatus)
    case deleting(_ osStatus: OSStatus)
    case deletingAll(_ osStatus: OSStatus)
    case exists(_ osStatus: OSStatus)
}
