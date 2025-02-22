import API
import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class LoginUseCaseTests: XCTestCase {
    let username = "fakeUsername"
    let password = "fakePassword"
    var loginUseCase: LoginUseCaseImpl!
    var authorizationServiceMock: AuthorizationServiceMock!
    var keychainWrapperMock: KeychainWrapperMock!
    var laContextMock: LAContextStub!

    override func setUp() {
        laContextMock = LAContextStub()
        loginUseCase = LoginUseCaseImpl()
        loginUseCase.context = laContextMock
        authorizationServiceMock = AuthorizationServiceMock()
        keychainWrapperMock = KeychainWrapperMock()
        InjectedValues[\.authorizationService] = authorizationServiceMock
        InjectedValues[\.keychainWrapper] = keychainWrapperMock
    }

    func testLoginSuccess() async {
        let loginResult = await loginUseCase.login(username: username, password: password)

        XCTAssertTrue(loginResult)
        XCTAssertTrue(authorizationServiceMock.authoriseAuthenticationAuthenticationRequestVoidCalled)
        XCTAssertEqual(try? keychainWrapperMock.get(account: passwordKeychainAccount), password)
    }

    func testLoginDenied() async {
        authorizationServiceMock.authoriseAuthenticationAuthenticationRequestVoidThrowableError = NSError(domain: "Error", code: -1)

        let loginResult = await loginUseCase.login(username: username, password: password)

        XCTAssertFalse(loginResult)
        XCTAssertTrue(authorizationServiceMock.authoriseAuthenticationAuthenticationRequestVoidCalled)
        XCTAssertNil(try? (keychainWrapperMock.get(account: passwordKeychainAccount) as String?))
    }

    func testBiometricSuccess() async {
        try? keychainWrapperMock.set(value: password, account: passwordKeychainAccount)

        let loginResult = await loginUseCase.loginWithBiometric(username: username)

        XCTAssertTrue(loginResult)
        XCTAssertTrue(authorizationServiceMock.authoriseAuthenticationAuthenticationRequestVoidCalled)
        XCTAssertEqual(try? keychainWrapperMock.get(account: passwordKeychainAccount), password)
    }

    func testBiometricFailsReasonNoStoredPassword() async {
        let loginResult = await loginUseCase.loginWithBiometric(username: username)

        XCTAssertFalse(loginResult)
        XCTAssertFalse(authorizationServiceMock.authoriseAuthenticationAuthenticationRequestVoidCalled)
    }

    func testBiometricFailsReasonEmptyUsername() async {
        try? keychainWrapperMock.set(value: password, account: passwordKeychainAccount)

        let loginResult = await loginUseCase.loginWithBiometric(username: "")

        XCTAssertFalse(loginResult)
        XCTAssertFalse(authorizationServiceMock.authoriseAuthenticationAuthenticationRequestVoidCalled)
    }

    func testBiometricFailsDeviceWithoutBiometric() async {
        try? keychainWrapperMock.set(value: password, account: passwordKeychainAccount)
        laContextMock.canEvaluatePolicyResult = false

        let loginResult = await loginUseCase.loginWithBiometric(username: username)

        XCTAssertFalse(loginResult)
        XCTAssertFalse(authorizationServiceMock.authoriseAuthenticationAuthenticationRequestVoidCalled)
    }

    func testBiometricFailsBiometricFails() async {
        try? keychainWrapperMock.set(value: password, account: passwordKeychainAccount)
        laContextMock.evaluatePolicy = false

        let loginResult = await loginUseCase.loginWithBiometric(username: username)

        XCTAssertFalse(loginResult)
        XCTAssertFalse(authorizationServiceMock.authoriseAuthenticationAuthenticationRequestVoidCalled)
    }

    func testBiometricFailsBiometricThrowError() async {
        try? keychainWrapperMock.set(value: password, account: passwordKeychainAccount)
        laContextMock.evaluateThowError = true

        let loginResult = await loginUseCase.loginWithBiometric(username: username)

        XCTAssertFalse(loginResult)
        XCTAssertFalse(authorizationServiceMock.authoriseAuthenticationAuthenticationRequestVoidCalled)
    }
}
