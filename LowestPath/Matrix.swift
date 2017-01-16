//
//  Matrix.swift
//  LowestPath
//
//  Created by Srinivasan, Selvam on 1/10/17.
//  Copyright © 2017 Srinivasan, Selvam. All rights reserved.
//

import Foundation
import UIKit

class Matrix {
    var maxLimit = 50//Maximum allowed total path cost limit
    
    var pathTotal: Int?, columnCount: Int?, pathAllRows: Bool = true, lowestPath: String?, bestPath: Path?, sourceVertex: Vertex?//Three Output Variables
    let pathAlgorithm = LowestPath() //Initialization
    
    // Testcase Added
    // This is main function will call all the required functions to populate the lowest path, lowest path cost and all column traversing bool value
    func processInputColumns(rows: [[Any]]) -> (Bool?, Int?, String?) {
        guard let columns: [[Int]] = processOfReversingRowsAndColumns(rows: rows) else {
            return (nil, nil, nil) // if the input matrix is not correct
        }
        processAddingVertex(columns: columns)
        processMatrixEdges()
        
        //Printing the output received
        return (pathAllRows, pathTotal, lowestPath)
    }
    
    // Testcase Added
    //Step: 1 - Reversing the Rows And Columns
    //-----------------------------------------
    //Reason 1: Input matrix got in the format easy for user reading
    //Reason 2: Algorithm is going to process lowest path with the reference of each column(as per the requirement provided - path will start from left and move to right)
    
    //Step: 2 - Performing the matrix vaidation for wrong input(like alphabets - test case added) and irregular matrix(like uneven count rows and columns)
    //--------------------------------------------
    func processOfReversingRowsAndColumns(rows: [[Any]]) -> [[Int]]? {
        var columns = Array(repeating: Array(repeating: 0, count: rows.count), count: rows[0].count)
        var columnCount: Int = 0
        for row in 0..<rows.count {
            if columnCount != rows[row].count && row != 0 {
                return nil
            }
            for column in 0..<rows[row].count {
                columnCount = rows[row].count
                let val: Int? = Int(String(describing: rows[row][column]))
                if val != nil {
                    columns[column][row] = val!
                }
                else {
                    return nil
                }
            }
        }
        return columns
    }
    
    //Testcase added
    func verifyEachRows(input: [Any]) -> Bool {
        print(input)
        for value in 0..<input.count {
            let output: Int? = Int(String(describing: input[value]))
            print("\(output)")
            if output == nil {
                return false
            }
        }
        return true
    }
    
    // Testcase Added
    //Step: 3 - Adding the each matrix entries as Vertex
    //-------------------------------------------
    // Note: In this vertex is referring the individual matrix entries (like each row/column entries)
    // Note: Matrix is processed in the form of 
    // 3 * 3 matrix
    //      [ 00 01 02
    //        10 11 12
    //        20 21 22 ]
    // Note: In the above matrix formation, 00 is reffering the corresponding Vertex key
    
    // Variable Definition:
    // columns - all the columns in the matrix
    // column  - each individual column
    // rows    - all the rows in the matrix
    // row     - each individual row
    // columnCount - overall columns count
    
    // Step: 4 - Finding Neighbour Edges
    //----------------------------------
    // Before adding each individual edges, we have to find the corresponding neighbor for each individual vertex( this is based on the requirement provided)
    
    // Step: 5 - Adding each edge to provide connection between each vertex
    //--------------------------------------
    // Adding Edge - In this algorithm, edge is referring the element to connect two different vertex(two nodes in the graph)
    
    func processAddingVertex(columns : [[Int]]) {
        for column in 0..<columns.count {
            columnCount = columns.count
            
            for row in 0..<columns[column].count {//Iterating each row value in a single column
                let vertex = pathAlgorithm.addVertex(row: row, column: column, cost: columns[column][row])
                if column != 0 {
                    var arr = pathAlgorithm.findingNeighbors(row: row, column: column, rowCount: columns[column].count)
                    for neighborVertex in 0..<arr.count {
                        pathAlgorithm.addEdge(source: arr[neighborVertex], neighbor: vertex, weight: vertex.cost!)
                    }
                }
            }
        }
    }
    
    // Testcase Added
    //Step 6: This is final processing step for the lowest cost path
    //------------------------------------------
    // Note: Algorithm will result in tuple consists of three outputs and a best path (Path() variable) for test case to test this function output
    // Note: Mentioned the condition columnNumber =1, to provide only the first column as the input for the path(based on the requirement provided)
    // Note: function processLowestPath will process the input source vertex and provide the outputs
    
    func processMatrixEdges() {
        var pathTraverseCount : Int = 0
        for (_, vertex) in pathAlgorithm.canvas {
            if vertex.columnNumber == 1 {
                let outputPath = pathAlgorithm.processLowestPath(source: vertex)
                if pathTotal == nil || pathTotal! > outputPath.0 && outputPath.2 >= pathTraverseCount {
                    pathTotal = outputPath.0
                    lowestPath = outputPath.1
                    pathAllRows = (outputPath.2 == columnCount ? true: false)
                    pathTraverseCount = outputPath.2
                    bestPath = outputPath.3
                    sourceVertex = vertex
                }
            }
        }
    }
}
