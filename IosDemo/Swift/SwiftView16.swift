/*
 * 本例用于演示
 */

import Foundation
import SwiftUI

struct SwiftView16: View {
    
    var result: String = "";
    
    init() {
        result = sample1()
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
        let a = SwiftView16_Class1()
        a.startThread()
        
        return ""
    }

}

class SwiftView16_Class1 {
    func startThread() {
        // Thread.detachNewThreadSelector
        let thread1 = Thread(target: self, selector: #selector(threadMethod1(param:)), object: "webabcd")
        
        let param = "wanglei"
        let thread2 = Thread {
            print("param:\(param), isMainThread:\(Thread.current.isMainThread)")
        }
        thread1.start()
        thread2.start()
    }
    
    @objc func threadMethod1(param: String) {
        print("param:\(param), isMainThread:\(Thread.current.isMainThread)")
    }
}
