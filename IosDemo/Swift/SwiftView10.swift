/*
 * 本例用于演示类
 * 类（引用类型），可见性，初始化器，引用类型的相等判断，继承，重写，final，super，self，初始化器的 required，convenience，init?()，init!()，析构函数
 *
 * 注：
 * 1、官方建议尽量用 struct 而不用 class
 * 2、可见性有从宽到窄依次为：
 *    open - 外部可见，且项目外可继承
 *    public - 外部可见，但项目外不可继承
 *    internal - 同项目可见，默认值
 *    fileprivate - 同文件可见
 *    private - 仅类内可见
 * 3、关于方法，属性，下标等这里都没有详细说，请参见之前写的东西
 * 4、结构体和类的区别：类可以继承，类的实例是引用类型（通过引用计数器管理），类不会像结构体那样根据属性自动生成初始化器
 * 5、如果存在声明时没有初始化的属性，则需要在初始化器中对这些属性做初始化，否则会编译时报错
 */

import SwiftUI

struct SwiftView10: View {
    
    var result: String = ""
    
    init() {
        result = sample1() // 类（引用类型），初始化器，引用类型的相等判断
        result += "\n"
        result += sample2() // 继承，重写，final，super，self
        result += "\n"
        result += sample3() // 初始化器的 required，convenience，init?()，init!()
        result += "\n"
        result += sample4() // 析构函数
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
        let a = SwiftView10_Class1()
        a.age = 50 // 虽然 a 是 let 常量，但是因为 a 是引用类型，所以其内的所有属性都是可以修改的
        // 因为 a 是 let 常量，所以 a 是不能再指向其他对象的，所以下面这句会编译时报错 Cannot assign to value: 'a' is a 'let' constant
        // a = SwiftView10_Class1()
        
        let b = SwiftView10_Class1()
        let c = b // 类的实例是引用类型，所以这里 b 的指针会给 c
        b.age = 50; // 此时 b.age 是 50，而 c.age 也是 50（因为 b 和 c 指向的是同一个对象）
        
        // 判断引用类型是否指向同一对象，请用 === 和 !== 判断
        let d = a !== b // true
        let e = b === c // true
        
        return "\(a.name), \(a.age), \(b.age), \(c.age), \(d), \(e)"
    }

    func sample2() -> String {
        let a = SwiftView10_Class3()
        
        let b = a is SwiftView10_Class3 // a 是 SwiftView10_Class3 类型的实例
        let c = a is SwiftView10_Class2 // a 是 SwiftView10_Class2 类型的实例（因为 SwiftView10_Class2 是 SwiftView10_Class3 的基类）
        
        return "\(b), \(c)" // true, true
    }
    
    func sample3() -> String {
        let a = SwiftView10_Class4(name: "webabcd", age: -100)
        let b = SwiftView10_Class4(name: "webabcd", age: 100)
        let c = SwiftView10_Class4(name: "webabcd") // 这个初始化器会返回 nil
        let d = SwiftView10_Class4(age: 100) // 这个初始化器会返回 nil
        let e = SwiftView10_Class5(ageDouble: 100)
        
        return "\(a.age), \(b.age), \(c), \(d), \(e.age)" // 20, 100, nil, nil, 200
    }
    
    func sample4() -> String {
        let _ = SwiftView10_Class6()
        
        return ""
    }
}


// 通过 class 定义一个类
class SwiftView10_Class1 {
    // class 不会自动生成初始化器，需要自己写（如果没定义初始化器且有没初始化的属性，则会编译时报错 Class 'xxx' has no initializers）
    // 初始化器可以有多个，且每一个初始化器中，都需要初始化所有没被初始化的属性（可空类型可以不初始化），否则编译时报错 Return from initializer without initializing all stored properties）
    init() {
        self.name = "webabcd"
    }
    var name: String
    var age = 40
}


// 定义一个基类
class SwiftView10_Class2 {
    init() {
        self.name = "webabcd"
    }
    var name: String
    
    func myFunction() {
        
    }
    
    // final 修饰的方法或属性或下标等，是不允许被子类重写的
    final func myFunction2() {
        
    }
    
    var _myProperty: String = ""
    var myProperty: String {
        get { return _myProperty }
        set { _myProperty = newValue }
    }
}
// 定义一个子类（继承自 SwiftView10_Class2）
class SwiftView10_Class3: SwiftView10_Class2 {
    // 通过 override 重写初始化器
    override init() {
        // super 是父
        // self 是我
        super.init()
    }

    init(name: String, age: Int) {
        // 注：调用父的 init() 初始化 name 后才能对他进行修改
        super.init()
        self.name = name
        
        self.age = age
    }
    var age = 40
    
    // 通过 override 重写方法
    override func myFunction() {
        
    }
    
    // 通过 override 重写属性（关于属性值监听的重写，下标的重写等也都类似）
    override var myProperty: String {
        get { return _myProperty }
        set { _myProperty = newValue }
    }
}


class SwiftView10_Class4 {
    // 用 required 修饰的初始化器的意思是：子类必须实现父类这个初始化器
    required init(ageDouble: Double) {
        self.age = Int(ageDouble)
    }
    
    // 用 convenience 修饰的初始化器的意思是：允许在这里调用其他初始化器
    // 没有 convenience 的话，会编译时报错 Designated initializer for 'SwiftView10_Class4' cannot delegate (with 'self.init'); did you mean this to be a convenience initializer?
    convenience init(name: String, age: Int) {
        if (age < 0) {
            self.init(ageDouble: 20.0) // 要这么写，则初始化器必须用 convenience 修饰
        } else {
            self.init(ageDouble: 100.0) // 要这么写，则初始化器必须用 convenience 修饰
        }
        
        // 注：这里再插一嘴，初始化器实际上就是用于实例化对象，如果你调用了多个初始化器，那么返回的对象实际上就是最后调用的那个初始化器构造出的对象
    }
    
    // init? 的意思允许实例化的结果是 nil
    init?(name: String) {
        return nil
    }
    
    // init! 的意思允许实例化的结果是 nil（不清楚 init? 和 init! 有什么区别）
    init!(age: Int) {
        return nil
    }

    var name: String = ""
    var age = 40
}
class SwiftView10_Class5: SwiftView10_Class4 {
    // 必须实现父类的 required 修饰的初始化器，且也要用 required 修饰
    // 如果没有这个初始化器就会编译时报错 'required' initializer 'init(temp:)' must be provided by subclass of 'SwiftView10_Class4'
    required init(ageDouble: Double) {
        super.init(ageDouble: ageDouble * 2)
    }
}


class SwiftView10_Class6 {
    init() {
        print("SwiftView10_Class6 init")
    }
    
    // 通过 deinit 定义析构函数（实例被释放后会自动调用析构函数）
    deinit {
        print("SwiftView10_Class6 deinit")
    }
}
