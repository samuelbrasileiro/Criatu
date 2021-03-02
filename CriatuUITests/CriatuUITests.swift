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

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        sleep(4)
        
        let buttonsQuery = app.buttons.matching(identifier: "ImageButton")
        
        
        buttonsQuery.element(boundBy: 0).tap()
        buttonsQuery.element(boundBy: 1).tap()
        buttonsQuery.element(boundBy: 2).tap()
        buttonsQuery.element(boundBy: 3).tap()
        
        let musicsQuery = app.buttons.matching(identifier: "MusicButton-MusicButton-MusicButton")
        
        musicsQuery.element(boundBy: 0).tap()
        musicsQuery.element(boundBy: 1).tap()
        
        app.buttons["Combinar"].tap()
        
        sleep(5)
        
        app.buttons["WardrobeView"].tap()
        
        let clothingQuery = app.buttons.matching(identifier: "ClothingButton")
        clothingQuery.element(boundBy: 0).tap()
        
        
//        XCTAssert(app.buttons["WardrobeView"].exists, "O botão 'Adicionar à Siri' está funcionando.")

        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
