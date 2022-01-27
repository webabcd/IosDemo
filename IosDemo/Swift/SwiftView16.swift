/*
 * 本例用于演示 swift 和 oc 互相调用
 *
 * 参见 SwiftView16_swift.swift, SwiftView16_oc.h, SwiftView16_oc.m 文件
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
        
        // 用于演示 oc 调用 swift
        let a = SwiftView16_oc().ocToSwift()!;
        
        // 用于演示 swift 调用 oc
        let b = SwiftView16_swift().swiftToOc();
        
        return "\(a)\n\(b)";
    }

}
