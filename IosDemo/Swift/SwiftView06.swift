/*
 * 本例用于演示闭包（闭包的基础，嵌套函数会维护它外部的变量，延迟执行 {} 括起来的闭包逻辑，@escaping）
 *
 * 闭包（closure）就是函数的匿名简化版，类似 lambda 表达式
 */

import SwiftUI

struct SwiftView06: View {
    
    var result: String = "";
    
    init() {
        result = sample1() // 闭包基础 1
        result += "\n";
        result += sample2() // 闭包基础 2
        result += "\n";
        result += sample3() // 嵌套函数会维护它外部的变量
        result += "\n";
        result += sample4() // 延迟执行 {} 括起来的闭包逻辑
        result += "\n";
        result += sample5() // @escaping
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
        let a = [3, 1, 5, 4, 2]
        let b = a.sorted(by: ascend) // 函数作为参数
        let c = a.sorted(by: { (a: Int, b: Int) -> Bool in return a < b }) // 闭包作为参数（这个是写全了的闭包表达式）
        let d = a.sorted(by: { a, b in return a < b }) // 简化闭包（省略闭包的参数类型，由编译器推断）
        let e = a.sorted(by: { a, b in a < b })  // 再简化闭包（如果闭包是单表达式则可以省略 return）
        let f = a.sorted(by: { $0 < $1 }) // 再再简化闭包（可以通过 $0, $1, $2... 来引用闭包的参数，同时省略掉 in）
        let g = a.sorted(by: <)  // 再再再简化闭包（如果就是 2 个参数通过运算符比较的话，那么只写运算符即可，其他都可以省略）
        let h = a.sorted() { $0 < $1 } // 如果闭包作为函数的最后一个参数，则闭包可以放在 () 之外，且不需要参数标签
        let i = a.sorted { $0 < $1 } // 如果函数只有闭包一个参数，则可以省略掉 ()，且不需要参数标签
        
        return "\(b), \(c), \(d), \(e), \(f), \(g), \(h), \(i)";
    }
    func ascend(_ a: Int, _ b: Int) -> Bool {
        return a < b
    }
    
    

    func sample2() -> String {
        // 调用闭包作为参数的函数（用函数的方式，这里可以发现，闭包其实就是函数的匿名简化版）
        requestUrl(url: "http://webabcd.cnblogs.com", onSucess: success(message:), onError: error(message:))
        
        // 调用闭包作为参数的函数（用闭包的方式）
        requestUrl(url: "http://webabcd.cnblogs.com", onSucess: { message in
            print(message)
        }, onError: { message in
            print(message)
        })
        
        // 调用闭包作为参数的函数（闭包可以放在 () 之外，前提是闭包参数的后面不能再有非闭包参数，则该闭包参数可以放到 () 之外）
        // 注；放在 () 之外的第一个闭包的参数标签请直接省略
        requestUrl(url: "http://webabcd.cnblogs.com") { message in
            print(message)
        } onError: { message in
            print(message)
        }
        
        // 通过 $0, $1, $2... 来引用闭包的参数
        requestUrl(url: "http://webabcd.cnblogs.com") {
            print($0)
        } onError: {
            print($0)
        }

        return "";
    }
    // 闭包作为参数
    func requestUrl(url: String, onSucess: (String) -> Void, onError: (String) -> Void) {
        if Int64(Date.init().timeIntervalSince1970) % 2 == 0 {
            onSucess("成功")
        } else {
            onError("失败")
        }
    }
    func success(message: String) {
        print(message)
    }
    func error(message: String) {
        print(message)
    }

    
    
    func sample3() -> String {
        let a = increase(number: 2)
        let b = increase(number: 3)
        
        // a 和 b 都是 increase() 中的 myFunc() 函数，它不会丢失其外部的 total 变量
        // a 和 b 都是 increase() 中的 myFunc() 函数，但是是不同的对象，他们会分别维护他们外部的 total 变量
        print(a(), b()) // 2 3
        print(a(), b()) // 4 6
        print(a(), b()) // 6 9
        
        return "";
    }
    func increase(number: Int) -> () -> Int {
        var total = 0
        func myFunc() -> Int { // 这个函数会将其外部的 total 变量捕获过来，也就是说 myFunc() 是不会丢失 total 的
            total += number
            return total
        }
        return myFunc
    }
    
    
    
    func sample4() -> String {
        var a = [1, 2, 3, 4, 5]
        // 直接用 {} 括起来的闭包逻辑是不会立即执行的
        let b = { a.remove(at: 0) }
        
        print(a) // [1, 2, 3, 4, 5]
        // 此时才会调用闭包中的逻辑
        b()
        print(a) // [2, 3, 4, 5]
        
        return ""
    }
    
    
    
    var funcList = [() -> Void]()
    mutating func sample5() -> String {
        appendFunc { print("abc") }
        appendFunc { print("xyz") }
        
        // appendFunc() 函数退出了，也能执行传给 appendFunc() 的闭包函数
        for item in funcList {
            item()
        }
        
        return ""
    }
    // 闭包作为参数时可以指定闭包为 @escaping 类型
    // 非 @escaping 类型闭包的生命周期：闭包作为参数传给函数，闭包在函数中执行（执行完后，闭包就死了），退出函数
    // @escaping 类型闭包的生命周期：闭包作为参数传给函数，退出函数，闭包还活着
    mutating func appendFunc(a: @escaping () -> Void) {
        // 这里你如果想函数退出后再执行闭包，则需要将此闭包标记为 @escaping 类型，否则会编译时报错
        funcList.append(a)
    }
}
