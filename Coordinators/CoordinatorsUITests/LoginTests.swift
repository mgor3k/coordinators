//
//  Created by Maciej Gorecki on 05/12/2020.
//

import XCTest

class LoginTests: XCTestCase {
    func test_enablingLoginButton() throws {
        let app = XCUIApplication()
        app.launch()
        
        login(app) {
            $0.loginButtonShouldBeEnabled(false)
            $0.tapUsername()
            $0.typeUsername("some username")
            $0.loginButtonShouldBeEnabled(false)
            $0.tapPassword()
            $0.typePassword("some password")
            $0.loginButtonShouldBeEnabled(true)
        }
    }
}
