/*
 * 本例用于演示控制语句（for...in, while, repeat...while, if...else, guard...else, continue, break, return, fallthrough, 多层循环语句嵌套时退出指定的循环, @available, #available）
 */

import SwiftUI

struct SwiftView04: View {
    
    var result: String = "";
    
    init() {
        result = sample1() // for...in
        result += "\n";
        result += sample2() // while, repeat...while
        result += "\n";
        result += sample3() // if...else, guard...else
        result += "\n";
        result += sample4() // switch
        result += "\n";
        result += sample5() // 多层循环语句嵌套时退出指定的循环
        result += "\n";
        result += sample6() // 通过 @available 和 #available 指定可用的系统版本
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
        
        for item in 0...3 {
            print(item)
        }
        
        for item in 0..<3 {
            print(item)
        }
        
        for item in [1, 2, 3] {
            print(item)
        }
        
        // 如果你不想使用遍历出来的值那就下面这样用 _ 代替
        for _ in 0...2 { // 这句话就是为了循环执行 3 次，不需要使用遍历出来的数据
            // print(_) // 这句会编译报错的
            print("循环 3 次")
        }
        
        // stride() - 下面这句的意思是，从 0 到 100 步长为 10
        for item in stride(from: 0, through: 30, by: 10) {
            print(item) // 打印出的数据为 0 10 20 30
        }
        
        // forEach() 的用法
        [1, 2, 3].forEach { p in
            print(p)
        }
        [1, 2, 3].forEach {
            print($0)
        }
        
        return ""
    }

    func sample2() -> String {
        var i = 0
        while i < 2 {
            print("while")
            i += 1
        }
        
        // repeat...while 相当于其他语言的 do...while
        repeat {
            print("repeat...while")
        } while i < 2
        
        return ""
    }
    
    func sample3() -> String {
        
        let a = Int64(Date.init().timeIntervalSince1970) % 2
        if a == 0 {

        } else if a == 1 {
  
        } else {
  
        }
        
        var b: Int? = nil
        if a == 0 {
            b = 100
        }
        // if 后面跟赋值语句（允许有多条赋值语句，用逗号隔开即可）
        if let c = b { // 如果 b 不是 nil，则将 b 的值赋予 c
            print("c 的值为 \(c)") // 这里可以使用 c
        } else { // 如果 b 是 nil，则不会声明 c
            print("b 的值为 nil") // 这里是没有 c 的
        }
        
        // guard/else - 如果 guard 条件成立则跳过整个 guard/else 语句，如果 guard 条件不成立，则走 else（else 里必须要 return）
        guard a == 1 else { // 如果 a == 1 不成立则走到 else，如果成立则跳过整个 guard/else 语句后继续执行
            print("a 不等于 1")
            return "" // 在 guard 的 else 中必须要 return
        }
        print("a 等于 1")
        
        // guard 后面跟赋值语句（允许有多条赋值语句，用逗号隔开即可）
        guard let d = b else { // 如果 b 是 nil 则走到 else，否则会跳过整个 guard/else 语句后继续执行
            print("b 的值为 nil")
            return ""
        }
        print("d 的值为 \(d)") // 这里可以使用 d
        
        return ""
    }
    
    func sample4() -> String {
        // 在经典的 switch 中，遇到 break 才会退出，也就是如果某个 case 是空语句，或者没有 break，那么他会继续判断后面的 case 直到有 break 再退出 switch
        // 而 swift 的 switch 语句的逻辑是，匹配了 case 后执行完它的语句就直接退出 switch（不需要有 break，当然你写了 break 也没关系）
        
        let a = Int64(Date.init().timeIntervalSince1970) % 10
        switch a {
        case 1: // 匹配一个值
            print("1")
        case 2, 3: // 匹配多个值
            print("2, 3")
        case 4..<7: // 匹配某个范围的值
            print("4, 5, 6")
        case 7...9: // 匹配某个范围的值
            print("7, 8, 9")
        default:
            print("0")
        }
        
        
        let b = (a, 1)
        switch b { // 元组匹配
        case (1, 1): // 第一个元素是 1，第二个元素是 1
            print("")
        case (_, 100): // 第一个元素不管（下划线代表忽略他），第二个元素是 100
            // print(_) // 这句会编译报错的
            print("")
        case (100, _): // 第一个元素是 100，第二个元素不管（下划线代表忽略他）
            // print(_) // 这句会编译报错的
            print("")
        case (1...3, 4...6): // 第一个元素是 1 到 3 之间的整数，第二个元素是 4 到 6 之间的整数
            print("")
        case (let x, 0): // 第一个元素不管，并将其赋值给 x，第二个元素是 0
            print(x) // 这里可以使用 x
        case (0, let y): // 第一个元素是 0，第二个元素不管，并将其赋值给 y
            print(y) // 这里可以使用 y
        case (let x, let y) where x == y: // 当 x 等于 y 时，然后第一个元素赋值给 x，第二个元素赋值给 y
            print(x); print(y) // 这里可以使用 x 和 y
        default:
            print("")
        }
        
        
        // 在 case 的结尾可以通过 fallthrough 强制不退出 switch 而是执行下一个 case 中的语句（不管下面的 case 条件是否匹配）
        // 下面这个 switch 的运行结果是打印 1 2 3
        switch 1 {
        case 1:
            print("1")
            fallthrough
        case 2:
            print("2")
            fallthrough
        case 3:
            print("3")
        case 4:
            print("4")
        default:
            print("d")
        }

        return ""
    }
    
    func sample5() -> String {
        // continue, break, return 均可用
        
        var a = 0
        // 像下面这样可以为循环语句指定一个名称
        myName: while a < 10 {
            print(a)
            switch a {
            case 5...:
                // break // 跳出的是 switch 语句
                break myName // 跳出名称为 myName 的循环语句，也就是说跳出的是 while 语句
            default:
                break
            }
            a += 1
        }
        
        return ""
    }
    
    // 当前函数仅支持 ios10 或以上系统（非 ios 系统也支持）
    @available(iOS 10, *)
    func sample6() -> String {
        
        if #available(iOS 12, *) {
            // ios12 或以上系统会执行到这里（非 ios 系统也会执行到这里）
        }
        
        if #available(iOS 12, macOS 11.1, *) {
            // ios12 或以上系统以及 macos 11.1 或以上系统会执行到这里（非 ios/macos 系统也会执行到这里）
        }
        
        return "@available 和 #available"
    }
}
