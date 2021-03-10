//
//  CriatuSetsTests.swift
//  CriatuTests
//
//  Created by Danilo Araújo on 09/03/21.
//

import XCTest
@testable import Criatu

class CriatuSetsTests: XCTestCase {
    
    let firstSet: TagsSet = TagsSet(["pizza", "pug", "mulher"])
    let secondSet: TagsSet = TagsSet(["pizza", "pug", "mulher"])
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJaccardSimmilarity() throws {
        var result = self.firstSet.jaccardSimilarity(to: self.secondSet)
        XCTAssertEqual(result, 1)
        
        firstSet.data.removeLast()
        
        result = self.firstSet.jaccardSimilarity(to: self.secondSet)
        XCTAssertEqual(result, 0.66666667) //Don't know why
    }
    
    func testSorensenCoefficient() throws {
        var result = self.firstSet.sorensenCoefficient(to: self.secondSet)
        XCTAssertEqual(result, 1)
        
        firstSet.data.removeLast()
        
        result = self.firstSet.sorensenCoefficient(to: self.secondSet)
        XCTAssertEqual(result, 0.8)
    }
    
    func testOverlapCoefficient() throws {
        var result = self.firstSet.overlapCoefficient(to: self.secondSet)
        XCTAssertEqual(result, 1)
        
        firstSet.data.removeLast()
        
        result = self.firstSet.overlapCoefficient(to: self.secondSet)
        XCTAssertEqual(result, 1)
    }

}
