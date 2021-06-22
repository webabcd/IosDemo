/*
 * 本例用于演示泛型（泛型函数，泛型结构体，泛型类，泛型下标，泛型的类型约束）
 */

import SwiftUI

struct SwiftView12: View {
    
    var result: String = ""
    
    init() {
        result = sample1() // 泛型函数，泛型结构体，泛型类
        result += "\n"
        result += sample2() // 泛型的类型约束
        result += "\n"
        result += sample3() // 泛型下标
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
        // 泛型函数的使用
        let a = func1(t: "webabcd")
        
        // 泛型结构体（泛型类也是类似的）的使用
        var b = Struct1<String>()
        b.push(t: "webabcd")
        b.push(t: "wanglei")
        
        return "\(a), \(b.items)"
    }
    // 泛型函数
    func func1<T>(t: T) -> T {
        return t
    }
    // 泛型结构体（泛型类也是类似的）
    struct Struct1<T> {
        var items = [T]()
        mutating func push(t: T) {
            items.append(t)
        }
        
    }
    
    
    func sample2() -> String {
        let a = SwiftView12_Class1()
        let b = func2(a: a)

        return "\(b)"
    }
    // 泛型的类型约束
    // 类似如下方式约束泛型必须是指定的类型（也可以约束泛型符合某个协议，或同时符合多个协议）
    func func2<T: SwiftView12_Class1>(a: T) -> String {
        return "name:\(a.name), age:\(a.age)"
    }
    
    
    func sample3() -> String {
        let a = SwiftView12_Class1()
        // 泛型下标的使用
        let b = SwiftView12_Struct1[a]
        
        return "\(b)"
    }
}


class SwiftView12_Class1 {
    var name: String = "webabcd"
    var age: Int = 40
}

struct SwiftView12_Struct1 {
    // 泛型下标（约束了泛型 T 必须是 SwiftView12_Class1 类型）
    static subscript<T: SwiftView12_Class1>(a: T) -> String {
        get {
            return a.name
        }
    }
}
