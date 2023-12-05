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
        guard let cookies = HTTPCookieStorage.shared.cookies else {
            return
        }

        for cookie in cookies {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }
}
