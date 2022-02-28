/*
 * 本例用于演示变量，常量，基本数据类型，类型转换，类型别名，元组，可空类型，运算符，??，类型后跟!和?，值后跟!和?，m...n，m...，...n，m..<n，控制台打印数据，注释可嵌套，语句末尾可以不加分号，数据转换
 */

import SwiftUI

struct SwiftView01: View {
    
    var result: String = "";
    
    init() {
        // print() - 在控制台打印数据
        print("webabcd");
        
        /*
        /*
         * 注释可嵌套
         */
         */
        
        result = sample1(); // 变量和常量
        result += "\n";
        result += sample2(); // 基本数据类型
        result += "\n";
        result += sample3(); // 元组
        result += "\n";
        result += sample4(); // 可选类型（Optional），即可空类型
        result += "\n";
        result += sample5(); // 运算符
        result += "\n";
        result += sample6(); // 范围运算符（m...n，m...，...n，m..<n）
        result += "\n";
        result += sample7(); // 数据的类型转换
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
        var a = ""; // var - 变量
        a = "a"
        let b = "b"; // let - 常量（准确的说是不可变变量，即在运行时决定而不是编译时决定）
        let 中文 = "c"; // 变量名支持任意 unicode 字符
        let `var` = "d"; // 用 swift 的关键字做变量名的话要用 `` 包围起来
        let e = "e", f = "f"; // 在一行里声明多个变量用 , 隔开
        let g = "g" // 语句末尾可以不加分号（除非多条语句在同一行）
        
        return a + b + 中文 + `var` + e + f + g; // abcdefg
    }

    func sample2() -> String {
        // 支持 Int, Int64, UInt, UInt64, Float, Double, Bool, String, Character 等基本数据类型
        
        let a: Int = 10; // 通过在变量名后面加上 :数据类型 来指定变量的数据类型（不指定的话则由编译器自己推断）
        let b: Double = 10.0;
        // var c = a + b; // 注意：swift 不支持数据类型的隐式转换，这句会编译时报错的
        let c = Double(a) + b; // 需要对数据类型做强制转换
        
        let d = 1.0; // 编译器会将数据类型推断为 double 而不是 float
        let e = 0b11111111; // 二进制
        let f = 0o377; // 八进制
        let g = 0xff; // 十六进制
        
        // e 跟在十进制数后面，代表 10 的 n 次方，结果是 double 类型，此句意为 123 乘以 10 的 3 次方
        let h = 123e3;
        // p 跟在二进制数后面，代表 2 的 n 次方，结果是 double 类型，此句意为 15 乘以 2 的 3 次方
        let i = 0xfp3;
        // 通过 _ 连接数字，以便阅读
        let j = 12_345_67.1_23_4567;
        
        // typealias - 为类型指定别名
        typealias MyInt = Int;
        let k: MyInt = 100;
        
        // 10, 10.0, 20.0, 1.0, 255, 255, 255, 123000.0, 120.0, 1234567.1234567, 100
        return "\(a), \(b), \(c), \(d), \(e), \(f), \(g), \(h), \(i), \(j), \(k)";
    }

    func sample3() -> String {
        // 元组（Tuple）用于将多个值组成一个复合值
        var a: (Int, Bool, String) = (1, true, "webabcd");
        // 通过 .0 .1 .2 之类的访问元组中指定索引位置的元素
        a.0 = 100;
        // 元组分解，如果你不想用元组中的某些元素，就用 _ 代表他
        let (b, c, _) = a;
        
        // 元组定义时，可以指定每个元素的名称
        var d = (p1:"v1", p2:"v2");
        // 通过指定元素名称访问元组中的指定元素
        d.p1 = "v100";
        
        // 100, true, webabcd, 100, true, v100, v2
        return "\(a.0), \(a.1), \(a.2), \(b), \(c), \(d.p1), \(d.p2)";
    }

    func sample4() -> String {
        // 类型后面跟 ? 用于声明可选类型（Optional），即可空类型
        let a: Int? = nil;
        let b: Int? = 100;
        
        // 值后面跟 ! 用于强制取出可空类型中的值
        // let a2 = a!; // 此句会运行时报错，因为 a 是 nil
        let b2 = b!; // 此句运行正常，b2 会被推断为 Int 类型，而不是 Int? 类型
        
        // 类型后面跟 ! 用于在需要的时候将可空类型隐式转换为对应的不可空类型
        let c: Int! = b; // c 的类型是 Int?
        let c2 = c; // c2 的类型是 Int?
        let c3: Int = c; // c3 的类型是 Int
        let c4 = c + 0; // c4 的类型是 Int
        
        // 如下方式用于尝试取出可空类型中的值
        if let d = b { // 可以取出可空类型 b 中的值，这里 d 会被推断为 Int 类型，而不是 Int? 类型
            
            // nil, Optional(100), 100, Optional(100), Optional(100), 100, 100, 100
            return "\(a), \(b), \(b2), \(c), \(c2), \(c3), \(c4), \(d)";

        } else { // 可空类型 b 是 nil
            return "不会走到这里"
        }
    }
    
    func sample5() -> String {
        // 经典的 + - * / 之类的运算符都是支持的，三元运算符 ? : 也是支持的
        // 但是 ++ 和 -- 都是不支持的
        
        let a: Int? = nil;
        // ?? 的意思是：左侧的数据是 nil 则返回右侧的值，否则返回左侧的值
        let b: Int = a ?? 123;
        
        let c: String? = "webabcd";
        let d: String? = nil
        // 值后面跟 ? 然后再调用属性或方法的意思如下
        // 1、左侧不为 nil 则调用右侧的属性或方法，然后将结果转换为对应的可空类型
        // 2、左侧为 nil 则忽略右侧调用的属性或方法，直接返回 nil
        // c.count 这句会编译时报错（因为 c 是可空类型，后面要跟 ? 或 !）
        // c?.count 的结果是 Optional(7)
        // c!.count 的结果是 7
        // d?.count 的结果是 nil
        // d!.count 这句会运行时报错（因为 d 是 nil）
        
        // nil, 123, Optional(7), 7, nil
        return "\(a), \(b), \(c?.count), \(c!.count), \(d?.count)";
    }
    
    func sample6() -> String {
        let a = ["a", "b", "c", "d", "e", "f", "g"];
        
        // 索引位置 2 到末尾
        let b = a[2...]; // ["c", "d", "e", "f", "g"]
        // 索引位置起始到 2
        let c = a[...2]; // ["a", "b", "c"]
        // 索引位置 2 到 4
        let d = a[2...4]; // ["c", "d", "e"]
        // 索引位置 2 到 3
        let e = a[2..<4]; // ["c", "d"]
        
        return "\(a), \(b), \(c), \(d), \(e)";
    }
    
    func sample7() -> String {
        // 以下演示如何做数据的类型转换（注：Swift 是不支持数据类型的隐式转换的）
        
        let a = "123"; // String 类型
        let b = Int(123) // Int 类型
        
        let c = [1, 2, 3] // Array<Int> 类型
        let d = Set(c) // Set<Int> 类型
        let e = Array(d) // Array<Int> 类型
        let f = Array<Int>(d) // Array<Int> 类型
        let g = [Int](d) // Array<Int> 类型
        
        return "\(type(of: a)), \(type(of: b)), \(type(of: c)), \(type(of: d)), \(type(of: e)), \(type(of: f)), \(type(of: g))";
    }
}
