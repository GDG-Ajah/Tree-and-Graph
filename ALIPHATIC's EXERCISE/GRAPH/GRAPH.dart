// Evaluate Division


// You are given an array of variable pairs equations and an array of real numbers values, where equations[i] = [Ai, Bi] and values[i] represent the equation Ai / Bi = values[i]. Each Ai or Bi is a string that represents a single variable.

// You are also given some queries, where queries[j] = [Cj, Dj] represents the jth query where you must find the answer for Cj / Dj = ?.

// Return the answers to all queries. If a single answer cannot be determined, return -1.0.

// Note: The input is always valid. You may assume that evaluating the queries will not result in division by zero and that there is no contradiction.

 

// Example 1:

// Input: equations = [["a","b"],["b","c"]], values = [2.0,3.0], queries = [["a","c"],["b","a"],["a","e"],["a","a"],["x","x"]]
// Output: [6.00000,0.50000,-1.00000,1.00000,-1.00000]
// Explanation: 
// Given: a / b = 2.0, b / c = 3.0
// queries are: a / c = ?, b / a = ?, a / e = ?, a / a = ?, x / x = ?
// return: [6.0, 0.5, -1.0, 1.0, -1.0 ]
// Example 2:

// Input: equations = [["a","b"],["b","c"],["bc","cd"]], values = [1.5,2.5,5.0], queries = [["a","c"],["c","b"],["bc","cd"],["cd","bc"]]
// Output: [3.75000,0.40000,5.00000,0.20000]
// Example 3:

// Input: equations = [["a","b"]], values = [0.5], queries = [["a","b"],["b","a"],["a","c"],["x","y"]]
// Output: [0.50000,2.00000,-1.00000,-1.00000]
 

// Constraints:

// 1 <= equations.length <= 20
// equations[i].length == 2
// 1 <= Ai.length, Bi.length <= 5
// values.length == equations.length
// 0.0 < values[i] <= 20.0
// 1 <= queries.length <= 20
// queries[i].length == 2
// 1 <= Cj.length, Dj.length <= 5
// Ai, Bi, Cj, Dj consist of lower case English letters and digits.


// Hint #1  
// Do you recognize this as a graph problem?



// Solution 1: DFS



class Solution {
    func calcEquation(_ equations: [[String]], _ values: [Double], _ queries: [[String]]) -> [Double] {
        // build graph
        var graph = [String: [(String, Double)]]()
        for i in 0..<equations.count {
            let (a, b) = (equations[i][0], equations[i][1])
            graph[a, default: [(String, Double)]()].append((b, values[i]))
            graph[b, default: [(String, Double)]()].append((a, 1/values[i]))
        }
        
        // dfs
        func dfs(_ start: String, _ end: String, _ visited: inout Set<String>) -> Double {
            if start == end { return 1.0 }
            visited.insert(start)
            guard let neighbors = graph[start] else { return -1.0 }
            for (neighbor, value) in neighbors {
                if !visited.contains(neighbor) {
                    let res = dfs(neighbor, end, &visited)
                    if res != -1.0 {
                        return res * value
                    }
                }
            }
            return -1.0
        }
        
        // check
        var res = [Double]()
        for query in queries {
            let (a, b) = (query[0], query[1])
            if graph.keys.contains(a), graph.keys.contains(b) {
                var visited = Set<String>()
                res.append(dfs(a, b, &visited))
            } else {
                res.append(-1.0)
            }
        }
        return res
    }
}
