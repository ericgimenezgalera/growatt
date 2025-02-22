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
class GetPlantDetailsUseCaseMock: GetPlantDetailsUseCase {




    //MARK: - getPlantData

    var getPlantDataPlantDetailsCallsCount = 0
    var getPlantDataPlantDetailsCalled: Bool {
        return getPlantDataPlantDetailsCallsCount > 0
    }
    var getPlantDataPlantDetailsReturnValue: PlantDetails?
    var getPlantDataPlantDetailsClosure: (() async -> PlantDetails?)?

    func getPlantData() async -> PlantDetails? {
        getPlantDataPlantDetailsCallsCount += 1
        if let getPlantDataPlantDetailsClosure = getPlantDataPlantDetailsClosure {
            return await getPlantDataPlantDetailsClosure()
        } else {
            return getPlantDataPlantDetailsReturnValue
        }
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
class LogoutUseCaseMock: LogoutUseCase {




    //MARK: - logout

    var logoutVoidCallsCount = 0
    var logoutVoidCalled: Bool {
        return logoutVoidCallsCount > 0
    }
    var logoutVoidClosure: (() -> Void)?

    func logout() {
        logoutVoidCallsCount += 1
        logoutVoidClosure?()
    }


}
public class NavigationViewModelMock: NavigationViewModel {

    public init() {}



    //MARK: - navigate

    public var navigateRouteAnyHashableVoidCallsCount = 0
    public var navigateRouteAnyHashableVoidCalled: Bool {
        return navigateRouteAnyHashableVoidCallsCount > 0
    }
    public var navigateRouteAnyHashableVoidReceivedRoute: (any Hashable)?
    public var navigateRouteAnyHashableVoidReceivedInvocations: [(any Hashable)] = []
    public var navigateRouteAnyHashableVoidClosure: ((any Hashable) async -> Void)?

    public func navigate(route: any Hashable) async {
        navigateRouteAnyHashableVoidCallsCount += 1
        navigateRouteAnyHashableVoidReceivedRoute = route
        navigateRouteAnyHashableVoidReceivedInvocations.append(route)
        await navigateRouteAnyHashableVoidClosure?(route)
    }


}
public class PlantServiceMock: PlantService {

    public init() {}



    //MARK: - plantList

    public var plantListPlantDetailsThrowableError: (any Error)?
    public var plantListPlantDetailsCallsCount = 0
    public var plantListPlantDetailsCalled: Bool {
        return plantListPlantDetailsCallsCount > 0
    }
    public var plantListPlantDetailsReturnValue: PlantDetails!
    public var plantListPlantDetailsClosure: (() async throws -> PlantDetails)?

    public func plantList() async throws -> PlantDetails {
        plantListPlantDetailsCallsCount += 1
        if let error = plantListPlantDetailsThrowableError {
            throw error
        }
        if let plantListPlantDetailsClosure = plantListPlantDetailsClosure {
            return try await plantListPlantDetailsClosure()
        } else {
            return plantListPlantDetailsReturnValue
        }
    }

    //MARK: - socialContribution

    public var socialContributionSocialContributionThrowableError: (any Error)?
    public var socialContributionSocialContributionCallsCount = 0
    public var socialContributionSocialContributionCalled: Bool {
        return socialContributionSocialContributionCallsCount > 0
    }
    public var socialContributionSocialContributionReturnValue: SocialContribution!
    public var socialContributionSocialContributionClosure: (() async throws -> SocialContribution)?

    public func socialContribution() async throws -> SocialContribution {
        socialContributionSocialContributionCallsCount += 1
        if let error = socialContributionSocialContributionThrowableError {
            throw error
        }
        if let socialContributionSocialContributionClosure = socialContributionSocialContributionClosure {
            return try await socialContributionSocialContributionClosure()
        } else {
            return socialContributionSocialContributionReturnValue
        }
    }


}
public class SessionManagerMock: SessionManager {

    public init() {}



    //MARK: - logout

    public var logoutVoidCallsCount = 0
    public var logoutVoidCalled: Bool {
        return logoutVoidCallsCount > 0
    }
    public var logoutVoidClosure: (() -> Void)?

    public func logout() {
        logoutVoidCallsCount += 1
        logoutVoidClosure?()
    }


}
