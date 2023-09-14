import Foundation
@testable import UIFramework
import XCTest

final class LoginModelTests: XCTestCase {
    let username = "fakeUsername"
    let password = "fakePassword"
    var loginModel: LoginModel!
    var authorizationServiceMock: AuthorizationServiceMock!

    override func setUp() {
        loginModel = LoginModelImpl()
        authorizationServiceMock = AuthorizationServiceMock()
        InjectedValues[\.authorizationService] = authorizationServiceMock
    }

    func test_success() async {
        authorizationServiceMock.success = true

        let loginResult = await loginModel.login(username: username, password: password)

        XCTAssertTrue(loginResult)
    }

    func test_denied() async {
        authorizationServiceMock.success = false

        let loginResult = await loginModel.login(username: username, password: password)

        XCTAssertFalse(loginResult)
    }
}
