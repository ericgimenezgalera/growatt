import API
import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class LoginModelTests: XCTestCase {
    let username = "fakeUsername"
    let password = "fakePassword"
    var loginModel: LoginModelImpl!
    var authorizationServiceMock: AuthorizationServiceMock!
    var keychainWrapperMock: KeychainWrapperMock!
    var laContextMock: LAContextStub!

    override func setUp() {
        laContextMock = LAContextStub()
        loginModel = LoginModelImpl()
        loginModel.context = laContextMock
        authorizationServiceMock = AuthorizationServiceMock()
        keychainWrapperMock = KeychainWrapperMock()
        InjectedValues[\.authorizationService] = authorizationServiceMock
        InjectedValues[\.keychainWrapper] = keychainWrapperMock
    }

    func testLoginSuccess() async {
        authorizationServiceMock.success = true

        let loginResult = await loginModel.login(username: username, password: password)

        XCTAssertTrue(loginResult)
        XCTAssertEqual(
            authorizationServiceMock.authentication,
            AuthenticationRequest(account: username, password: password)
        )
    }

    func testLoginDenied() async {
        authorizationServiceMock.success = false

        let loginResult = await loginModel.login(username: username, password: password)

        XCTAssertFalse(loginResult)
    }

    func testBiometricSuccess() async {
        authorizationServiceMock.success = true
        try? keychainWrapperMock.set(value: password, account: passwordKeychainAccount)

        let loginResult = await loginModel.loginWithBiometric(username: username)

        XCTAssertTrue(loginResult)
        XCTAssertEqual(
            authorizationServiceMock.authentication,
            AuthenticationRequest(account: username, password: password)
        )
    }

    func testBiometricFailsReasonNoStoredPassword() async {
        authorizationServiceMock.success = true

        let loginResult = await loginModel.loginWithBiometric(username: username)

        XCTAssertFalse(loginResult)
        XCTAssertNil(authorizationServiceMock.authentication)
    }

    func testBiometricFailsReasonEmptyUsername() async {
        authorizationServiceMock.success = true
        try? keychainWrapperMock.set(value: password, account: passwordKeychainAccount)

        let loginResult = await loginModel.loginWithBiometric(username: "")

        XCTAssertFalse(loginResult)
        XCTAssertNil(authorizationServiceMock.authentication)
    }

    func testBiometricFailsDeviceWithoutBiometric() async {
        authorizationServiceMock.success = true
        try? keychainWrapperMock.set(value: password, account: passwordKeychainAccount)
        laContextMock.canEvaluatePolicyResult = false

        let loginResult = await loginModel.loginWithBiometric(username: username)

        XCTAssertFalse(loginResult)
        XCTAssertNil(authorizationServiceMock.authentication)
    }

    func testBiometricFailsBiometricFails() async {
        authorizationServiceMock.success = true
        try? keychainWrapperMock.set(value: password, account: passwordKeychainAccount)
        laContextMock.evaluatePolicy = false

        let loginResult = await loginModel.loginWithBiometric(username: username)

        XCTAssertFalse(loginResult)
        XCTAssertNil(authorizationServiceMock.authentication)
    }

    func testBiometricFailsBiometricThrowError() async {
        authorizationServiceMock.success = true
        try? keychainWrapperMock.set(value: password, account: passwordKeychainAccount)
        laContextMock.evaluateThowError = true

        let loginResult = await loginModel.loginWithBiometric(username: username)

        XCTAssertFalse(loginResult)
        XCTAssertNil(authorizationServiceMock.authentication)
    }
}
