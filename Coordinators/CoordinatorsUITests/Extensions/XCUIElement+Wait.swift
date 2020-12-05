//
//  Created by Maciej Gorecki on 05/12/2020.
//

import XCTest

extension XCUIElement {
    /// Waits for the element to be hittable
    ///
    /// - Parameter timeout: the maximum waiting time
    /// - Returns: true if the element is hittable, false if not
    @discardableResult func waitForHittable(
        timeout: TimeInterval = defaultTimeout
    ) -> Bool {
        let predicate = NSPredicate(format: "hittable == 1")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }
}

let defaultTimeout: TimeInterval = 6
let shortTimeout: TimeInterval = 0.1
