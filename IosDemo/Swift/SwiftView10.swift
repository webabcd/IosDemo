/*
 * 本例用于演示
 */

import SwiftUI

struct SwiftView10: View {
    
    var result: String = ""
    
    init() {
        result = sample1()
        result += "\n"
        result += sample2()
        result += "\n"
        result += sample3()
        result += "\n"
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
        let a = SwiftView10_Class1()
        let b = SwiftView10_Class1()
        let c = b
        b.age = 50;

        // a = SwiftView10_Class1() Cannot assign to value: 'a' is a 'let' constant
        return "\(a.name), \(a.age), \(b.age), \(c.age)"
    }

    func sample2() -> String {
        
        return ""
    }
    
    func sample3() -> String {
        
        return ""
    }
    
    func sample4() -> String {
        
        return ""
    }
}


class SwiftView10_Class1 {
    // Return from initializer without initializing all stored properties
    init() {
        self.name = "webabcd"
        self.age = 40
    }
    var name: String
    var age = 0
}
