//
//  LowestPathAlgorithm.swift
//  LowestPath
//
//  Created by Srinivasan, Selvam on 1/6/17.
//  Copyright © 2017 Srinivasan, Selvam. All rights reserved.
//

import UIKit

//Each vertex is derived from each row/ column matrix entry
// Note: In this vertex is referring the individual matrix entries (like each row/column entries)
// Note: Matrix is processed in the form of
//      3 * 3 matrix
//------------------------------------
//      [ 00 01 02
//        10 11 12
//        20 21 22 ]
// Note: In the above matrix formation, 00 is reffering the corresponding Vertex key
public class Vertex {
    var key: String?
    var cost: Int?
    var rowNumber: Int?
    var columnNumber: Int?
    var neighbors: Array<Edge>
    init() {
        self.neighbors = Array<Edge>()
    }
}

// Edge - In this algorithm, edge is referring the element to connect two different vertex(two nodes in the graph)
public class Edge {
    var neighbor: Vertex
    var weight: Int
    init() {
        weight = 0
        self.neighbor = Vertex()
    }
}

//Path - In this algorithm, path is mainly used to compare the individual vertex and their edges( neighbors and destinations )
//Note: This is the main output to exactly find the lowest path by comparing each other paths.
class Path {
    var total: Int!
    var destination: Vertex
    var previous: Path!
    
    //object initialization
    init(){ destination = Vertex() }
}

public class LowestPath {
    public var canvas: [String: Vertex]
    var max_allowed_limit = 50
    public var isDirected: Bool
    init() {
        canvas = [:]
        isDirected = true
    }
    
    //Testcase Added
    //This class is mainly used to add new instances for the Vertex class
    func addVertex(row: Int, column: Int, cost: Int) -> Vertex {
        //set the key
        let childVertex: Vertex = Vertex()
        childVertex.key = "\(row)\(column)"
        childVertex.cost = cost
        childVertex.rowNumber = row + 1
        childVertex.columnNumber = column + 1
        //add the vertex to the graph canvas
        canvas["\(row)\(column)"] = childVertex
        return childVertex
    }
    
    //Tescase Added
    // Before adding each individual edges, we have to find the corresponding neighbor for each individual vertex( this is based on the requirement provided)
    func findingNeighbors(row: Int, column: Int, rowCount: Int) -> Array<Vertex> {
        var neighborArray:Array<Vertex> = []
        if rowCount != 1 {
            if row == 0 || row != rowCount-1 {
                neighborArray.append(canvas["\(row+1)\(column-1)"]!)
                if row == 0 {
                    neighborArray.append(canvas["\(rowCount-1)\(column-1)"]!)
                }
            }
            if row == rowCount-1 || row != 0 {
                if row == rowCount-1 {
                    neighborArray.append(canvas["\(0)\(column-1)"]!)
                }
                neighborArray.append(canvas["\(row-1)\(column-1)"]!)
            }
        }
        neighborArray.append(canvas["\(row)\(column-1)"]!)
        return neighborArray
    }
    
    //Testcase Added
    //Adding each edge to provide connection between each vertex
    func addEdge(source: Vertex, neighbor: Vertex, weight: Int) {
        //create a new edge
        let newEdge = Edge()
        //establish the default properties
        newEdge.neighbor = neighbor
        newEdge.weight = weight
        source.neighbors.append(newEdge)
        //check for undirected graph
        if (isDirected == false) {
            //create a new reversed edge
            let reverseEdge = Edge()
            //establish the reversed properties
            reverseEdge.neighbor = source
            reverseEdge.weight = weight
            neighbor.neighbors.append(reverseEdge)
        }
    }
    
    // Testcase Added
    // Maincore Algorithm Testcase
    // This function is called inside the Matrix function processMatrixEdges
    // This function is the basis for the LowestPath algorithm function bestLowPath
    // This will provide output(low path) for the each individual source vertex
    func processLowestPath(source: Vertex) -> (Int, String, Int, Path?) {
        var frontier = [Path]()
        var finalPaths = [Path]()
        
        //sorce neighbors is not available or source cost itself is greater than allowed limit
        if source.neighbors.count == 0 || source.cost! > max_allowed_limit {
            return (source.cost! > max_allowed_limit ? 0 : source.cost!, source.cost! > max_allowed_limit ? "" : "\(source.rowNumber!)", source.neighbors.count == 0 ? 1 : 0, nil)
        }
        //use source edges to create the frontier
        for e in source.neighbors {
            if e.weight + source.cost! < 50 {
                let newPath: Path = Path()
                newPath.destination = e.neighbor
                newPath.previous = nil
                newPath.total = e.weight + source.cost!
                //add the new path to the frontier
                frontier.append(newPath)
            }
        }
        
        //obtain the best path
        var bestPath: Path = Path()
        while(frontier.count != 0) {
            //support path changes using the greedy approach
            bestPath = Path()
            var pathIndex: Int = 0
            for x in (0..<frontier.count) {
                let itemPath: Path = frontier[x]
                if (bestPath.total == nil) || (itemPath.total < bestPath.total) {
                    bestPath = itemPath
                    pathIndex = x
                }
            }
            
            for e in bestPath.destination.neighbors {
                if bestPath.total + e.weight < 50 {
                    let newPath: Path = Path()
                    newPath.destination = e.neighbor
                    newPath.previous = bestPath
                    newPath.total = bestPath.total + e.weight
                    //add the new path to the frontier
                    frontier.append(newPath)
                }
            }
            //preserve the bestPath
            finalPaths.append(bestPath)
            //remove the bestPath from the frontier
            frontier.remove(at: pathIndex)
        }
        for p in finalPaths {
            let path = p
            if (path.total < bestPath.total) && bestPath.destination.columnNumber! <= path.destination.columnNumber! {
                bestPath = path
            }
        }
        let lowestPath = bestLowPath(path: bestPath, source: source, pathString: "")
        let arr = lowestPath.components(separatedBy: " ")
        return (bestPath.total, lowestPath, arr.count, bestPath)
    }
    
    //Testcase Added
    // This function is mainly used to add all the path followed (neighbor edges from source) as a single string to show as output in the UI for the third output
    // Note: Same function will call again itself when there is a previous edge present.
    // Note: If there is no previous edge means, it is the source vertex
    // Note: Finally, replace the vertex key value as row number(provided in the requirement)
    func bestLowPath(path: Path, source: Vertex, pathString: String) -> String {
        var newOne = ""
        if path.previous != nil {
            newOne = (pathString == "" ? String(path.destination.rowNumber!) : String(path.destination.rowNumber!)+" "+pathString)
            return bestLowPath(path: path.previous!, source: source, pathString: newOne)
        } else {
            if source.key == nil {
                newOne = (pathString == "" ? path.destination.key! : path.destination.key!+" "+pathString)
            }
            else if path.destination.key == nil {
                newOne = String(source.rowNumber!)
            }
            else{
                newOne = (pathString == "" ? String(source.rowNumber!)+" "+String(path.destination.rowNumber!) : String(source.rowNumber!)+" "+String(path.destination.rowNumber!)+" "+pathString)
            }
            return newOne
        }
    }
}




