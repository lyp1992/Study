# Struct 、Class、enum 
### 1.下面代码能运行吗？
	class Size {
	
		var width: Int = 1
		var height: Int = 2
		init(w: Int, h: Int){
			self.width = w
			self.height = h
		}
	}
	
	struct Point {
		var x: Int = 3
		var y: Int = 4
	}
	
	
	func testInterView() {
		let size = Size(w: 10, h: 20)
		size.height = 30
		size.width = 40
		
		let p = Point(x: 10, y: 20)
		p.x = 20
		p.y = 30
	
	}
	
### 2. 下面size类和point结构体的内存结构是怎么样的，size和point分别占用多少个字节
	class Size {
		var width: Int = 1
		var height: Int = 2
	}
	struct Point {
		var x: Int = 3
		var y: Int = 4
	}
	
### 3. 简述一下class 的创建过程？


### 4. 枚举的内存结构是怎么样的？ 原始值和关联值有什么区别？
	enum Season {
		case spring, summer, autumn, winter
	}
	
	enum Password {
		case number (Int, Int, Int)
		case other
	}

### 5. 枚举在switch内部是根据什么判断条件的？