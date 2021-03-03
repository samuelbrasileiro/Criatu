//
//  CriatuUITests.swift
//  CriatuUITests
//
//  Created by Danilo Araújo on 02/03/21.
//

import XCTest

class CriatuUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRedirectButtonExists() throws {
        let app = XCUIApplication()
        app.launch()
        //Soma dos itens escolhidos = 6
        sleep(4)
        
        let buttonsQuery = app.buttons.matching(identifier: "ImageButton")
        
        
        buttonsQuery.element(boundBy: 0).tap()
        buttonsQuery.element(boundBy: 1).tap()
        
        let musicsQuery = app.buttons.matching(identifier: "MusicButton-MusicButton-MusicButton")
        musicsQuery.element(boundBy: 0).tap()
        
        app.buttons["Combinar"].tap()
        
        sleep(5)
        
        let wardrobeQuery = app.buttons.matching(identifier: "WardrobeView")
        wardrobeQuery.element(boundBy: 0).tap()
        
        app/*@START_MENU_TOKEN@*/.scrollViews.containing(.other, identifier:"Vertical scroll bar, 2 pages")/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 2 pages\")",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 2 pages\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            .children(matching: .other)
            .element(boundBy: 0)
            .children(matching: .other)
            .element.children(matching: .button)
            .element(boundBy: 0).tap()
        
        
        XCTAssert(app.buttons["redirectToStore"].exists, "O botão de redirecionar a loja foi encontrado!")
    }

}
