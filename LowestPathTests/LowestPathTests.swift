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
    var pathAlgorithm = LowestPath()
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
    
    func testLowestCostPath_With_FiveRowsAndSixColumnsMatrix() {
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
    
    func testLowestCostPath_With_FiveRowsAndSixColumnsMatrix1() {
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
    
    func testLowestCostPath_With_ThreeRowsAndFiveColumnsMatrix() {
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
        XCTAssertEqual("1", matrix.2)
    }
    
    func testLowestCostPath_WithSingleRow() {
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
    
    func test_With_AlphabetsInMatrix() {
        //Example With AlphabetsInMatrix
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
    
    //Matrix Functions
    
    func test_Func_ProcessMatrixRowsAndColumns_NegativeScenario() {
        //Example to test func ProcessMatrixRowsAndColumns With NegativeScenario
        let rows: [[Any]] = [[3,"q",1,"s",8,6],
                             [6,1,8,2,7,4],
                             [5,9,"a",9,9,5],
                             [8,"s",1,3,2,6],
                             [3,7,2,1,2,3]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows)
        XCTAssertEqual("", matrix == nil ? "" : String(describing: matrix!))
    }
    
    func test_Func_ProcessMatrixRowsAndColumns_PositiveScenario() {
        //Example to test func ProcessMatrixRowsAndColumns With PositiveScenario
        let rows: [[Any]] = [[199,10,19,10,19],
                             [210,23,20,19,12],
                             [200,12,20,11,10]]
        
        //Expected result match verification
        let matrix = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows)
        XCTAssertEqual("[[199, 210, 200], [10, 23, 12], [19, 20, 20], [10, 19, 11], [19, 12, 10]]", matrix == nil ? "" : String(describing: matrix!))
        
    }
    
    func test_Func_AddingVertex() {
        //Example One
        let columns: [[Int]] =   [[3,4,1,2,8,6],
                                 [6,1,8,2,7,4],
                                 [5,9,3,9,9,5],
                                 [8,4,1,3,2,6],
                                 [3,7,2,8,6,4]]
        
        matrixAlgorithm.processAddingVertex(columns: columns)
        XCTAssertEqual(30, matrixAlgorithm.pathAlgorithm.canvas.count)
    }
    
    func test_Func_FindingNeighbors() {
        //Example One
        let columns: [[Int]] =     [[3,4,1,2,8,6],
                                    [6,1,8,2,7,4],
                                    [5,9,3,9,9,5],
                                    [8,4,1,3,2,6],
                                    [3,7,2,8,6,4]]
        
        matrixAlgorithm.processAddingVertex(columns: columns)
        //let arrVertex = pathAlgorithm.findingNeighbors(row: 2, column: 2, rowCount: 6)
        let arrVertex = matrixAlgorithm.pathAlgorithm.findingNeighbors(row: 2, column: 2, rowCount: 6)
        XCTAssertEqual(3, arrVertex.count)
    }
    
    func test_Func_ProcessMatrixEdges() {
        
        let rows: [[Int]] =     [[3,4,1,2,8,6],
                                [6,1,8,2,7,4],
                                [5,9,3,9,9,5],
                                [8,4,1,3,2,6],
                                [3,7,2,8,6,4]]
        
        let columns: [[Int]] = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows)!
        matrixAlgorithm.processAddingVertex(columns: columns)
        matrixAlgorithm.processMatrixEdges()
        
        XCTAssertEqual(true, matrixAlgorithm.pathAllRows)
        XCTAssertEqual(16, matrixAlgorithm.pathTotal)
        XCTAssertEqual("1 2 3 4 4 5", matrixAlgorithm.lowestPath)
    }
    
    //Test case added to verify for the valid row entry
    func test_Func_VerifyEachRows() {
        
        let rows: [Any] =     [3,4,"d",2,8,6]
        XCTAssertEqual(false, matrixAlgorithm.verifyEachRows(input: rows))
    }
    
    //Lowest Path Algorithm
    //Testcase for function AddVertex
    //This class is mainly used to add new instances for the Vertex class
    func test_Func_AddVertex() {
        
        _ = pathAlgorithm.addVertex(row: 2, column: 0, cost: 1)
        _ = pathAlgorithm.addVertex(row: 2, column: 1, cost: 10)
        XCTAssertEqual(2,pathAlgorithm.canvas.count)
    }
    
    //Testcase for function AddEdge
    //This class is mainly used to add new instances for the Edge class
    func test_Func_AddEdge() {
        
        let vertex1 = pathAlgorithm.addVertex(row: 2, column: 0, cost: 1)
        let vertex2 = pathAlgorithm.addVertex(row: 2, column: 1, cost: 10)
        pathAlgorithm.addEdge(source: vertex1, neighbor: vertex2, weight: 10)
        XCTAssertEqual(1,vertex1.neighbors.count)
    }
    
    // Maincore Algorithm Testcase
    // Testcase to test the function to derive the best low path cost
    // This function is called inside the Matrix function processMatrixEdges
    // This function is the basis for the LowestPath algorithm function bestLowPath
    // This will provide output(low path) for the each individual source vertex
    func test_Func_ProcessLowestPath() {
        //First Testcase - Lot of rows and columns
        let rows: [[Int]] =     [[3,4,1,2,8,6],
                                 [6,1,8,2,7,4],
                                 [5,9,3,9,9,5],
                                 [8,4,1,3,2,6],
                                 [3,7,2,8,6,4]]
        let columns: [[Int]] = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows)!
        matrixAlgorithm.processAddingVertex(columns: columns)
        matrixAlgorithm.processMatrixEdges()
        
        let output = matrixAlgorithm.pathAlgorithm.processLowestPath(source: matrixAlgorithm.sourceVertex!)
        
        //Expected result match verification
        XCTAssertEqual(6, output.2)
        XCTAssertEqual(16, output.0)
        XCTAssertEqual("1 2 3 4 4 5", output.1)
        
        //Third Testcase - Big Numbers
        //Example With Big Numbers
        let rows2: [[Int]] = [[199,10,19,10,19],
                              [210,23,20,19,12],
                              [200,12,20,11,10]]
        
        matrixAlgorithm.clearGlobalVariables()
        
        //Expected result match verification
        let columns2: [[Int]] = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows2)!
        matrixAlgorithm.processAddingVertex(columns: columns2)
        matrixAlgorithm.processMatrixEdges()
        
        let output2 = matrixAlgorithm.pathAlgorithm.processLowestPath(source: matrixAlgorithm.sourceVertex!)
        XCTAssertEqual(0, output2.2)
        XCTAssertEqual(0, output2.0)
        XCTAssertEqual("", output2.1)
        
        matrixAlgorithm.clearGlobalVariables()
        
        //Second Testcase - Only Single Column
        let rows1: [[Int]] = [[3],
                              [6],
                              [5],
                              [8],
                              [3]]
        
        //Expected result match verification
        let columns1: [[Int]] = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows1)!
        matrixAlgorithm.processAddingVertex(columns: columns1)
        matrixAlgorithm.processMatrixEdges()
        
        let output1 = matrixAlgorithm.pathAlgorithm.processLowestPath(source: matrixAlgorithm.sourceVertex!)
        XCTAssertEqual(1, output1.2)
        XCTAssertEqual(3, output1.0)
        XCTAssertEqual("1", output1.1)
    }
    
    func test_Func_ProcessLowestPath_Combination1() {
        //Third Testcase - Big Numbers
        //Example With Big Numbers
        let rows2: [[Int]] = [[199,10,19,10,19],
                              [210,23,20,19,12],
                              [200,12,20,11,10]]
        
        
        
        //Expected result match verification
        let columns2: [[Int]] = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows2)!
        matrixAlgorithm.processAddingVertex(columns: columns2)
        matrixAlgorithm.processMatrixEdges()
        
        let output2 = matrixAlgorithm.pathAlgorithm.processLowestPath(source: matrixAlgorithm.sourceVertex!)
        XCTAssertEqual(0, output2.2)
        XCTAssertEqual(0, output2.0)
        XCTAssertEqual("", output2.1)
        
        matrixAlgorithm.clearGlobalVariables()
        
        //Second Testcase - Only Single Column
        let rows1: [[Int]] = [[3],
                              [6],
                              [5],
                              [8],
                              [3]]
        
        //Expected result match verification
        let columns1: [[Int]] = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows1)!
        matrixAlgorithm.processAddingVertex(columns: columns1)
        matrixAlgorithm.processMatrixEdges()
        
        let output1 = matrixAlgorithm.pathAlgorithm.processLowestPath(source: matrixAlgorithm.sourceVertex!)
        XCTAssertEqual(1, output1.2)
        XCTAssertEqual(3, output1.0)
        XCTAssertEqual("1", output1.1)
        matrixAlgorithm.clearGlobalVariables()
        //First Testcase - Lot of rows and columns
        let rows: [[Int]] =     [[3,4,1,2,8,6],
                                 [6,1,8,2,7,4],
                                 [5,9,3,9,9,5],
                                 [8,4,1,3,2,6],
                                 [3,7,2,8,6,4]]
        let columns: [[Int]] = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows)!
        matrixAlgorithm.processAddingVertex(columns: columns)
        matrixAlgorithm.processMatrixEdges()
        
        let output = matrixAlgorithm.pathAlgorithm.processLowestPath(source: matrixAlgorithm.sourceVertex!)
        
        //Expected result match verification
        XCTAssertEqual(6, output.2)
        XCTAssertEqual(16, output.0)
        XCTAssertEqual("1 2 3 4 4 5", output.1)
    }
    
    func test_Func_ProcessLowestPath_Combination2() {
        //Third Testcase - Big Numbers
        //Example With Big Numbers
        let rows2: [[Any]] = [[3,"q",1,"s",8,6],
                              [6,1,8,2,7,4],
                              [5,9,"a",9,9,5],
                              [8,"s",1,3,2,6],
                              [3,7,2,1,2,3]]
    
        //Expected result match verification
        let matrix = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows2)
        if matrix != nil {
            matrixAlgorithm.processAddingVertex(columns: matrix!)
            matrixAlgorithm.processMatrixEdges()
            
            let output2 = matrixAlgorithm.pathAlgorithm.processLowestPath(source: matrixAlgorithm.sourceVertex!)
            XCTAssertEqual(0, output2.2)
            XCTAssertEqual(0, output2.0)
            XCTAssertEqual("", output2.1)
        }
        else {
            XCTAssertEqual("", matrix == nil ? "" : String(describing: matrix!))
        }
        
        matrixAlgorithm.clearGlobalVariables()
        
        //First Testcase - Lot of rows and columns
        let rows: [[Int]] =     [[1,1,4]]
        let columns: [[Int]] = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows)!
        matrixAlgorithm.processAddingVertex(columns: columns)
        matrixAlgorithm.processMatrixEdges()
        
        let output = matrixAlgorithm.pathAlgorithm.processLowestPath(source: matrixAlgorithm.sourceVertex!)
        
        //Expected result match verification
        XCTAssertEqual(3, output.2)
        XCTAssertEqual(6, output.0)
        XCTAssertEqual("1 1 1", output.1)
        
        matrixAlgorithm.clearGlobalVariables()
        
        //Second Testcase - Only Single Column
        let rows1: [[Int]] = [[3],
                              [6],
                              [5],
                              [8],
                              [3]]
        
        //Expected result match verification
        let columns1: [[Int]] = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows1)!
        matrixAlgorithm.processAddingVertex(columns: columns1)
        matrixAlgorithm.processMatrixEdges()
        
        let output1 = matrixAlgorithm.pathAlgorithm.processLowestPath(source: matrixAlgorithm.sourceVertex!)
        XCTAssertEqual(1, output1.2)
        XCTAssertEqual(3, output1.0)
        XCTAssertEqual("1", output1.1)
        
        
    }
    
    // Testcase to test the function to derive the lowest path string consisting of all the row numbers traversed
    // Input: Bestpath(output from the processLowestPath function, Source vertex, Existing Path string(for in-function call)
    // Output: Bestpath followed string variable consisting of all the row numbers traversed
    func test_Func_BestLowPath() {
        let rows: [[Int]] =     [[3,4,1,2,8,6],
                                 [6,1,8,2,7,4],
                                 [5,9,3,9,9,5],
                                 [8,4,1,3,2,6],
                                 [3,7,2,8,6,4]]
        let columns: [[Int]] = matrixAlgorithm.processOfReversingRowsAndColumns(rows: rows)!
        matrixAlgorithm.processAddingVertex(columns: columns)
        matrixAlgorithm.processMatrixEdges()
        
        let output = matrixAlgorithm.pathAlgorithm.bestLowPath(path: matrixAlgorithm.bestPath!, source: matrixAlgorithm.sourceVertex! , pathString: "")
        XCTAssertEqual("1 2 3 4 4 5", output)
    }
}
