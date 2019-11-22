//
//  interview.swift
//  SwiftClassAndStruct
//
//  Created by 赖永鹏 on 2019/11/14.
//  Copyright © 2019 LYP. All rights reserved.
//

import Foundation

class Size {
    var width : Int = 1
    var height : Int = 2
    init(w: Int, h: Int) {
        self.width = w;
        self.height = h;
    }
}

struct Point {
    var x : Int = 3
    var y : Int = 4
   
}

// 1. 下面的代码能运行吗
func testInterView()  {
    
    let size = Size(w: 10, h: 20)
    size.height = 30
    size.width = 40

    let p = Point(x: 10, y: 20)
    p.x = 20;
    p.y = 30;
}

// 2. 下面size类和point结构体的内存结构是怎么样的？ size和point分别占用多少个字节
class Size {
    var width : Int = 1
    var height : Int = 2
}

struct Point {
    var x : Int = 3
    var y : Int = 4
   
}
// 3. class 的创建过程是什么？

// 4. 枚举的内存结构是什么样的？ 原始值和关联值有什么区别？
enum Season {
    case spring,summer,autumn,winter
}

enum Password {
    case number (Int, Int, Int, Int)
    case other
}


// 5. 枚举在switch种内部是怎么判断条件的？


// 6. 手写一个方法前缀，比如：xx.BD.instert.....

/**
 
 6.1 建立一个base，
 6.2 建立一个协议
 6.3 实现遵守base的协议类
 
 */
