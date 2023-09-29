//
//  SessionManager.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 28/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation

public protocol SessionManager {
    func logout()
}

extension ConnectionManager: SessionManager {
    public func logout() {
        isAuthenticate = false
        jSessionId = ""
        serverId = ""
    }
}
