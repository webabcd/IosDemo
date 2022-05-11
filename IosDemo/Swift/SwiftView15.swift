/*
 * 本例用于演示其他
 * 通过 some 修饰不透明类型（opaque type），大 Self 和小 self，inout 参数的访问冲突问题，引用计数器，强引用，weak 弱引用，unowned 弱引用，实例之间的互相强引用导致的无法释放的问题，属性闭包引用了 self 导致的循环引用问题
 */

import SwiftUI

struct SwiftView15: View {
    
    var result: String = ""
    
    init() {
        result = sample1() // 通过 some 修饰不透明类型（opaque type）
        result += "\n"
        result += sample2() // 大 Self 和小 self
        result += "\n"
        result += sample3() // inout 参数的访问冲突问题
        result += "\n"
        result += sample4() // 引用计数器，强引用，weak 弱引用，unowned 弱引用
        result += "\n"
        result += sample5() // 实例之间的互相强引用导致的无法释放的问题
        result += "\n"
        result += sample6() // 属性闭包引用了 self 导致的循环引用问题
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
        let a = swiftView15_func1().name
        
        return "\(a)"
    }

    func sample2() -> String {
        let a = SwiftView15_Struct2().getSelf().name
        
        return "\(a)"
    }
    
    func sample3() -> String {
        // 下面这句会导致访问冲突，会运行时报错 Simultaneous accesses to 0x106bc01d8, but modification requires exclusive access.
        // let a = swiftView15_func2(number: &swiftView15_var1)
        
        return ""
    }
    
    func sample4() -> String {
        var a: SwiftView15_MyClass? = SwiftView15_MyClass(name: "strong") // a 被 sample4() 强引用了，此时 a 的引用计数器是 1
        var b = a // a 被 b 强引用了，此时 a 的引用计数器是 2，b 被 sample4() 强引用了，此时 b 的引用计数器是 1
        a = nil // a 变为 nil，但是 b 不是 nil，此时 a 的引用计数器是 1
        // 此时 a 没有被释放，而是要等到 sample4() 执行完后，b 的引用计数器就变为 0 了，然后 a 的引用计数器也变为 0 了，然后 a 就会被释放了
        
        weak var c: SwiftView15_MyClass? = SwiftView15_MyClass(name: "weak") // 因为 c 是 weak 弱引用，所以 c 被 sample4() 弱引用了，此时 c 的引用计数器是 0
        // 此时 c 已经被释放了，因为 c 是 weak 弱引用，所以此时的 c 的值为 nil

        unowned var d: SwiftView15_MyClass? = SwiftView15_MyClass(name: "unowned") // 因为 d 是 unowned 弱引用，所以 d 被 sample4() 弱引用了，此时 d 的引用计数器是 0
        // 此时 d 已经被释放了，因为 d 是 unowned 弱引用，所以如果你此时获取 d 的值的话，将会运行时报错 Fatal error: Attempted to read an unowned reference
        
        // 由上可知，weak 和 unowned 都是弱引用，他们的区别就是释放后，你获取 weak 对象的值会得到 nil，你获取 unowned 对象的值会收到运行时异常
        
        return "\(b), \(c)"
    }

    func sample5() -> String {
        let class1_1: SwiftView15_Class1? = SwiftView15_Class1(name: "strong")
        let class2_1: SwiftView15_Class2? = SwiftView15_Class2(name: "strong")
        class1_1!.class2 = class2_1
        class2_1!.class1 = class1_1
        // 上例 class1_1 对象和 class2_1 对象互相强引用了，他们永远都不会被释放，除非把 app 杀了
        
        
        let class1_2: SwiftView15_Class1? = SwiftView15_Class1(name: "weak")
        let class2_2: SwiftView15_Class2? = SwiftView15_Class2(name: "weak")
        class1_2!.class2 = class2_2
        class2_2!.class1_weak = class1_2
        // 上例 class1_2 和 class2_2 会在 sample5() 执行完后被释放，关于引用计数器，以及 weak 和 unowned 的详细说明请参见 sample4() 中的示例
        
        
        let class1_3: SwiftView15_Class1? = SwiftView15_Class1(name: "unowned")
        let class2_3: SwiftView15_Class2? = SwiftView15_Class2(name: "unowned")
        class1_3!.class2 = class2_3
        class2_3!.class1_unowned = class1_3
        // 上例 class1_3 和 class2_3 会在 sample5() 执行完后被释放，关于引用计数器，以及 weak 和 unowned 的详细说明请参见 sample4() 中的示例
        
        
        return ""
    }
    
    func sample6() -> String {
        let a = SwiftView15_Class3(name: "closure_strong")
        let b = SwiftView15_Class3(name: "closure_weak")
        
        let c = a.getMessage() // 对象 a 无法释放
        let d = b.getMessage_unowned() // 对象 b 会在 sample6() 执行完后被释放
        
        return "\(c), \(d)"
    }
}


// 用于演示不透明类型（opaque type）
protocol SwiftView15_Protocol1 {
    associatedtype MyType
    var name: MyType { get set }
}
struct SwiftView15_Struct1: SwiftView15_Protocol1 {
    typealias MyType = String
    var name: MyType = "webabcd"
}
// 一般情况通过 -> protocol 定义返回类型是没问题的
// 但是这里的 SwiftView15_Protocol1 协议中定义了关联类型，也就是说无法确认真实的返回类型
// 所以这里如果通过 -> SwiftView15_Protocol1 定义返回类型的话，会编译时报错 Protocol 'SwiftView15_Protocol1' can only be used as a generic constraint because it has Self or associated type requirements
// 于是为了解决这个问题，就引入了不透明类型，即将返回类型定义为 -> some SwiftView15_Protocol1 就好了
func swiftView15_func1() -> some SwiftView15_Protocol1 { // 通过 some 修饰不透明类型
    return SwiftView15_Struct1()
}


// 用于演示大 Self 和小 self
protocol SwiftView15_Protocol2 {
    var name: String { get set }
    func getSelf() -> Self // 这里的大 Self 指的是实现此协议的类型
}
struct SwiftView15_Struct2: SwiftView15_Protocol2 {
    var name: String = "webabcd"
    func getSelf() -> SwiftView15_Struct2 {
        return self // 这里的小 self 指的是当前的类实例
    }
}


// 用于演示 inout 参数的访问冲突
var swiftView15_var1 = 0
// 调用下面的方法时，如果传参是 &swiftView15_var1 就会导致访问冲突
// 因为 number 和 swiftView15_var1 引用的是相同的内存，且 swiftView15_var1 需要读，number 需要写，也就是说在同一内存中要同时读写，这样就产生了冲突
func swiftView15_func2(number: inout Int) {
    number = swiftView15_var1
}


// 用于演示强引用，weak 弱引用，unowned 弱引用
// 在 swift 中也是通过自动引用计数器（ARC）来管理内存的，也就是说如果对象的被强引用的计数为 0 时就会被释放
class SwiftView15_MyClass {
    var name: String
    init(name: String) {
        self.name = name
        print("\(self.name) SwiftView15_MyClass init")
    }
    deinit {
        print("\(self.name) SwiftView15_MyClass deinit")
    }
}


// 用于演示类实例之间的互相强引用，互相强引用会导致无法释放
// 通过 weak 引用和 unowned 引用解决无法释放的问题
// 注：struct 是值类型，所以没有办法做到下面这样
class SwiftView15_Class1 {
    var name: String
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(self.name) SwiftView15_Class1 deinit")
    }
    var class2: SwiftView15_Class2? // class2 被 class1 强引用了
}
class SwiftView15_Class2 {
    var name: String
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(self.name) SwiftView15_Class2 deinit")
    }
    var class1: SwiftView15_Class1? // class1 被 class2 强引用了
    weak var class1_weak: SwiftView15_Class1? // class1 被 class2 通过 weak 弱引用了
    unowned var class1_unowned: SwiftView15_Class1? // class1 被 class2 通过 unowned 弱引用了
}


// 用于演示属性闭包的循环引用，循环引用会导致无法释放
// 通过捕获列表并结合 weak 引用和 unowned 引用解决无法释放的问题
class SwiftView15_Class3 {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    // 注：如果要在属性的闭包中使用 self 则需要将属性标记为 lazy 属性
    // 如果在属性的闭包中引用了 self，就会导致实例持有闭包，闭包持有实例的循环应用，就会导致实例无法释放
    lazy var getMessage: () -> String = {
        return self.name
    }
    
    lazy var getMessage_unowned: () -> String = {
        // 怎么解决属性闭包引用了 self 导致的循环引用问题呢，像如下方式弱引用 self 并将其添加进捕获列表即可
        [unowned self] in
        
        // 可以类似如下这样，弱引用 self 的同时将他赋值给另一个变量。另外，如果需要将多个引用加入捕获列表的话用逗号隔开即可
        // [unowned xxx = self] in
        
        // 也可以用 weak 弱引用代替 unowned 弱引用
        // weak 和 unowned 的区别是
        //   [unowned self] 必须保证 self 不为 nil，否则会报错（也就是说，如果 self 被释放了，你再在闭包中引用 self 则会报错）
        //   [weak self] 允许 self 为 nil，也就是说你在闭包中引用 self 的时候要通过 self?.xxx 的方式引用
        // [weak self] in
        // [weak xxx = self] in
        
        return self.name
    }

    deinit {
        print("\(self.name) SwiftView15_class3 deinit")
    }
}
