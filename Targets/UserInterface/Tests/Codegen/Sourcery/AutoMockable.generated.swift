// Generated using Sourcery 2.2.6 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import API

@testable import UserInterface
























public class AuthorizationServiceMock: AuthorizationService {

    public init() {}



    //MARK: - authorise

    public var authoriseAuthenticationAuthenticationRequestVoidThrowableError: (any Error)?
    public var authoriseAuthenticationAuthenticationRequestVoidCallsCount = 0
    public var authoriseAuthenticationAuthenticationRequestVoidCalled: Bool {
        return authoriseAuthenticationAuthenticationRequestVoidCallsCount > 0
    }
    public var authoriseAuthenticationAuthenticationRequestVoidReceivedAuthentication: (AuthenticationRequest)?
    public var authoriseAuthenticationAuthenticationRequestVoidReceivedInvocations: [(AuthenticationRequest)] = []
    public var authoriseAuthenticationAuthenticationRequestVoidClosure: ((AuthenticationRequest) async throws -> Void)?

    public func authorise(authentication: AuthenticationRequest) async throws {
        authoriseAuthenticationAuthenticationRequestVoidCallsCount += 1
        authoriseAuthenticationAuthenticationRequestVoidReceivedAuthentication = authentication
        authoriseAuthenticationAuthenticationRequestVoidReceivedInvocations.append(authentication)
        if let error = authoriseAuthenticationAuthenticationRequestVoidThrowableError {
            throw error
        }
        try await authoriseAuthenticationAuthenticationRequestVoidClosure?(authentication)
    }


}
class LoginUseCaseMock: LoginUseCase {




    //MARK: - login

    var loginUsernameStringPasswordStringBoolCallsCount = 0
    var loginUsernameStringPasswordStringBoolCalled: Bool {
        return loginUsernameStringPasswordStringBoolCallsCount > 0
    }
    var loginUsernameStringPasswordStringBoolReceivedArguments: (username: String, password: String)?
    var loginUsernameStringPasswordStringBoolReceivedInvocations: [(username: String, password: String)] = []
    var loginUsernameStringPasswordStringBoolReturnValue: Bool!
    var loginUsernameStringPasswordStringBoolClosure: ((String, String) async -> Bool)?

    func login(username: String, password: String) async -> Bool {
        loginUsernameStringPasswordStringBoolCallsCount += 1
        loginUsernameStringPasswordStringBoolReceivedArguments = (username: username, password: password)
        loginUsernameStringPasswordStringBoolReceivedInvocations.append((username: username, password: password))
        if let loginUsernameStringPasswordStringBoolClosure = loginUsernameStringPasswordStringBoolClosure {
            return await loginUsernameStringPasswordStringBoolClosure(username, password)
        } else {
            return loginUsernameStringPasswordStringBoolReturnValue
        }
    }

    //MARK: - loginWithBiometric

    var loginWithBiometricUsernameStringBoolCallsCount = 0
    var loginWithBiometricUsernameStringBoolCalled: Bool {
        return loginWithBiometricUsernameStringBoolCallsCount > 0
    }
    var loginWithBiometricUsernameStringBoolReceivedUsername: (String)?
    var loginWithBiometricUsernameStringBoolReceivedInvocations: [(String)] = []
    var loginWithBiometricUsernameStringBoolReturnValue: Bool!
    var loginWithBiometricUsernameStringBoolClosure: ((String) async -> Bool)?

    func loginWithBiometric(username: String) async -> Bool {
        loginWithBiometricUsernameStringBoolCallsCount += 1
        loginWithBiometricUsernameStringBoolReceivedUsername = username
        loginWithBiometricUsernameStringBoolReceivedInvocations.append(username)
        if let loginWithBiometricUsernameStringBoolClosure = loginWithBiometricUsernameStringBoolClosure {
            return await loginWithBiometricUsernameStringBoolClosure(username)
        } else {
            return loginWithBiometricUsernameStringBoolReturnValue
        }
    }


}
