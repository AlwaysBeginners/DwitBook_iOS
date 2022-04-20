//  StringExtension.swift
//  DwitBook

import Foundation

extension String {
    var onlyWhiteSpace: Bool {
        for character in self {
            if character != " " {return false}
        }
        return true
    }
    
    func removeForwardWhiteSpaces() -> String {
        var startPoint: Int = 0
        for (i, char) in self.enumerated() {
            if char != " " {
                startPoint = i
                break
            }
        }
        let index = self.index(self.startIndex, offsetBy: startPoint)
        return String(self[index...])
    }
}
