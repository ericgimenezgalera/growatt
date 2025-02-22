import API
import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class LogoutUseCaseTests: XCTestCase {
    let username = "fakeUsername"
    var logoutUseCase: LogoutUseCaseImpl!
    var sessionManagerMock: SessionManagerMock!

    override func setUp() {
        logoutUseCase = LogoutUseCaseImpl()
        sessionManagerMock = .init()
        InjectedValues[\.sessionManager] = sessionManagerMock
    }

    func testLogout() {
        logoutUseCase.logout()

        XCTAssertTrue(sessionManagerMock.logoutVoidCalled)
    }
}
