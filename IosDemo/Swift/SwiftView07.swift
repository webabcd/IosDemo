/*
 * 本例用于演示枚举（枚举基础，省略枚举类型的枚举值，指定原始类型的枚举值，遍历枚举值，枚举值是一个关联值，通过 switch 判断枚举值，通过 if 判断枚举值，枚举递归，枚举中的方法，枚举中的下标）
 */

import SwiftUI

struct SwiftView07: View {
    
    var result: String = "";
    
    init() {
        result = sample1() // 枚举基础，省略枚举类型的枚举值，指定原始类型的枚举值
        result += "\n";
        result += sample2() // 遍历枚举值
        result += "\n";
        result += sample3() // 枚举值是一个关联值，通过 switch 判断枚举值，通过 if 判断枚举值
        result += "\n";
        result += sample4() // 枚举递归
        result += "\n";
        result += sample5() // 枚举中的方法，枚举中的下标
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
        // 指定一个枚举值
        var a = Enum1.e1 // 枚举值是 Enum1.e1
        // 修改枚举值（如果枚举类型确定了，则可以省略枚举类型）
        a = .e2 // 枚举值是 Enum1.e2
        
        // 如果枚举类型确定了，则可以省略枚举类型
        let b: Enum1 = .e3  // 枚举值是 Enum1.e3
        
        // 原始类型为 Int 的枚举
        let c = Enum2.e2  // 枚举值是 Enum2.e2
        let d = c.rawValue // 枚举值 Enum2.e2 的原始值是 101
        
        // 通过指定枚举的原始值来初始化枚举
        let e = Enum2(rawValue: 101) // 这是一个可空类型，e! 是 Enum2.e2
        let f = Enum2(rawValue: 0) // 这是一个可空类型，f 是 nil
        
        return "\(a), \(b), \(c), \(d), \(e!), \(f)"
    }
    // 定义一个枚举
    // 注意：枚举值并不是整型，Enum1.e1 的枚举值就是 Enum1.e1，并不是 0 之类的
    enum Enum1 {
        case e1
        case e2
        case e3, e4, e5
    }
    // 定义一个指定了原始类型的枚举
    // 下面这个枚举的原始类型是 Int 类型，可以通过类似 Enum2.e1.rawValue 获取枚举值的原始值
    enum Enum2: Int {
        case e1 = 100 // 指定此枚举值的原始值为 100
        case e2       // 此枚举值的原始值为 101
        case e3       // 此枚举值的原始值为 102
    }

    
    
    func sample2() -> String {
        // 支持 CaseIterable 协议的枚举可以通过 allCases 遍历枚举值
        for item in Enum3.allCases {
            print(item)
        }
        
        return ""
    }
    // 将枚举标记为支持 CaseIterable 协议（这样就可以通过 allCases 遍历枚举值了）
    enum Enum3: CaseIterable {
        case e1
        case e2
        case e3
    }
    
    
    
    func sample3() -> String {
        let a: Enum4 = .e1
        let b: Enum4 = .e2(1, 2) // 初始化一个枚举值（此枚举值是一个关联值）
        
        // 通过 switch 判断枚举值
        switch a {
        case .e1:
            print("a is .e1")
        default :
            print("impossible")
        }
        
        // 通过 switch 判断枚举值（此枚举值是一个关联值）
        switch b {
        case .e2(_, _): // 类似的 case .e2(1, _):, case .e2(_, 2):, case .e2(1, 2): 之类的就不详细说了
            print("a is .point")
        default :
            print("impossible")
        }
        
        // 通过 switch 判断枚举值（此枚举值是一个关联值）
        switch b {
        case let .e2(x, y): // 将枚举值的关联值赋值给 x 和 y，类似的还有 let .e2(_, y):, let .e2(x, _):, let .e2(1, y):, let .e2(x, 2): 之类的就不详细说了
            print("\(x), \(y)")
        default :
            print("impossible")
        }
        
        // 通过 if 判断枚举值
        if case .e2(_, 2) = b {
            print("case .e2(_, 2) = b")
        }
        
        // 通过 if 判断枚举值
        if case .e1 = a {
            print("case .e1 = a")
        }
        
        return "\(a), \(b)"
    }
    enum Enum4 {
        case e1
        // 枚举值是一个关联值
        // 下面这个枚举值是由 2 个 Int 类型的数据决定的
        case e2(Int, Int)
    }
    
    
    
    func sample4() -> String {
        let a = Enum5.e1
        let b = Enum5.e2(a)
        
        return "\(a), \(b)"
    }
    // 通过 indirect 修饰的枚举可以支持枚举递归
    indirect enum Enum5 {
        case e1
        case e2(Enum5) // 枚举递归
    }
    
    
    
    func sample5() -> String {
        var a: Enum6 = .e1
        print(a) // e1
        a.next() // 调用枚举中的方法（这个是实例方法）
        print(a) // e2
        a.next()
        print(a) // e3
        a.next()
        print(a) // e1
        
        let b = Enum6[0] // 调用枚举中的下标（这个是类下标）
        print(b) // e1
        
        return ""
    }
    enum Enum6: Int {
        case e1 = 0, e2, e3
        
        // 枚举中的方法（关于方法的更多说明请参见 SwiftView09.swift）
        // 这个是实例方法
        mutating func next() {
            switch self {
            case .e1:
                self = .e2
            case .e2:
                self = .e3
            case .e3:
                self = .e1
            }
        }
        
        // 枚举中的下标（关于下标的更多说明请参见 SwiftView09.swift）
        // 这个是类下标
        static subscript(rawValue: Int) -> Enum6 {
            return Enum6(rawValue: rawValue)!
        }
    }
}


