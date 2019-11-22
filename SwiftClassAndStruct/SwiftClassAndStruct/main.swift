//
//  main.swift
//  SwiftClassAndStruct
//
//  Created by 赖永鹏 on 2019/11/13.
//  Copyright © 2019 LYP. All rights reserved.
//

import Foundation

//struct Point {
//    var x : Int
//    var y : Int
//    var origin : Bool = false
//}
//
//var p = Point(x: 1, y: 1)
//
//print(MemoryLayout<Point>.size) // 17 = 8+ 8 + 1
//print(MemoryLayout<Point>.stride) // 24 内存对齐


//class Point {
//    var x : Int
//    var y : Int
//    init(_ x: Int, _ y: Int) {
//        self.x = x
//        self.y = y
//    }
//}


// 本质区别
//func test(){
//
//    class Size {
//        var width : Int = 1
//        var height : Int = 2
//    }
//
//    struct Point {
//        var x : Int = 3
//        var y : Int = 4
//    }
//
//    var size = Size()
//
////    print("size的指向内存大小",Mems.size(ofRef: size))
////    print("size的占用内存大小",Mems.size(ofVal: &size))
//    print("size变量地址", Mems.ptr(ofVal: &size))
//    print("size变量的内存",Mems.memStr(ofVal: &size))
//
//    print("size所指向内存的地址",Mems.ptr(ofRef: size))
//    print("size所指向内存的内容",Mems.memStr(ofRef: size))
//
//    var point = Point()
//    print("point的占用内存大小",Mems.size(ofVal: &point))
//    print("point的指向内存大小",Mems.size(ofRef: point))
//    print("point变量地址", Mems.ptr(ofVal: &point))
//    print("point变量的内存",Mems.memStr(ofVal: &point))
//
//    print("point所指向内存的地址",Mems.ptr(ofRef: point))
//    print("point所指向内存的内容",Mems.memStr(ofRef: point))
//}
//test()

enum YPStrEnum: String {
    case num1 = "ewrtyuio"
    case num2 = "fghjkjhgfcvbnmbvcvbnbvcvbnm"
    case num3 = "cvbnmertyuklvcvbn"
}
//
//var numStr = YPStrEnum.num1
//var nummstr2 = YPStrEnum.num2
//var numstr3 = YPStrEnum.num3
//print("YPStrEnum===", MemoryLayout<YPStrEnum>.size)
//print("内存",Mems.ptr(ofVal: &numStr))
//print("内存",Mems.ptr(ofVal: &nummstr2))
//print("内存",Mems.ptr(ofVal: &numstr3))
//print(numstr3.rawValue)

enum Season {
    case spring, summer, autumn, winter
}

enum Password {
    case number2 (Int, Int, Int, Int)
    case number (Int, Int, Int)
    case other
}

//var other = Password.other
//var p = Password.number(10, 11, 12)
//var p2 = Password.number2(10, 11, 12, 13)
//print(Mems.ptr(ofVal: &p2))
//print(Mems.ptr(ofVal: &p))
//print(Mems.ptr(ofVal: &other))
//
//var sea = Season.spring
////
//print("关联值的实际内存大小",MemoryLayout<Season>.size) // 1
//print("关联值的系统内存大小",MemoryLayout<Season>.stride) // 1
//print("关联值的实际内存大小",MemoryLayout<Password>.size) // 33
//print("关联值的系统内存大小",MemoryLayout<Password>.stride) // 40

struct BD<Base>  {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}
protocol BDCompatible { }
extension BDCompatible {

    static var bd: BD<Self>.Type {
        get {
            BD<Self>.self
        }
        set { }
    }
    var bd: BD<Self> {
        get {
            BD(self)
        }
        set { }
    }
}
extension String: BDCompatible {}
extension BD where Base == String {
    static func numberCount(_ str: String) -> Int {

        var count: Int = 0
        for c in str where("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
    
    func numberCount() -> Int {
           var count: Int = 0
            for c in base where("0"..."9").contains(c) {
                 count += 1
            }
            return count
    }
    
}

//extension Array : BDCompatible{}
//extension BD where Base == Array {
//    func arryCount() -> Int {
//        return 10
//    }
//}

print(String.bd.numberCount("2345fghjkfg5678"))
print("456hgfdgh5678".bd.numberCount())


//class Size {
//
//    var width: Int = 1
//    var height: Int = 2
//    init(w: Int, h: Int){
//        self.width = w
//        self.height = h
//    }
//}
//
//struct Point {
//    var x: Int = 3
//    var y: Int = 4
//}


//func testInterView() {
//    let size = Size(w: 10, h: 20)
//    size.height = 30
//    size.width = 40
//
//    let p = Point(x: 10, y: 20)
//    p.x = 20
//    p.y = 30
//
//    var p1 = Point(x: 11, y: 21)
//
//    print(Mems.ptr(ofVal: &p1))
//
//    p1.x = 20
//    p1.y = 30
//    print(Mems.ptr(ofVal: &p1))
//}

//testInterView()
