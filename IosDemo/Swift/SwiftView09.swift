/*
 * 本例用于演示
 */

import SwiftUI

struct SwiftView09: View {
    
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
        var a = SwiftView09_Struct1()
        
        let b = a.func1()
        let c = a.func2() // a 需要是 var ，因为 func2 修改里面的值类型了
        let d = a.func3()
        let e = SwiftView09_Struct1.func4()
        
        return "\(b), \(c), \(d), \(e)"
    }

    func sample2() -> String {
        
        var a = SwiftView09_Struct2()
        a[100] = "webabcd"
        let b = a[100]
        let c = a[10, 20]
        let d = SwiftView09_Struct2[100]
        return "\(b), \(c), \(d)";
    }
    
    func sample3() -> String {
        
        return "";
    }
    
    func sample4() -> String {
        
        return "";
    }
}

struct SwiftView09_Struct1 {
    var name: String = "webabcd"
    
    func func1() -> String {
        // self.name = "wanglei" // Cannot assign to property: 'self' is immutable
        return self.name
    }
    
    mutating func func2() -> String {
        self.name = "wanglei"
        return self.name
    }
    
    mutating func func3() -> String {
        self = SwiftView09_Struct1(name: "wangrx")
        return self.name
    }
    
    static func func4() -> String {
        return "static func"
    }
}



struct SwiftView09_Struct2 {
    private var _dict = [Int : String]()
    init() {
        
    }
    subscript(index: Int) -> String {
        get {
            return _dict[index] ?? ""
        }
        set (newValue) {
            _dict[index] = newValue
        }
    }
    
    subscript(rows: Int, columns: Int) -> String {
        get {
            return "rows:\(rows), columns:\(columns)"
        }
    }
    
    static subscript(index: Int) -> String {
        return "index: \(index)"
    }
}




