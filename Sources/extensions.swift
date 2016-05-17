public extension CountableRange {
    public var array: [Element] {
        return self.map { $0 }
    }   
}

public extension Int {
    public func times(f: () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
    
    public func times(f: @autoclosure () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
}

public extension Array {
    public func splitBy(subSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: subSize).map { startIndex in
            var endIndex = startIndex + subSize
            if endIndex > self.count {
                endIndex = self.count
            }
            return Array(self[startIndex ..< endIndex])
        }
    }

    // adapted from ExSwift
    public func permutation(length: Int) -> [[Element]] {
        if length < 0 || length > self.count {
            return []
        } else if length == 0 {
            return [[]]
        } else {
            var permutations: [[Element]] = []
            let combinations = combination(length: length)
            for combination in combinations {
                var endArray: [[Element]] = []
                var mutableCombination = combination
                permutations += self.permutationHelper(n: length, array: &mutableCombination, endArray: &endArray)
            }
            return permutations
        }
    }
    // adapted from ExSwift, updated for Swift 2.1
    private func permutationHelper(n: Int, array: inout [Element], endArray: inout [[Element]]) -> [[Element]] {
        if n == 1 {
            endArray += [array]
        }
        for i in 0..<n {
            permutationHelper(n: n - 1, array: &array, endArray: &endArray)
            let j = n % 2 == 0 ? i : 0;
            let temp: Element = array[j]
            array[j] = array[n - 1]
            array[n - 1] = temp
        }
        return endArray
    }
    // adapted from ExSwift
    public func combination(length: Int) -> [[Element]] {
        if length < 0 || length > self.count {
            return []
        }
        var indexes: [Int] = (0..<length).array
        var combinations: [[Element]] = []
        let offset = self.count - indexes.count
        while true {
            var combination: [Element] = []
            for index in indexes {
                combination.append(self[index])
            }
            combinations.append(combination)
            var i = indexes.count - 1
            while i >= 0 && indexes[i] == i + offset {
                i -= 1
            }
            if i < 0 {
                break
            }
            i += 1
            let start = indexes[i-1] + 1
            for j in (i-1)..<indexes.count {
                indexes[j] = start + j - i + 1
            }
        }
        return combinations
    }
}
