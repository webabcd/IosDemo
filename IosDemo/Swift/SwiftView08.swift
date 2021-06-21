/*
 * 本例用于演示结构体，属性
 * 结构体（值类型），初始化器，属性，延迟初始化属性，类属性，self，私有属性，属性的 getter 和 setter，监听属性值的变化，属性包装器
 *
 * 注：
 * 1、官方建议尽量用 struct 而不用 class
 * 2、可见性默认都是 public 的，其他可见性还有 private, internal（同项目可见）
 * 3、结构体和类的区别：类可以继承，类的实例是引用类型（通过引用计数器管理），类不会像结构体那样根据属性自动生成初始化器
 */

import SwiftUI

struct SwiftView08: View {
    
    var result: String = ""
    
    init() {
        result = sample1() // 结构体（值类型），初始化器，属性，延迟初始化属性，类属性
        result += "\n"
        result += sample2() // self，私有属性，属性的 getter 和 setter，监听属性值的变化，属性包装器
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
        // 通过自动生成的初始化器来初始化结构体
        var a = SwiftView08_Struct1(name: "webabcd", age: 40)
        var b = SwiftView08_Struct1(name: "webabcd", age: 40)
        let c = b // 结构体是值类型，所以 b 中的值类型数据都会新复制一份给 c
        b.age = 50; // 此时 b.age 是 50，而 c.age 是 40
        
        // 下面这句是会编译时报错的，因为结构体是值类型，如果结构体是 let 常量，那么其内的所有值类型也都是不可变的（值类型即使是 var 修饰也不可修改）
        // c.name = "xxx"
        
        print("myLazy 属性还没被初始化")
        let d = a.myLazy.total // 此时 myLazy 会被初始化（这其实就是相当于修改了 myLazy，也就是 a 如果是 let 的话那么会编译报错的）

        // 访问类属性
        SwiftView08_Struct1.height = 100
        let e = SwiftView08_Struct1.height
        
        return "\(a.name), \(a.age), \(b.age), \(c.age), \(d), \(e)"
    }

    func sample2() -> String {
        // 带私有属性的结构体
        var a = SwiftView08_Struct3(name: "webabcd")
        // 属性的 getter 和 setter
        a.name = "wanglei"
        // 监听属性值的变化
        a.age = 200
        
        // 属性包装器的使用（salary 的最大值被限制为 999）
        a.salary = 50000
        
        return "\(a.salary)" // 999
    }
}


// 通过 struct 定义一个结构体
// 注：结构体是值类型，没有继承的能力
struct SwiftView08_Struct1 {
    // 结构体的实例属性
    var name: String
    var age = 0
    
    // 用 lazy 修饰的是延迟初始化属性
    // 也就是说 SwiftView08_Struct1 被初始化后，myLazy 不会被初始化，而是当你用到 myLazy 的时候他才会被初始化
    lazy var myLazy = SwiftView08_Struct2()
    
    /*
     * 结构体会根据实例属性自动生成相关的初始化器（构造函数）,类无此特性
     * 此结构体自动生成 3 个初始化器，如下：
     * 1、init(name: String)
     * 2、init(name: String, age: Int)
     * 3、init(name: String, age: Int, myLazy: SwiftView08_Struct2?)
     */
    
    // 结构体的类属性
    static var height = 0
}
struct SwiftView08_Struct2 {
    init() {
        print("SwiftView08_Struct2 init")
    }
    var total = 100
}

struct SwiftView08_Struct3 {
    // 如果你的结构体有私有属性，且私有属性没有在声明的时候初始化，那么就需要自己写初始化器（构造函数），否则会编译时报错（initializer is inaccessible due to 'private' protection level）
    init(name: String) {
        // self 指的是实例本身（可以省略）
        self._name = name
    }
    
    // 可见性默认都是 public 的，其他可见性还有 private, internal（同模块可见）
    private var _name: String
    // 属性的 getter 和 setter
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    // 监听属性值的变化
    var age = 100 {
        willSet { // 将要发生变化
            print(age, newValue) // age 是老值，newValue 是新值
        }
        didSet { // 已经发生变化
            print(oldValue, age) // oldValue 是老值，age 是新值
        }
    }
    
    // 通过 @xxx 的方式指定当前属性需要关联到的属性包装器
    // 这里的 salary 属性的 getter 和 setter 的逻辑走的是 SwiftView08_Struct4 中的 wrappedValue 的逻辑（限制 salary 的最大值为 999）
    @SwiftView08_Struct4 var salary: Int
}

// 通过 @propertyWrapper 标记属性包装器
// 属性包装器的作用就是将属性的获取逻辑和设置逻辑封装到一个对象中
@propertyWrapper
struct SwiftView08_Struct4 {
    private var _number: Int
    init() {
        _number = 100
    }
    // 约定使用名为 wrappedValue 的属性的 getter 和 setter（没有名为 wrappedValue 的属性则编译时报错）
    var wrappedValue: Int {
        get {
            return _number
        }
        set {
            // 设置值时，限制最大值为 999
            _number = min(newValue, 999)
        }
    }
}
