
public enum Colors {
    case blue, green, magenta
}

public extension String {
    func colorized(color: Colors) -> String {
        switch color {
        case .blue:
            return "\u{001B}[0;34m\(self)\u{001B}[0;39m"
        case .green:
            return "\u{001B}[0;32m\(self)\u{001B}[0;39m"
        default:
            return "\u{001B}[0;35m-\u{001B}[0;39m"
        }
    }
}

public extension Array {
    func splitBy(subSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: subSize).map { startIndex in
            var endIndex = startIndex + subSize
            if endIndex > self.count {
                endIndex = self.count
            }
            return Array(self[startIndex ..< endIndex])
        }
    }

    // adapted from ExSwift
    func combination(length: Int) -> [[Element]] {
        if length < 0 || length > self.count {
            return []
        }
        var indexes: [Int] = (0..<length).map { $0 }
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
