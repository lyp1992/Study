import UIKit


func sum(_ numbers: Int...) -> Int {

    var total = 0
    for number in numbers {
        total += number
    }
    return total
}

sum(1, 2, 3)


func sum(v1 : Int, v2: Int) -> Int {
    v1 + v2
}

func difference(v1: Int, v2: Int) -> Int {
    v1 - v2
}

func printResult(_ mathPath:(Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("math = \(mathPath(a,b))")
}
printResult(sum, 1, 2) // 3
printResult(difference, 2, 1) // 1


typealias Byte = Int8
typealias Short = Int16
typealias IntFn = (Int, Int, Int) -> Int

func difference(v1: Int, v2: Int, v3: Int) -> Int {
    v1 - v2 - v3
}
let fn: IntFn = difference
fn(10, 20,30) // -40
