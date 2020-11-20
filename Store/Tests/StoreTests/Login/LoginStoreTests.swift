import XCTest
import Combine
@testable import Store

final class LoginStoreTests: XCTestCase {
    let delegate = LoginDelegateSpy()
    let networking = MockLoginNetworking()
    lazy var sut = LoginStore(network: networking, delegate: delegate)
    
    var subscriptions: Set<AnyCancellable> = []
    
    func test_isValid() {
        XCTAssertEqual(sut.isValid, false)
        sut.username = "username"
        XCTAssertEqual(sut.isValid, false)
        sut.password = "password"
        XCTAssertEqual(sut.isValid, true)
    }
    
    func test_authentication_whenNotValid() {
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
    
    func test_authentication_whenSuccess() {
        delegate.didAuthenticateExp = expectation(description: "waiting for token")
        networking.token = "123"
        
        sut.username = "some username"
        sut.password = "some password"
        
        sut.authenticate()
        waitForExpectations(timeout: 1)
        XCTAssertEqual(delegate.tokenReceived, "123")
        XCTAssertEqual(sut.error, nil)
        XCTAssertEqual(networking.callCount, 1)
    }
    
    func test_isLoading() {
        delegate.didAuthenticateExp = expectation(description: "expecting to finish")
        networking.token = "123"
        
        sut.username = "some username"
        sut.password = "some password"
        
        var isLoadingHistory: [Bool] = []
        
        sut.$isLoading
            .sink(receiveValue: { isLoading in
                isLoadingHistory.append(isLoading)
            })
            .store(in: &subscriptions)
        
        sut.authenticate()
        waitForExpectations(timeout: 1)
        XCTAssertEqual(networking.callCount, 1)
        XCTAssertEqual(isLoadingHistory, [false, true, false])
    }
    
    func test_navigation() {
        sut.navigate(to: .remindPassword)
        sut.navigate(to: .signup)
        
        XCTAssertEqual(delegate.navigationHistory, [.remindPassword, .signup])
    }
}
