//
//  Created by Maciej Gorecki on 20/11/2020.
//

import XCTest
import Combine
@testable import Store

final class SignupTests: XCTestCase {
    let delegate = SignupDelegateSpy()
    let networking = MockSignupNetworking()
    lazy var sut = SignupStore(network: networking, delegate: delegate)
    var subscriptions: Set<AnyCancellable> = []
    
    func test_isValid() {
        XCTAssertEqual(sut.isValid, false)
        sut.username = "username"
        XCTAssertEqual(sut.isValid, false)
        sut.password = "password"
        XCTAssertEqual(sut.isValid, false)
        sut.email = "test@test.com"
        XCTAssertEqual(sut.isValid, true)
    }
    
    func test_isLoading() {
        delegate.didSignupExp = expectation(description: "expecting to finish")
        networking.token = "123"
        
        sut.username = "some username"
        sut.password = "some password"
        sut.email = "test@test.com"
        
        var isLoadingHistory: [Bool] = []
        
        sut.$isLoading
            .sink(receiveValue: { isLoading in
                isLoadingHistory.append(isLoading)
            })
            .store(in: &subscriptions)
        
        sut.signup()
        waitForExpectations(timeout: 1)
        XCTAssertEqual(networking.callCount, 1)
        XCTAssertEqual(isLoadingHistory, [false, true, false])
    }
}
