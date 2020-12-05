//
//  Created by Maciej Gorecki on 05/12/2020.
//

import XCTest

@discardableResult
func login(
    _ defaultQuery: XCUIElement,
    file: StaticString = #file,
    line: UInt = #line,
    closure: (LoginRobot) -> Void = { _ in }
) -> LoginRobot {
    let robot = LoginRobot(
        defaultQuery: defaultQuery,
        file: file,
        line: line
    )
    closure(robot)
    return robot
}
