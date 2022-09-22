//
//  LoginViewControllerTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 21/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class LoginViewControllerTests: XCTestCase {
    var sut: LoginViewController!
    var viewModel: LoginViewModel!
    var dependencies: AppDependencyMock!
    
    override func setUp() {
        sut = LoginViewController()
        dependencies = AppDependencyMock()
        viewModel = LoginViewModel(dependencies: dependencies)
        
        sut.bind(to: viewModel)
        
        sut.view.embedIntoMainApplicationWindow()
    }
    
    func testMustInit() {
        // init
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.viewModel)
        
        // UI Elements
        XCTAssertNotNil(sut.backgroundImageView)
        XCTAssertNotNil(sut.formStackView)
        XCTAssertNotNil(sut.userNameTextField)
        XCTAssertNotNil(sut.passwordTextField)
        XCTAssertNotNil(sut.submitButton)
    }
    
    func testMustObserveTextFields() {
        sut.userNameTextField.text = "userName"
        sut.userNameTextField.sendActions(for: .valueChanged)
        XCTAssertEqual(sut.submitButton.isEnabled, false)

        sut.passwordTextField.text = "password"
        sut.passwordTextField.sendActions(for: .valueChanged)
        XCTAssertTrue(sut.submitButton.isEnabled)
    }
    
    func testMustObserveLogin() {
        var uiActions: [UIControl.Event] = []
        
        sut.userNameTextField.text = "userName"
        sut.userNameTextField.sendActions(for: .valueChanged)
        uiActions.append(.valueChanged)
        XCTAssertEqual(sut.submitButton.isEnabled, false)

        sut.passwordTextField.text = "password"
        sut.passwordTextField.sendActions(for: .valueChanged)
        uiActions.append(.valueChanged)
        XCTAssertTrue(sut.submitButton.isEnabled)

        sut.submitButton.sendActions(for: .touchUpInside)
        uiActions.append(.touchUpInside)
        
        XCTAssertEqual(uiActions, [.valueChanged, .valueChanged, .touchUpInside])
    }
    
    
    // TODO: Check how to test becomeFirstResponder
    func testMustObserveKeyboard() {
        sut.userNameTextField.becomeFirstResponder()
        XCTAssertTrue(sut.userNameTextField.isFirstResponder)

        sut.passwordTextField.becomeFirstResponder()
        XCTAssertEqual(sut.passwordTextField.isEditing, true)
    }
}
