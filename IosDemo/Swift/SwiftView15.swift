/*
 * 本例用于演示
 */

import SwiftUI

struct SwiftView15: View {
    
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
        
        return ""
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
