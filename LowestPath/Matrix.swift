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
    var columnVertex: Array<Vertex> = [], vertex: Array<Vertex> = [], tempVertex: Array<Vertex>  = []//Vertex local variables for iterating through neighbors
    var rowInfo: [String:(Int, Int)] = [:]//This dictionary contains key as "row & column number combination" & value as "corresponding row/ column value and individual row number"
    
    var pathTotal: Int?, rowCount: Int?, pathAllRows: Bool = true, lowestPath: String?//Three Output Variables
    let graph = LowestPath() //Initialization
    
    
    func processInputColumns(rows: [[Any]]) -> (Bool?, Int?, String?) {//This function process the input matrix columns and output the PathTraversingAllRow(Bool Value), Lowest Path total(Int) and Follwed Output Path(Row Numbers)
        guard let columns: [[Int]] = processMatrixRowsAndColumns(rows: rows) else {
            return (nil, nil, nil) // if the input matrix is not correct
        }
        for column in 0..<columns.count {//Iterating through each column
            rowCount = columns[column].count
            
            for row in 0..<columns[column].count {//Iterating each row value in a single column
                let lastrow = columns[column].count-1, firstrow = 0, onerow = 1, nextrow = row+1, prevrow = row-1, colValue = columns[column][row]//variables declared to iterate the columns
                
                let vertexVal = graph.addVertex(key: "\(row)\(column)")//adding Vertex to our graph
                rowInfo["\(row)\(column)"] = (colValue, row+1)//stores column value and row number
                if (column == 0){
                    columnVertex.append(vertexVal)
                    vertex.append(vertexVal)
                }
                else{
                    tempVertex.append(vertexVal)
                    
                    if (row == firstrow || (row != lastrow)) && rowCount != onerow {
                        graph.addEdge(source: columnVertex[nextrow], neighbor: vertexVal, weight: colValue)
                        if row == firstrow {
                            graph.addEdge(source: columnVertex[lastrow], neighbor: vertexVal, weight: colValue)
                        }
                    }
                    if ((row == lastrow) || (row != firstrow)) && rowCount != onerow {
                        graph.addEdge(source: columnVertex[prevrow], neighbor: vertexVal, weight: colValue)
                        if row == lastrow {
                            graph.addEdge(source: columnVertex[firstrow], neighbor: vertexVal, weight: colValue)
                        }
                    }
                    graph.addEdge(source: columnVertex[row], neighbor: vertexVal, weight: colValue)
                }
            }
            
            if (column != 0) {//This condition is mainly for the iteration of the neighbor column
                columnVertex.removeAll(); columnVertex = tempVertex; tempVertex.removeAll()
            }
        }
        //Processing Matrix Edges
        processMatrixEdges()
        
        var totalPath: String = lowestPath!
        for (key, value) in rowInfo {
            totalPath = totalPath.replacingOccurrences(of: key, with: String(value.1))
        }
        let rowVerification = totalPath.components(separatedBy: " ")
        for i in 1...rowCount! {
            if !rowVerification.contains(String(i)) {
                pathAllRows = false
                break
            }
        }
        
        //Printing the output received
        return (pathAllRows, pathTotal!, totalPath)
    }
    
    func processMatrixRowsAndColumns(rows: [[Any]]) -> [[Int]]? {
        var columns = Array(repeating: Array(repeating: 0, count: rows.count), count: rows[0].count)
        var columnCount: Int = 0
        for row in 0..<rows.count {
            if (columnCount != rows[row].count && row != 0) {
                return nil
            }
            for column in 0..<rows[row].count {
                columnCount = rows[row].count
                let iVal: Int? = Int(String(describing: rows[row][column]))
                if iVal != nil {
                    columns[column][row] = iVal!
                }
                else {
                    return nil
                }
                
            }
        }
        return columns
    }
    
    func processMatrixEdges() {
        //Processing the algorithm using the first row values
        for i in 0..<vertex.count {
            for j in 0..<columnVertex.count {
                //Output is a tuple contains (lowest total, best path)
                let path = graph.processLowestPath(source: vertex[i], destination: columnVertex[j])
                let row = String(i)+"0", sourceValue = rowInfo[row]!
                //Condition verification for the current path cost is the best lowest path cost we received
                if path.0!.total != nil {
                    if (pathTotal == nil || pathTotal! > (Int(path.0!.total) + sourceValue.0)) {
                        let lowestCostVal = graph.findBestLowPath(path:path.0!, total: path.0!.total, difference: sourceValue.0, source: vertex[i])
                        pathTotal = sourceValue.0 > maxLimit ? 0 : Int(lowestCostVal.0.total) + rowInfo[row]!.0
                        lowestPath = sourceValue.0 > maxLimit ? "" : lowestCostVal.1
                    }
                }
                else {
                    pathTotal = sourceValue.0 > maxLimit ? 0 : sourceValue.0
                    lowestPath = sourceValue.0 > maxLimit ? "" : row
                }
            }
        }
    }
}
