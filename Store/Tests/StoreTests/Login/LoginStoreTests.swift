import XCTest
import Combine
@testable import Store

final class LoginStoreTests: XCTestCase {
    var subscriptions: Set<AnyCancellable> = []
    
    func test_isValid() {
        let delegate = LoginDelegateSpy()
        let networking = MockLoginNetworking(token: nil, error: nil)
        let sut = LoginStore(network: networking, delegate: delegate)
        XCTAssertEqual(sut.isValid, false)
        sut.username = "username"
        XCTAssertEqual(sut.isValid, false)
        sut.password = "password"
        XCTAssertEqual(sut.isValid, true)
    }
    
    func test_authentication_whenNotValid() {
        let delegate = LoginDelegateSpy()
        let networking = MockLoginNetworking(token: nil, error: nil)
        let sut = LoginStore(network: networking, delegate: delegate)
        XCTAssertEqual(sut.isValid, false)
        
        var capturedError: Login.Error?
        let exp = expectation(description: "waiting for error")
        
        sut.$error
            .dropFirst()
            .filter { $0 != nil }
            .sink(receiveValue: { error in
                capturedError = error
                exp.fulfill()
            })
            .store(in: &subscriptions)
        
        sut.authenticate()
        
        waitForExpectations(timeout: 0.5)
        XCTAssertEqual(capturedError, .missingInput)
    }
}
