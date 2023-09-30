import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class SettingsModelTests: XCTestCase {
    var model: SettingsModelImpl!
    var sessionManagerMock: SessionManagerMock!

    override func setUp() {
        model = SettingsModelImpl()
        sessionManagerMock = SessionManagerMock()
        InjectedValues[\.sessionManager] = sessionManagerMock
    }

    func test_logout() {
        let logoutExpectation = expectation(description: "Logout success")
        sessionManagerMock.logoutExpectation = logoutExpectation
        model.logout()

        wait(for: [logoutExpectation])
    }
}
