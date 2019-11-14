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
