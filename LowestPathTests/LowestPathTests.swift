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
        let rows: [[Int]] =     [[3,4,1,2,8,6],
                                [6,1,8,2,7,4],
                                [5,9,3,9,9,5],
                                [8,4,1,3,2,6],
                                [3,7,2,8,6,4]]
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(rows: rows)
        XCTAssertEqual(true, matrix.0)
        XCTAssertEqual(16, matrix.1)
        XCTAssertEqual("1 2 3 4 4 5", matrix.2)
    }
    
    func testLowestCostPath_With_Second_Example() {
        //Example Second
        let rows: [[Int]] = [[3,4,1,2,8,6],
                             [6,1,8,2,7,4],
                             [5,9,3,9,9,5],
                             [8,4,1,3,2,6],
                             [3,7,2,1,2,3]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(rows: rows)
        XCTAssertEqual(true, matrix.0)
        XCTAssertEqual(11, matrix.1)
        XCTAssertEqual("1 2 1 5 4 5", matrix.2)
    }
    
    func testLowestCostPath_With_Third_Example() {
        //Example Third
        let rows: [[Int]] = [[19,10,19,10,19],
                             [21,23,20,19,12],
                             [20,12,20,11,10]]
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(rows: rows)
        XCTAssertEqual(false, matrix.0)
        XCTAssertEqual(48, matrix.1)
        XCTAssertEqual("1 1 1", matrix.2)
    }
    
    func testLowestCostPath_With_More_Example_MatrixWithNegativeNumbers() {
        //Example Third
        let rows: [[Int]] = [[3,4,1,-2,8,6],
                             [6,1,8,-4,7,4],
                             [5,-9,3,9,9,5],
                             [8,4,1,-16,2,6],
                             [3,7,2,8,6,4]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(rows: rows)
        XCTAssertEqual(true, matrix.0)
        XCTAssertEqual(-13, matrix.1)
        XCTAssertEqual("3 3 4 4 4 5", matrix.2)
    }
    
    func testLowestCostPath_WithSingleColumn() {
        //Example With Single Column
        let rows: [[Int]] = [[3],
                             [6],
                             [5],
                             [8],
                             [3]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(rows: rows)
        XCTAssertEqual(true, matrix.0)
        XCTAssertEqual(3, matrix.1)
        XCTAssertEqual("5", matrix.2)
    }
    
    func testLowestCostPath_WithOneRow() {
        //Example With One Row
        let rows: [[Int]] = [[3,4,1,2,8]]
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(rows: rows)
        XCTAssertEqual(true, matrix.0)
        XCTAssertEqual(18, matrix.1)
        XCTAssertEqual("1 1 1 1 1", matrix.2)
    }

    func testLowestCostPath_WithBigNumbers() {
        //Example With Big Numbers
        let rows: [[Int]] = [[199,10,19,10,19],
                             [210,23,20,19,12],
                             [200,12,20,11,10]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(rows: rows)
        XCTAssertEqual(false, matrix.0)
        XCTAssertEqual(0, matrix.1)
        XCTAssertEqual("", matrix.2)
    }
    
    func testLowestCostPath_WithIRRegularMatrix() {
        //Example With Irregular Matrix
        let rows: [[Int]] = [[9,10,19,10,1],
                             [2,2,2,1],
                             [2,12],
                             [3]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(rows: rows)
        XCTAssertEqual(nil, matrix.0)
        XCTAssertEqual(nil, matrix.1)
        XCTAssertEqual(nil, matrix.2)
    }
    
    func testLowestCostPath_With_NegativeScenario() {
        //Example With NegativeScenario
        let rows: [[Any]] = [[3,"q",1,"s",8,6],
                             [6,1,8,2,7,4],
                             [5,9,"a",9,9,5],
                             [8,"s",1,3,2,6],
                             [3,7,2,1,2,3]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processInputColumns(rows: rows)
        XCTAssertEqual(nil, matrix.0)
        XCTAssertEqual(nil, matrix.1)
        XCTAssertEqual(nil, matrix.2)
    }
    
    func testLowestCostPath_Func_ProcessMatrixRowsAndColumns_NegativeScenario() {
        //Example to test
        let rows: [[Any]] = [[3,"q",1,"s",8,6],
                             [6,1,8,2,7,4],
                             [5,9,"a",9,9,5],
                             [8,"s",1,3,2,6],
                             [3,7,2,1,2,3]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processMatrixRowsAndColumns(rows: rows)
        XCTAssertEqual("", matrix == nil ? "" : String(describing: matrix!))
    }
    
    func testLowestCostPath_Func_ProcessMatrixRowsAndColumns_PositiveScenario() {
        //Example to test
        let rows: [[Any]] = [[199,10,19,10,19],
                             [210,23,20,19,12],
                             [200,12,20,11,10]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processMatrixRowsAndColumns(rows: rows)
        XCTAssertEqual("[[199, 210, 200], [10, 23, 12], [19, 20, 20], [10, 19, 11], [19, 12, 10]]", matrix == nil ? "" : String(describing: matrix!))
    }
}
