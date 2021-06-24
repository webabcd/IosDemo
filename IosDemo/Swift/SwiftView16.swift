/*
 * 本例用于演示
 */

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
        
        return ""
    }
}
