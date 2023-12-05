//
//  ConnectionManagerStub.swift
//  APITests
//
//  Created by Eric Gimènez Galera on 13/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Alamofire
@testable import API
import Foundation
import Mocker

class ConnectionManagerStub: ConnectionManager {
    private var internalSessionManager: Session?

    override var sessionManager: Session {
        guard let internalSessionManager = internalSessionManager else {
            let configuration = URLSessionConfiguration.af.default
            configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
            let sessionManager = Session(configuration: configuration)
            sessionManager.sessionConfiguration.waitsForConnectivity = true
            internalSessionManager = sessionManager
            return sessionManager
        }
        return internalSessionManager
    }
}
