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
//
//var p = Point(1, 2)


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
////    print("size变量地址", Mems.ptr(ofVal: &size))
////    print("size变量的内存",Mems.memStr(ofVal: &size))
//
//    print("size所指向内存的地址",Mems.ptr(ofRef: size))
//    print("size所指向内存的内容",Mems.memStr(ofRef: size))
//
//    var point = Point()
//    print("point变量地址", Mems.ptr(ofVal: &point))
//    print("point变量的内存",Mems.memStr(ofVal: &point))
//
//    print("point所指向内存的地址",Mems.ptr(ofRef: point))
//    print("point所指向内存的内容",Mems.memStr(ofRef: point))
//
//}
//test()

enum Password {
    case number (Int, Int, Int)
    case string(String)
    case other
}
  
func test() {
    
    var pwd = Password.number(1, 2, 3)
//    print("pwd = ", Mems.ptr(ofVal: &pwd))
    pwd = Password.string("hello world")
//    pwd = Password.other
    
    switch pwd {
    case let .number(n1, n2, n3):
        print("num is ,", n1, n2, n3)
    case let .string(str):
        print("is string", str)
    default:
        print("is other")
    }
}

test()
