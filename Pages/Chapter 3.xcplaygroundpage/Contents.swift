//: [Previous](@previous)

import Foundation

infix operator ?? { associativity right precedence 110 }

func ??<T>(optional: T?, @autoclosure defaultValue: () -> T) -> T {
    if let x = optional {
        return x
    } else {
        return defaultValue()
    }
}

var test: Int? = nil

let result = test ?? 8


//: [Next](@next)
