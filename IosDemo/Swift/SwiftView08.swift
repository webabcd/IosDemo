/*
 * 本例用于演示
 */

import SwiftUI

struct SwiftView08: View {
    
    var result: String = "";
    
    init() {
        result = sample1()
        result += "\n";
        result += sample2()
        result += "\n";
        result += sample3()
        result += "\n";
        result += sample4()
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
        // 没有继承，是值类型
        
        
        var a = SwiftView08_Struct1(name: "webabcd", age: 40)
        var b = SwiftView08_Struct1(name: "webabcd", age: 40)
        var c = b
        b.age = 50;
        
        print("没初始化")
        let d = a.myLazy.total

        SwiftView08_Struct1.height = 100
        let e = SwiftView08_Struct1.height
        
        return "\(a.name), \(a.age), \(b.age), \(c.age), \(e)"
    }

    func sample2() -> String {
        
        var a = SwiftView08_Struct3(name: "webabcd")
        a.age = 200
        
        a.salary = 50000
        
        return "\(a.name), \(a.age), \(a.salary)"
    }
    
    func sample3() -> String {
            return ""
    }
    
    func sample4() -> String {
        
        
        return ""
    }
}


struct SwiftView08_Struct1 {
    var name: String
    var age = 0
    
    lazy var myLazy = SwiftView08_Struct2()
    
    static var height = 0
}

struct SwiftView08_Struct2 {
    init() {
        print("SwiftView08_Struct2 init")
    }
    
    var total = 100
}

struct SwiftView08_Struct3 {

    init(name: String) {
        // self
        self._name = name
    }
    
    private var _name: String
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    var age = 100 {
        willSet(newValue) {
            print(newValue)
        }
        didSet {
            print(age, oldValue)
        }
    }
    
    @SwiftView08_Struct4 var salary: Int
}

@propertyWrapper
struct SwiftView08_Struct4 {
    private var _number: Int
    init() {
        _number = 100
    }
    var wrappedValue: Int {
        get {
            return _number
        }
        set {
            _number = min(newValue, 999)
        }
    }
}



