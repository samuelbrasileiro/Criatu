//
//  CriatuTests.swift
//  CriatuTests
//
//  Created by Danilo Araújo on 02/03/21.
//

import XCTest
import ViewInspector
@testable import Criatu

extension ButtonStore: Inspectable {}

final class CriatuTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRedirectButton() throws {
        let view = ButtonStore()
        let text = try view.inspect().button().text()
        
        XCTAssert(text, "Visitar Loja", "Botão visitar a loja funcionando")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
