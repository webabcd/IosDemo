/*
 * 本例用于演示方法，下标
 * 实例方法，类方法，self，在方法中修改属性，在方法中为 self 分配一个新的实例，下标 []
 *
 * [] 是下标运算符（subscript operator）
 */

import SwiftUI

struct SwiftView09: View {
    
    var result: String = ""
    
    init() {
        result = sample1() // 实例方法，类方法，self，在方法中修改属性，在方法中为 self 分配一个新的实例
        result += "\n"
        result += sample2() // 下标 []
        result += "\n"
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
        var a = SwiftView09_Struct1()
        
        let b = a.func1()
        let c = a.func2() // 这里要注意一下：因为 func2() 会修改值类型的属性，所以 a 不能是 let 常量
        let d = a.func3()
        
        let e = SwiftView09_Struct1.func4()
        
        return "\(b), \(c), \(d), \(e)"
    }

    func sample2() -> String {
        var a = SwiftView09_Struct2()
        
        // 设置指定下标的值
        a[100] = "webabcd"
        // 获取指定下标的值
        let b = a[100]
        
        // 下标可以支持多个输入参数
        let c = a[10, 20]
        
        // 类下标
        let d = SwiftView09_Struct2[100]
        
        return "\(b), \(c), \(d)";
    }
}

struct SwiftView09_Struct1 {
    var name: String = "webabcd"
    
    // 实例方法
    func func1() -> String {
        // self 指的是实例本身（可以省略）
        return self.name
    }
    
    // 如果想在方法中修改属性的话，需要用 immutable 修饰方法，否则编译时报错（Cannot assign to property: 'self' is immutable）
    mutating func func2() -> String {
        self.name = "wanglei" // 可以修改属性了
        return self.name
    }
    
    // 如果想在方法中为 self 分配一个新的实例的话，需要用 immutable 修饰方法，否则编译时报错（Cannot assign to value: 'self' is immutable）
    mutating func func3() -> String {
        self = SwiftView09_Struct1(name: "wangrx") // 可以为 self 分配新的实例了
        return self.name
    }
    
    // 类方法
    static func func4() -> String {
        return "static func"
    }
}


struct SwiftView09_Struct2 {
    private var _dict = [Int : String]()
    // 实例下标，通过 subscript 实现，参见下面的代码
    subscript(index: Int) -> String {
        get {
            return _dict[index] ?? ""
        }
        set (newValue) {
            _dict[index] = newValue
        }
    }
    
    // 下标可以支持多个输入参数
    subscript(rows: Int, columns: Int) -> String {
        get {
            return "rows:\(rows), columns:\(columns)"
        }
    }
    
    // 类下标
    static subscript(index: Int) -> String {
        return "index: \(index)"
    }
}
