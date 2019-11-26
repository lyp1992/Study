# struct、class、enum

### 1. 初始化器的差别
> 结构体可以自动生成可以为属性传值的初始化器
![struct](/Users/laiyongpeng/Desktop/技术分享文档/Study/Swift/Struct、class、enum（二）/结构体初始化器.png)   

class 如果不给他赋初始值，系统会报 *class xxx has no initializers*  
![class](/Users/laiyongpeng/Desktop/技术分享文档/Study/Swift/Struct、class、enum（二）/类初始化器.png)

> 结构体内只有变量占据内存。类除了变量占据内存，还给指向对象类型信息，和引用计算分配了内存 

	func test() {
		class Size {
			var w = 1
			var h = 2
		}
		
		struct Point {
			var x = 3
			var y = 4
		}
		
		/**
		打印内存的方法，可以使用系统自带的MemoryLayout.
		网上有基于MemoryLayout的开源框架。
		*/
		var p = Point()
		/**
		size : 需要占用多少内存
		stride: 系统实际给分配多少内存
		*/
		print(MemoryLayout<Point>.size) // 8 + 8 = 16
		print(MemoryLayout<Point>.stride) // 16
	
	} 

这里我们需要注意的是stride，系统实际分配的内存，会有一个内存对齐。比如：
	
	struct Point {
		var x = 3
		var y = 4
		var origin: Bool = false
	}
	
		print(MemoryLayout<Point>.size) // 8 + 8 + 1 = 17
		print(MemoryLayout<Point>.stride) // 24 ，24就是内存对齐之后的实际内存
	
接下来我们来看看class 和struct的内存结构：这里我用了一段网上的开源代码，方便我打印内存地址和窥探内存地址中存储的数据

	var size = Size()
	
	print("size的内存大小",Mems.size(ofRef: size))
	print("size变量地址", Mems.ptr(ofVal: &size))
    print("size变量的内存",Mems.memStr(ofVal: &size))

    print("size所指向内存的地址",Mems.ptr(ofRef: size))
    print("size所指向内存的内容",Mems.memStr(ofRef: size))

在控制台上打印出来：
![](/Users/laiyongpeng/Desktop/技术分享文档/Study/Swift/Struct、class、enum（二）/size的内存结构.png)
通过控制台，我们看到一个size，
> 1. 占用了32个字节，前16个字节分别指向的类型信息，引用计数。后8个字节才是实际为变量分配的内存。
> 2. class 创建出来系统分配的是堆空间。

我在下面画一个图

栈空间：

|  内存地址          | 内存数据            | 说明|
| ------           | ------             |-----|
|0x00007ffeefbff400| 0x00000001007040a0 |size对象的内存地址|

 堆空间：
 
 
|  内存地址          | 内存数据            |  说明 |
| ------           | ------             |   ----|
| 0x00000001007040a0 | 0x00000001000087a0 | 指向类型信息|
| 0x00000001007040a8 | 0x0000000200000002 | 引用计数 |
| 0x00000001007040b0 | 0x0000000000000001 |size.w|
| 0x00000001007040b8 | 0x0000000000000002 |size.h|

接着打印 Point
	
	var p = Point()
	print("point的占用内存大小",Mems.size(ofVal: &point))
    print("point的指向内存大小",Mems.size(ofRef: point))
    print("point变量地址", Mems.ptr(ofVal: &point))
    print("point变量的内存",Mems.memStr(ofVal: &point))

    print("point所指向内存的地址",Mems.ptr(ofRef: point))
    print("point所指向内存的内容",Mems.memStr(ofRef: point))
 打印的结果是：
 ![](/Users/laiyongpeng/Desktop/屏幕快照 2019-11-22 上午11.04.07.png)
 
 这个结果可以看出，point结构体创建出来的内存就是实际内存，没有指向其他的空间。而且会发现我前后在方法test（）里面同时创建的size和point，两个的内存地址分别是 0x00007ffeefbff400、0x00007ffeefbff3d0，其实特别相近。

我总感觉他这个工具是有点问题的，所以我通过汇编找到了size的真正地址应该是 0x00007ffeefbff410。其实就是相差16个字节。正好符合point的内存大小。下面我简述一下操作过程
> 1. 断点打在 point（）这行
![](/Users/laiyongpeng/Desktop/技术分享文档/Study/Swift/Struct、class、enum（二）/point断点处.png)

> 2. 打开xcode的工具
![](/Users/laiyongpeng/Desktop/技术分享文档/Study/Swift/Struct、class、enum（二）/xcode工具使用.png)

> 3. 来到point.init() 方法,同时记住下面那两行连续的%rbp内存空间
![](/Users/laiyongpeng/Desktop/技术分享文档/Study/Swift/Struct、class、enum（二）/point 创建.png)
> 4. 在控制台上输入指令 si，表示进入point.init() 内部。 在这里可以清晰的看见，系统开辟了一段连续的%rbp内存空间，并分别将$0X3 ,$0X4 放到了rbp中
![](/Users/laiyongpeng/Desktop/技术分享文档/Study/Swift/Struct、class、enum（二）/point 内存地址返回.png)

> 5. 然后直接在控制台上敲si，知道retq，或者直接敲finish
> 6. 然后断点回来到 第3步的第二行； 
	
	0x100004ed6 <+310>:  movq   %rax, -0x20(%rbp)

接着在控制台敲 指令si， 然他走到第三行。控制台指令：register read rbp，得到rbp的内存地址是 0x00007ffeefbff410 。然后可以用计算器计算出，0x00007ffeefbff410 偏移 -0x20 和 -0x18 内存前8个字节存放的就是 3 和 4。

**得出结论:在test（）方法内创建的size和point 可以看成以下结构**

|  内存地址          | 内存数据            | 说明|
| ------           | ------             |-----|
|0x00007ffeefbff400| 0x00000001007040a0 |size对象的内存地址|
| 0x00007ffeefbff410 偏移 -0x20| 3                 | Point.x|
| 0x00007ffeefbff410 偏移 -0x18| 4                 | Point.y|

**看到这里就可以回答面试题 1 和 2 **

### 面试题3 ： class的创建过程
> 1. __allocating_init()
> 2. libswiftCore.dylib`swift_allocObject:
> 3. libswiftCore.dylib`swift_slowAlloc:
> 4. libswiftCore.dylib`malloc:

具体 的验证过程可以通过汇编

### 面试题4 ： 枚举的内存结构是怎么样的？ 原始值和关联值有什么区别？
	
	enum Season {
		case spring, summer, autumn, winter
	}
	
	enum Password {
		case number (Int, Int, Int)
		case other
	}
	print("关联值的实际内存大小",MemoryLayout<Season>.size) // 1
	print("关联值的系统内存大小",MemoryLayout<Season>.stride) // 1
	print("关联值的实际内存大小",MemoryLayout<Password>.size) // 25 3 * 8 + 1 = 25
	print("关联值的系统内存大小",MemoryLayout<Password>.stride) // 32 内存对齐
