/*
 * 本例用于演示 extension 扩展
 * 为指定类型扩充新的属性，方法，下标，协议实现，嵌套类型，为指定结构体扩充新的初始化器，为指定类扩充新的初始化器，为指定类型新增泛型的类型约束（通过 where : 约束泛型属于某个类或某个协议，通过 where == 约束泛型属于某个值类型），为指定协议扩充新的逻辑（所有实现此协议的类型，都会自动扩充此处的新逻辑）
 *
 * 注：extension 用于扩充某类型的功能，但是不能扩充新的可保存的属性，也不能 override 已有功能
 */

import SwiftUI

struct SwiftView14: View {
    
    var result: String = ""
    
    init() {
        result = sample1() // 为指定类型扩充新的属性，方法，下标
        result += "\n"
        result += sample2() // 为指定类型扩充新的协议实现，嵌套类型，为指定结构体扩充新的初始化器
        result += "\n"
        result += sample3() // 为指定类型新增泛型的类型约束（通过 where : 约束泛型属于某个类或某个协议，通过 where == 约束泛型属于某个值类型），为指定类扩充新的初始化器
        result += "\n"
        result += sample4() // 为指定协议扩充新的逻辑（所有实现此协议的类型，都会自动扩充此处的新逻辑）
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
        let a = 3.14
        let b = a.intValue // 3
        let c = a.toInt() // 3
        let d = a[2] // 6
        
        return "\(b), \(c), \(d)"
    }

    func sample2() -> String {
        let a = SwiftView14_Struct1(age: 40)
        let b = a.name
        let c = a.getMessage()
        let d = a.getMyEnum()
        
        return "\(b), \(c), \(d)"
    }
    
    func sample3() -> String {
        let a = SwiftView14_Class1<String>(name: "webabcd")
        let b = a.name
        let c = a.age
        
        return "\(b), \(c)"
    }
    
    func sample4() -> String {
        let a = SwiftView14_Class2(name: "webabcd")
        let b = a.getMessage()
        
        return "\(b)"
    }
}


// 通过 extension 为指定类型扩充新的属性，方法，下标
extension Double {
    var intValue: Int {
        return Int(self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    subscript(a: Int) -> Int {
        return Int(self) * a
    }
}


protocol SwiftView14_Protocol1 {
    func getMessage() -> String
}
struct SwiftView14_Struct1 {
    var name: String = "webabcd"
}
// 通过 extension 为指定类型扩充新的协议实现，嵌套类型，为指定结构体扩充新的初始化器
extension SwiftView14_Struct1: SwiftView14_Protocol1 { // 扩充新的协议实现
    init(age: Int) { // 为结构体扩充新的初始化器（为类扩充新的初始化器会有一些不一样，后面会说）
        self.name = "\(self.name) \(age)"
    }
    
    func getMessage() -> String {
        return self.name
    }
    
    func getMyEnum() -> MyEnum {
        return .e1
    }
    enum MyEnum { // 扩充新的嵌套类型
        case e1, e2, e3
    }
    
    // 注：不能扩充新的可保存的属性，比如下面这句会报错 Extensions must not contain stored properties
    // var xxx = 100
}


class SwiftView14_Class1<T> {
    var name: T
    var age: Int
    init(name: T, age: Int) {
        self.name = name
        self.age = age
    }
}
// 通过 extension 为指定类型新增泛型的类型约束（通过 where : 约束泛型属于某个类或某个协议），为指定类扩充新的初始化器
extension SwiftView14_Class1 where T: Equatable {
    // 注：不能扩充新的可保存的属性，比如下面这句会报错 Extensions must not contain stored properties
    // var xxx = 100

    convenience init(name: T) { // 为类扩充新的初始化器
        // 注意：这里访问不了 self.name 之类的（extension 结构体是可以的），只能调用 self.init()，所以 init() 要用 convenience 修饰
        self.init(name: name, age: 100)
    }
}
// 通过 extension 为指定类型新增泛型的类型约束（通过 where == 约束泛型属于某个值类型）
extension SwiftView14_Class1 where T == String {

}


protocol SwiftView14_Protocol2 {
    var name: String { get set }
}
struct SwiftView14_Class2: SwiftView14_Protocol2 {
    var name: String
}
// 通过 extension 为指定协议扩充新的逻辑（所有实现此协议的类型，都会自动扩充此处的新逻辑）
// 也就是说通过此方式可以在协议中实现具体逻辑，而在协议定义中是做不到这一点的
extension SwiftView14_Protocol2 {
    func getMessage() -> String {
        return self.name
    }
}
