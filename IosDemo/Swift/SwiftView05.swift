/*
 * 本例用于演示函数（函数的参数，函数的返回值，参数标签，参数名称，参数的默认值，可变数量参数，inout 参数，函数类型的变量，函数类型作为参数，函数类型作为返回值，函数嵌套，通过 defer 在函数结束后执行）
 */

import SwiftUI

struct SwiftView05: View {
    
    var result: String = "";
    
    init() {
        result = sample1(); // 函数的参数，函数的返回值，参数标签，参数名称，参数的默认值
        result += "\n";
        result += sample2(); // 可变数量参数，inout 参数
        result += "\n";
        result += sample3(); // 函数类型的变量，函数类型作为参数，函数类型作为返回值
        result += "\n";
        result += sample4(); // 函数嵌套
        result += "\n";
        result += sample5(); // 通过 defer 在函数结束后执行
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
        
        func1()
        let a = func2(a: 100, b: 200)
        let b = func2(a: 100, b: 200)
        let c = func4(number1: 100, number2: 200) // 调用函数时，要指定参数标签（如果定义函数时没有指定参数标签，则默认使用参数名称当做参数标签）
        let d = func5(100, number2: 200) // 如果参数标签为 _ 则调用时不用指定参数标签
        let e = func6(number1: 100)
        let f = func6(number1: 100, number2: 200)
        
        return "\(a), \(b), \(c), \(d), \(e), \(f)";
    }
    // 没有返回值的函数，其中的 -> Void 可以省略
    func func1() -> Void {
        print("func1")
    }
    // 有参数，有返回值的函数
    func func2(a: Int, b: Int) -> Int {
        return a + b
    }
    // 有参数，有返回值的函数（如果函数只有一行表达式，则可以省略 return）
    func func3(a: Int, b: Int) -> Int {
        a + b
    }
    // 指定参数标签
    // 下例中 number1 是参数标签，调用函数的时候使用
    // 下例中 a 是参数名称，在函数的实现中使用
    // 如果不指定参数标签，则默认使用参数名称当做参数标签
    func func4(number1 a: Int, number2 b: Int) -> Int {
        return a + b
    }
    // 如果参数标签为 _ 则调用时不用指定参数标签
    func func5(_ a: Int, number2 b: Int) -> Int {
        return a + b
    }
    // 指定参数默认值
    func func6(number1 a: Int, number2 b: Int = 200) -> Int {
        return a + b
    }
    

    
    func sample2() -> String {
        let a = func7(1, 2, 3)
        let b = func7()
        
        var x = 100
        var y = 200
        // 参数定义为 inout 了，所以传参时需要在变量前加 & 符号
        // 调用此函数后，x 值为 200，y 值为 400
        let c = func8(a: &x, b: &y)
        
        return "\(a), \(b), \(c), \(x), \(y)";
    }
    // 可变数量参数
    func func7(_ a: Int...) -> Int {
        var result = 0
        for item in a { // 这里的 a 是 Array<Int> 类型
            result += item
        }
        
        print(type(of: a))
        return result
    }
    // inout - 用于指定参数是可修改的（传值时需要在变量前加 & 符号）
    // 如果不用 inout 那么这里的参数默认都是 let 的，不可修改（如果尝试修改会编译时报错）
    func func8(a: inout Int, b: inout Int) -> Int {
        a *= 2
        b *= 2
        return a + b
    }
    
    
    
    func sample3() -> String {
        // 声明一个函数类型的变量
        var myFunc: (Int, Int) -> Int = func9
        let a = myFunc(3, 4)
        myFunc = func10
        let b = myFunc(3, 4)
        
        // 函数类型作为参数
        let c = func11(func9, b: 3, c: 4)
        let d = func11(func10, b: 3, c: 4)
        
        // 函数类型作为返回值
        let e = func12(true)(3, 4)
        let f = func12(false)(3, 4)
        
        return "\(a), \(b), \(c), \(d), \(e), \(f)";
    }
    func func9(a: Int, b: Int) -> Int {
        return a + b
    }
    func func10(a: Int, b: Int) -> Int {
        return a * b
    }
    // 函数类型作为参数
    func func11(_ a: (Int, Int) -> Int, b: Int, c: Int) -> Int {
        return a(b, c)
    }
    // 函数类型作为返回值
    func func12(_ a: Bool) -> (Int, Int) -> Int {
        if (a) {
            return func9
        } else {
            return func10
        }
    }
   
    
    
    func sample4() -> String {
        let a = func13(a: 3, b: 4)
        
        return "\(a)";
    }
    // 函数嵌套
    func func13(a: Int, b: Int) -> Int {
        // 函数中的函数
        func func13_1(a: Int, b: Int) -> Int {
            return a + b
        }
        return func13_1(a: a, b: b)
    }
    
    
    
    func sample5() -> String {
        // defer 代码块会在当前作用域结束后执行
        defer {
            print("defer") // 后执行这个
        }
        
        print("sample5") // 先执行这个
        
        return "";
    }
}
