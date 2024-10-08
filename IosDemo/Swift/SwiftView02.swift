/*
 * 本例用于演示字符串（多行字符串，不解释转义符，字符串模板，字符串格式化，字符串拼接，相等和不等判断，Unicode 码转字符串，字符串的常用方法和属性，调用 NSString 的方法和属性）
 */

// 注：String 类型被桥接到了 NSString，如果要调用 oc 的方法和属性，需要先加上 import Foundation
import Foundation
import SwiftUI

struct SwiftView02: View {
    
    var result: String = "";
    
    init() {
        result = sample1(); // 多行字符串，不解释转义符，字符串模板，字符串格式化
        result += "\n";
        result += sample2(); // 字符串拼接，相等和不等判断，Unicode 码转字符串
        result += "\n";
        result += sample3(); // 字符串的常用方法和属性
        result += "\n";
        result += sample4(); // 调用 NSString 的方法和属性
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
        // 多行字符串，用两个 """ 包围起来，每个 """ 都要单独占一行
        // 每一行文本都是支持空格的，每行的起始位置是与后面的 """ 中的第一个 " 对齐的
        // 在多行字符串声明中，如果你只是为了阅读方便，实际结果还是需要多行变一行的话，那就在这些行的末尾加 \
        let a = """
                           111
                          222
                         333
                        444\
                        555
                        """;
        
        // #" "# 包围起来的字符串不解释转义符，可以不借助转义符直接显示 " ' 等
        // 注：也可以通过 #""" """# 显示多行字符串且不解释转义符
        let b = #"a\nb\tc""#;
        
        // 在字符串中通过 \() 来插入变量或表达式，这就是所谓的字符串模板
        let c = "\(b)";
        // 如果想在 #" "# 中插入变量或表达式的话，就用 \#()
        let d = #"\#(b)"#;
        
        // 字符串格式化的示例
        let e = String(format: "name:%@, age:%d", arguments: ["webabcd", 40])
        
        // 格式化浮点型数据，保留 n 位小数
        let f = String(format: "salary:%.3f", 123.456789)
        
        return "\(a)\n\(b), \(c), \(d), \(e), \(f)";
    }

    func sample2() -> String {
        let a: String = "a";
        let b: Character = "a";
        // let c = a + b; // swift 不支持数据类型的隐式转换
        let c = a + String(b); // 通过 + 做字符串拼接
        var d = "a";
        d.append("b"); // 通过 append() 方法做字符串拼接
        
        // 在 swift 中 String 是值类型，可以通过 == 和 != 来判断相等或不等
        let e = (a == String(b));
        
        // Unicode 码转字符串
        let f = "\u{738B}"; // 王
        
        // a, a, aa, ab, true, 王
        return "\(a), \(b), \(c), \(d), \(e), \(f)";
    }

    func sample3() -> String {
        let a = "webabcd";
        // 取前 3 个字符
        let b = a.prefix(3); // web
        // 取后 4 个字符
        let c = a.suffix(4); // abcd
        
        // 取索引位置 3 到 5 的字符
        let index1 = a.index(a.startIndex, offsetBy: 3);
        let index2 = a.index(a.startIndex, offsetBy: 6);
        let d = a[index1..<index2]; // abc
        
        /*
         * 字符串的常用方法和属性太多了，懒得写了
         */
        
        // webabcd, web, abcd, abc
        return "\(a), \(b), \(c), \(d)";
    }

    func sample4() -> String {
        let a = "webabcd";
        
        // 注：String 类型被桥接到了 NSString，如果要调用 oc 的方法和属性，需要先加上 import Foundation
        
        // 可以直接调用 oc 的方法和属性
        let b = a.contains("web");
        // 部分 oc 的方法和属性可能没法直接调用，那就像这样强制转换一下再调用
        let c = (a as NSString).contains("web");

        // webabcd, true, true
        return "\(a), \(b), \(c)";
    }
}
