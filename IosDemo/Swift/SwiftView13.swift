/*
 * 本例用于演示协议（协议定义，协议继承，协议实现，协议的类型约束，约束符合某一协议，约束同时符合多个协议，协议的类型判断，协议的类型转换，结构体可以自动实现 Equatable 协议和 Hashable 协议，枚举可以自动实现 Comparable 协议，关联类型 associatedtype，通过类型别名 typealias 实现协议的关联类型，通过泛型实现协议的关联类型，在使用时或在声明时定义协议的关联类型的 where 子句和类型约束，可选协议）
 *
 * 协议（protocol）类似接口（interface）
 */

import SwiftUI

struct SwiftView13: View {
    
    var result: String = ""
    
    init() {
        result = sample1() // 协议定义，协议继承，协议实现
        result += "\n"
        result += sample2() // 协议的类型约束，约束符合某一协议，约束同时符合多个协议，协议的类型判断，协议的类型转换
        result += "\n"
        result += sample3() // 结构体可以自动实现 Equatable 协议和 Hashable 协议，枚举可以自动实现 Comparable 协议
        result += "\n"
        result += sample4() // 关联类型 associatedtype，通过类型别名 typealias 实现协议的关联类型，通过泛型实现协议的关联类型，在使用时或在声明时定义协议的关联类型的 where 子句和类型约束
    }

    var body: some View {
        VStack {
            HStack {
                Text(result)
                Spacer()
            }
            Spacer()
        }
    }
    
    func sample1() -> String {
        let a = SwiftView13_Struct1(name: "webabcd", age: 40, salary: 2000)
        let b = a.getMessage()
        let c = SwiftView13_Struct1.avgHeight
        
        return "\(b), \(c)"
    }

    
    func sample2() -> String {
        let a = SwiftView13_Struct1(name: "webabcd", age: 40, salary: 2000)
        
        // 演示协议如何用于类型约束
        let b = func1(a: a)
        let c = func2(a: a)
        
        // 指定协议类型（可以指定同时符合多个协议，多个协议通过 & 分隔）
        var d = [SwiftView13_Protocol1 & SwiftView13_Protocol2]()
        d.append(a)
        
        // 协议支持类型判断（is）和类型转换（as, as?, as!）
        let e = a is SwiftView13_Protocol3
        let f = a is SwiftView13_Protocol2
        let g = a is SwiftView13_Protocol1
        let h = (a as SwiftView13_Protocol1).name
        
        return "\(b), \(c), \(d), \(e), \(f), \(g), \(h)"
    }
    // 协议用于类型约束，约束参数必须符合某个协议
    func func1(a: SwiftView13_Protocol1) -> String {
        return a.name
    }
    // 协议用于类型约束，约束参数必须同时符合多个协议（通过 & 分隔）
    func func2(a: SwiftView13_Protocol1 & SwiftView13_Protocol2) -> String {
        return "name:\(a.name), age:\(a.age)"
    }
    
    
    func sample3() -> String {
        let a = SwiftView13_Struct2(name: "webabcd")
        let b = SwiftView13_Struct2(name: "webabcd")
        
        // 实现了 Equatable 协议，就可以通过 == 和 != 判断是否相等
        let c = a == b // true
        
        // 实现了 Hashable 协议，就可以通过 hashValue 生成哈希值
        let d = a.hashValue
        let e = b.hashValue
        
        // 实现了 Comparable 协议，就可以通过 <, <=, >, >= 比较大小，其类型数组也可以通过 sorted() 排序
        let f:[SwiftView13_Enum1] = [.e3, .e2, .e1]
        let g = f.sorted() // [.e2, .e1, .e3]
        
        return "\(c), \(d), \(e), \(g)"
    }
    
    
    func sample4() -> String {
        // 协议的关联类型的使用（通过类型别名 typealias 实现协议的关联类型）
        let a = SwiftView13_Struct3(name: "webabcd")
        let b = a.name
        
        // 协议的关联类型的使用（通过泛型实现协议的关联类型）
        let c = SwiftView13_Struct4<String>(name: "wanglei")
        let d = c.name
        
        // func3() 方法演示了如何在使用时定义协议的关联类型的 where 子句和类型约束
        let e = func3(a: a, b: c)
        
        return "\(b), \(d), \(e)"
    }
    // 在使用时，定义协议的关联类型的 where 子句和类型约束
    func func3<T1: SwiftView13_Protocol4, T2: SwiftView13_Protocol4>(a: T1, b: T2) -> String
    // 如下代码会要求 T1 的 MyType 关联类型与 T2 的 MyType 关联类型要类型相同，且 T1 的 MyType 关联类型要实现 Equatable 协议
    where T1.MyType == T2.MyType, T1.MyType: Equatable {
        return "a:\(a.name), b:\(b.name)"
    }
}


// 协议定义与协议继承
protocol SwiftView13_Protocol1 {
    var name: String { get }
}
protocol SwiftView13_Protocol2 {
    var age: Int { get set }
}
protocol SwiftView13_Protocol3: SwiftView13_Protocol1, SwiftView13_Protocol2 {
    init(name: String, age: Int, salary: Int)
    var salary: Int { get }
    func getMessage() -> String
    static var avgHeight: Int { get }
}
// struct 和 class 都可以实现协议
// 如果要求只能由类实现协议，则协议继承 AnyObject 即可
struct SwiftView13_Struct1: SwiftView13_Protocol3 {
    var name: String
    var age: Int
    var salary: Int
    
    init(name: String, age: Int, salary: Int) {
        self.name = name
        self.age = age
        self.salary = salary
    }
    
    func getMessage() -> String {
        return "name:\(self.name), age:\(self.age), salary:\(self.salary)"
    }
    
    static var avgHeight: Int {
        get {
            return 100
        }
    }
}


// 结构体可以自动实现 Equatable 协议（可以通过 == 和 != 判断是否相等）和 Hashable 协议（可以通过 hashValue 生成哈希值）
struct SwiftView13_Struct2: Equatable, Hashable {
    var name: String
}
// 枚举可以自动实现 Comparable 协议（可以通过 <, <=, >, >= 比较大小）
// 大小与 case 顺序一致，下例 e2 < e1 < e3
enum SwiftView13_Enum1: Comparable {
    case e2, e1, e3
}


protocol SwiftView13_Protocol4 {
    // 通过 associatedtype 声明一个关联类型（协议中是没有泛型的概念的，有类似需求的话就用关联类型来实现）
    associatedtype MyType
    var name: MyType { get set }
    
    // 在声明时，定义协议的关联类型的 where 子句和类型约束
    // 约束关联类型 XXX 要实现 Equatable 协议和 SwiftView13_Protocol4 协议，且 XXX 的 MyType 与当前协议的 MyType 要类型相同
    // associatedtype XXX: Equatable, SwiftView13_Protocol4 where XXX.MyType == MyType
}
// 通过类型别名 typealias 实现协议的关联类型
struct SwiftView13_Struct3: SwiftView13_Protocol4 {
    typealias MyType = String
    var name: MyType
}
// 通过泛型实现协议的关联类型
struct SwiftView13_Struct4<T>: SwiftView13_Protocol4 {
    var name: T
}


// @objc 标记的协议用于与 objective-c 中的协议互操作
// @objc optional 相当于 objective-c 中的可选协议
@objc protocol SwiftView13_Protocol5 {
    @objc optional func function1()
    @objc optional var property1: Int { get set }
}

