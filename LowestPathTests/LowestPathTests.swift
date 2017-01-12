//
//  LowestPathTests.swift
//  LowestPathTests
//
//  Created by Srinivasan, Selvam on 1/10/17.
//  Copyright © 2017 Srinivasan, Selvam. All rights reserved.
//

import XCTest
@testable import LowestPath

class LowestPathTests: XCTestCase {
    var matrixAlgorithm = Matrix()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLowestCostPath_With_First_Example() {
        //Example One
        let columns: [[Int]] = [[3,6,5,8,3],
                                [4,1,9,4,7],
                                [1,8,3,1,2],
                                [2,2,9,3,8],
                                [8,7,9,2,6],
                                [6,4,5,6,4]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(columns: columns)
        XCTAssertEqual(true, matrix.0)
        XCTAssertEqual(16, matrix.1)
        XCTAssertEqual("1 2 3 4 4 5", matrix.2)
    }
    
    func testLowestCostPath_With_Second_Example() {
        //Example Second
        let columns: [[Int]] = [[3,6,5,8,3],
                                [4,1,9,4,7],
                                [1,8,3,1,2],
                                [2,2,9,3,1],
                                [8,7,9,2,2],
                                [6,4,5,6,3]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(columns: columns)
        XCTAssertEqual(false, matrix.0)
        XCTAssertEqual(11, matrix.1)
        XCTAssertEqual("1 2 1 5 4 5", matrix.2)
    }
    
    func testLowestCostPath_With_Third_Example() {
        //Example Third
        let columns: [[Int]] = [[19,21,20],
                                [10,23,12],
                                [19,20,20],
                                [10,19,11],
                                [19,12,10]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(columns: columns)
        XCTAssertEqual(false, matrix.0)
        XCTAssertEqual(48, matrix.1)
        XCTAssertEqual("1 1 1", matrix.2)
    }
    
    func testLowestCostPath_With_More_Example_MatrixWithNegativeNumbers() {
        //Example Third
        let columns: [[Int]] = [[3,6,5,8,3],
                                [4,1,-9,4,7],
                                [1,8,3,1,2],
                                [-2,-4,9,-16,8],
                                [8,7,9,2,6],
                                [6,4,5,6,4]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(columns: columns)
        XCTAssertEqual(false, matrix.0)
        XCTAssertEqual(-13, matrix.1)
        XCTAssertEqual("3 3 4 4 4 5", matrix.2)
    }
    
    func testLowestCostPath_WithSingleColumn() {
        //Example Third
        let columns: [[Int]] = [[3,6,5,8,3]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(columns: columns)
        XCTAssertEqual(false, matrix.0)
        XCTAssertEqual(3, matrix.1)
        XCTAssertEqual("5", matrix.2)
    }
    
    func testLowestCostPath_WithOneRow() {
        //Example Third
        let columns: [[Int]] = [[3],
                                [4],
                                [1],
                                [2],
                                [8]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(columns: columns)
        XCTAssertEqual(true, matrix.0)
        XCTAssertEqual(18, matrix.1)
        XCTAssertEqual("1 1 1 1 1", matrix.2)
    }

    func testLowestCostPath_WithBigNumbers() {
        //Example Third
        let columns: [[Int]] = [[199,210,200],
                                [10,23,12],
                                [19,20,20],
                                [10,19,11],
                                [19,12,10]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(columns: columns)
        XCTAssertEqual(false, matrix.0)
        XCTAssertEqual(0, matrix.1)
        XCTAssertEqual("", matrix.2)
    }
    
    func testLowestCostPath_WithIRRegularMatrix() {
        //Example Third
        let columns: [[Int]] = [[9,2,2],
                                [10,2,12],
                                [19,2],
                                [10,1,11],
                                [1]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(columns: columns)
        XCTAssertEqual(nil, matrix.0)
        XCTAssertEqual(nil, matrix.1)
        XCTAssertEqual(nil, matrix.2)
    }
}
