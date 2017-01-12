//
//  LowestPathAlgorithm.swift
//  LowestPath
//
//  Created by Srinivasan, Selvam on 1/6/17.
//  Copyright © 2017 Srinivasan, Selvam. All rights reserved.
//

import UIKit

public class Vertex {
    var key: String?
    var neighbors: Array<Edge>
    init() {
        self.neighbors = Array<Edge>()
    }
}

public class Edge {
    var neighbor: Vertex
    var weight: Int
    init() {
        weight = 0
        self.neighbor = Vertex()
    }
}

class Path {
    var total: Int!
    var destination: Vertex
    var previous: Path!
    
    //object initialization
    init(){ destination = Vertex() }
}

public class LowestPath {
    private var canvas: Array<Vertex>
    var max_allowed_limit = 50
    public var isDirected: Bool
    init() {
        canvas = Array<Vertex>()
        isDirected = true
    }
    //create a new vertex
    func addVertex(key: String) -> Vertex {
        //set the key
        let childVertex: Vertex = Vertex()
        childVertex.key = key
        //add the vertex to the graph canvas
        canvas.append(childVertex)
        return childVertex
    }
    
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
    
    func processLowestPath(source: Vertex, destination: Vertex) -> (Path?, String, Vertex) {
        var frontier = [Path]()
        var finalPaths = [Path]()
        //use source edges to create the frontier
        for e in source.neighbors {
            let newPath: Path = Path()
            newPath.destination = e.neighbor
            newPath.previous = nil
            newPath.total = e.weight
            //add the new path to the frontier
            frontier.append(newPath)
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
                let newPath: Path = Path()
                newPath.destination = e.neighbor
                newPath.previous = bestPath
                newPath.total = bestPath.total + e.weight
                //add the new path to the frontier
                frontier.append(newPath)
            }
            //preserve the bestPath
            finalPaths.append(bestPath)
            //remove the bestPath from the frontier
            frontier.remove(at: pathIndex)
        }
        for p in finalPaths {
            let path = p
            if (path.total < bestPath.total) && (path.destination.key == destination.key) {
                bestPath = path
            }
        }
        
        return (bestPath, bestLowPath(path: bestPath, source: source, pathString: ""), source: source)
    }
    
    func findBestLowPath(path:Path, total: Int, difference: Int, source: Vertex) -> (Path, String) {
        if path.previous != nil && path.total > max_allowed_limit-difference {
            var weightVal: Int = 0
            for e in path.previous.destination.neighbors {
                if path.destination.key == e.neighbor.key {
                    weightVal = e.weight
                }
            }
            return findBestLowPath(path: path.previous!, total: path.total-weightVal, difference: difference, source: source)
        }
        return (path, bestLowPath(path: path, source: source, pathString: ""))
    }
    
    func bestLowPath(path: Path, source: Vertex, pathString: String) -> String {
        var newOne = ""
        if path.previous != nil {
            
            newOne = (pathString == "" ? path.destination.key! : path.destination.key!+" "+pathString)
            
            return bestLowPath(path: path.previous!, source: source, pathString: newOne)
        } else {
            if source.key == nil {
                newOne = (pathString == "" ? path.destination.key! : path.destination.key!+" "+pathString)
            }
            else if path.destination.key == nil {
                newOne = source.key!
            }
            else{
                newOne = (pathString == "" ? source.key!+" "+path.destination.key! : source.key!+" "+path.destination.key!+" "+pathString)
            }
            return newOne
        }
    }
}




