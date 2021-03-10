//
//  CriatuAPITests.swift
//  CriatuTests
//
//  Created by Danilo Araújo on 09/03/21.
//

import XCTest
@testable import Criatu

class CriatuAPITests: XCTestCase {

    var api: PixabayAPI = PixabayAPI()
    
    override func setUpWithError() throws {
        self.api = PixabayAPI()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetData() throws {
        let expect = expectation(description: "Wait for images from PixabayAPI to download")
        let tag = "vinho"
        
        self.api.getData(tagsSearched: tag, completionHandler: { _ in
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 20)
        
        let downloadedImages = api.imagesData.filter({
            $0.tagsArray.contains(tag)
        })
        
        XCTAssertEqual(downloadedImages.count, 3)
    }
    
    func testDownloadImages() throws {
        let expect = expectation(description: "Wait for images from PixabayAPI to download")
        let tag = "vinho"
        var expectedImage: UIImage? = nil
        
        self.api.getData(tagsSearched: tag, completionHandler: { _ in
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 20)
        
        let secondExpectation = expectation(description: "Downloading image")
        
        api.getImage(id: api.imagesData.first!.id, completionHandler: { image in
            expectedImage = image
            secondExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 20)
        
        XCTAssertNotNil(expectedImage, "Image download was successful")
    }
}
