//
//  Created by Maciej Gorecki on 05/12/2020.
//

import XCTest

final class LoginRobot {
    private let defaultQuery: XCUIElement
    
    init(
        defaultQuery: XCUIElement,
        file: StaticString = #file,
        line: UInt = #line) {
        self.defaultQuery = defaultQuery
        XCTAssertTrue(defaultQuery.waitForExistence(timeout: shortTimeout), "Login doesn't exist")
    }
}

extension LoginRobot {
    func loginButtonShouldBeEnabled(_ enabled: Bool, file: StaticString = #file, line: UInt = #line) {
        let button = defaultQuery.buttons[Keys.Buttons.login]
        XCTAssertEqual(button.isEnabled, enabled)
    }
    
    func tapUsername(file: StaticString = #file, line: UInt = #line) {
        tapTextField(Keys.TextFields.username, file: file, line: line)
    }
    
    func typeUsername(_ username: String, file: StaticString = #file, line: UInt = #line) {
        typeInTextField(Keys.TextFields.username, string: username, file: file, line: line)
    }
    
    func typePassword(_ password: String, file: StaticString = #file, line: UInt = #line) {
        typeInTextField(Keys.TextFields.password, string: password, isSecure: true, file: file, line: line)
    }
    
    func tapPassword(file: StaticString = #file, line: UInt = #line) {
        tapTextField(Keys.TextFields.password, isSecure: true, file: file, line: line)
    }
}

private extension LoginRobot {
    func tapTextField(
        _ textField: String,
        isSecure: Bool = false,
        file: StaticString = #file,
        line: UInt = #line) {
        let textField = isSecure ? defaultQuery.secureTextFields[textField] : defaultQuery.textFields[textField]
        XCTAssertTrue(textField.waitForHittable(), "TextField is not visible", file: file, line: line)
        XCTAssertTrue(textField.exists, file: file, line: line)
        textField.tap()
    }
    
    func typeInTextField(
        _ textField: String,
        string: String,
        isSecure: Bool = false,
        file: StaticString = #file,
        line: UInt = #line) {
        let textField = isSecure ? defaultQuery.secureTextFields[textField] : defaultQuery.textFields[textField]
        XCTAssertTrue(textField.exists)
        textField.typeText(string)
    }
}
