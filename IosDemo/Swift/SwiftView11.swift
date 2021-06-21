/*
 * 本例用于演示链式语法，抛出异常，捕获异常，类型判断（is），类型转换（as, as?, as!），Any, AnyObject，嵌套类型
 */

import SwiftUI

struct SwiftView11: View {
    
    var result: String = ""
    
    init() {
        result = sample1() // 链式语法
        result += "\n"
        result += sample2() // 抛出异常，捕获异常
        result += "\n"
        result += sample3() // 类型判断（is），类型转换（as, as?, as!）
        result += "\n"
        result += sample4() // Any, AnyObject
        result += "\n"
        result += sample5() // 嵌套类型
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
        // 链式语法的使用
        let a = SwiftView11_Class1().func1()!.func1()!.name // webabcd
        let b = SwiftView11_Class1().func1()!.func2()?.name // nil
        let c = SwiftView11_Class1().func1()![0]?.name // nil 或 Optional("webabcd")
        
        // 通过 if...let 实现非空走哪个逻辑，是空走哪个逻辑
        if let x = c {
            print(x)
        } else {
            print("c is nil")
        }
        
        return "\(a), \(b), \(c)"
    }

    func sample2() -> String {
        let a = SwiftView11_Class2()
        
        // defer 代码块会在当前作用域结束后执行（对于本例来说，就是 return 之后会执行此处）
        // 通过 defer 可以实现类似 finally 的作用
        defer {
            print("a: \(a)")
        }
        
        // 通过 dot...try...catch 来捕获异常
        do {
            let b = try a.func1() // 这里要加 try
            print("b: \(b)")
        } catch SwiftView11_Error.unknown1, SwiftView11_Error.unknown2 { // 捕获 SwiftView11_Error.unknown1 异常或 SwiftView11_Error.unknown2 异常
            print("catch: SwiftView11_Error.unknown1 或 SwiftView11_Error.unknown2")
        } catch SwiftView11_Error.error(let x, let y) { // 捕获 SwiftView11_Error.error 异常
            print("catch: \(x), \(y)") // 获取 SwiftView11_Error.error 的两个参数的数据
        } catch { // 捕获其他异常（必须要有这句，否则编译时报错）
            print("catch: \(error)") // 获取 catch 到的 error
        }
        
        // 通过 try? 实现没有异常则返执行结果，有异常则返回 nil（不会抛出异常）
        let c = try? a.func1() // c 是可空类型
        
        // 通过 try! 实现没有异常则返执行结果，有异常则抛出异常（不 catch 的话会崩溃）
        // let d = try! a.func1() // d 是非空类型
        
        return "\(c)"
    }
    
    func sample3() -> String {
        // 通过 is 判断是否是指定类型
        let a = 123 is Int
        
        // 通过类似 Double(xxx) 做类型转换
        let b = Double(123)
        
        // 通过 as 做类型转换
        let c = 123 as Double
        
        // 通过 as 做类型转换
        // let d = "123" as Double // 编译时报错
        
        // 通过 as? 做类型转换
        let e = "123" as? Double // nil
        
        // 通过 as! 做类型转换
        // let f = "123" as! Double // 运行时报错

        return "\(a), \(b), \(c), \(e)"
    }
    
    func sample4() -> String {
        let a = SwiftView11_Class1()
        
        // 不管是值类型还是引用类型，他们都可以用 Any 表示
        var arrayAny: [Any] = []
        arrayAny.append(123)
        arrayAny.append(a)
        
        // 所有引用类型都可以用 AnyObject 表示
        var arrayAnyObject: [AnyObject] = []
        // arrayAnyObject.append(123)  // 编译时报错（因为 123 不是引用类型）
        arrayAnyObject.append(a)
        
        return ""
    }
    
    func sample5() -> String {
        // 访问嵌套类型
        let a = SwiftView11_Class3.SwiftView11_Class3_Enum.e1
        
        return "\(a)"
    }
}


// 用于演示链式语法
class SwiftView11_Class1 {
    func func1() -> SwiftView11_Class1? {
        print("SwiftView11_Class1 func1")
        return self
    }
    
    func func2() -> SwiftView11_Class1? {
        print("SwiftView11_Class1 func2")
        return nil
    }
    
    subscript(index: Int) -> SwiftView11_Class1? {
        get {
            print("SwiftView11_Class1 subscript")
            if Int64(Date.init().timeIntervalSince1970) % 2 == 0 {
                return self
            } else {
                return nil
            }
        }
    }
    
    var name: String = "webabcd"
}


// 用于演示抛出异常
class SwiftView11_Class2 {
    // throws 代表这个方法可能会抛出异常
    func func1() throws -> String {
        let a = Int64(Date.init().timeIntervalSince1970) % 5
        if a == 0 {
            // 通过 throw 抛出复合 Error 协议的异常
            throw SwiftView11_Error.unknown1
        } else if a == 1 {
            throw SwiftView11_Error.unknown2
        } else if a == 2 {
            throw SwiftView11_Error.unknown3
        } else if a == 3 {
            throw SwiftView11_Error.error(code: 123, message: "errorMessage")
        } else {
            return "ok"
        }
    }
}
// 通过 Error 协议来自定义异常实体
enum SwiftView11_Error: Error {
    case unknown1
    case unknown2
    case unknown3
    case error(code: Int, message: String)
}


// 用于演示嵌套类型
class SwiftView11_Class3 {
    // 枚举 SwiftView11_Class3_Enum 定义在类 SwiftView11_Class3 中，这就是所谓的嵌套类型（也就是类中定义其他类）
    enum SwiftView11_Class3_Enum {
        case e1, e2, e3
    }
}
