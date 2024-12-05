/*
 * 本例用于演示数组（Array），集合（Set），字典（Dictionary）
 */

// 注：
// 1、Array 类型被桥接到了 NSArray，如果要调用 oc 的方法和属性，需要先加上 import Foundation
// 2、Set 类型被桥接到了 NSSet，如果要调用 oc 的方法和属性，需要先加上 import Foundation
// 3、Dictionary 类型被桥接到了 NSDictionary，如果要调用 oc 的方法和属性，需要先加上 import Foundation
import Foundation
import SwiftUI

struct SwiftView03: View {
    
    var result: String = "";
    
    init() {
        result = sample1() // 数组（Array）
        result += "\n";
        result += sample2() // 数组中闭包和高阶函数的使用
        result += "\n";
        result += sample3() // 元素不可重复，且无序的集合（Set）
        result += "\n";
        result += sample4() // 元素不可重复，且有序的集合（Set）
        result += "\n";
        result += sample5() // 字典（Dictionary）
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
        // Array 是有序的，且可重复的
        
        // 声明一个空数组，[Int]() 就是 Array<Int>()
        var a = [Int]()
        // append() - 在数组的末尾追加元素
        a.append(1) // [1]
        
        // 声明一个空数组
        var b:[Int] = []
        b.append(2) // [2]
        
        // 声明数组，并初始化数据
        var c = [1, 2, 3]
        c.append(4) // [1, 2, 3, 4]
        
        // 声明数组并初始化数据
        var d = Array(repeating: 1, count: 5) // [1, 1, 1, 1, 1]
        // 修改指定索引位置的元素
        d[1] = 2 // [1, 2, 1, 1, 1]
        // 修改指定索引位置范围的元素
        d[2...4] = [3, 4, 5] // [1, 2, 3, 4, 5]
        
        // 通过 + 做数组拼接
        var e = a + b; // [1, 2]
        e += [3]; // [1, 2, 3]
        // insert() - 在指定的索引位置上添加元素
        e.insert(4, at: 3) // [1, 2, 3, 4]
        
        // sorted(by: >) - 降序排序
        let f = e.sorted(by: >) // [4, 3, 2, 1]
        // sorted(by: >) - 升序排序
        let g = f.sorted(by: <) // [1, 2, 3, 4]
        
        // joined - 字符串数组转字符串
        // 注：如果数组的元素并非都是字符串，则可以通过 map 将其转换为字符串数组，然后再通过 joined 转为字符串
        let h = ["1", "2", "3", "4"].joined(separator: ",") // 1,2,3,4
        
        // Array 类型被桥接到了 NSArray，如果要调用 oc 的方法和属性，需要先加上 import Foundation
        let i = (e as NSArray).lastObject // Optional(4)
        
        /*
         * 其他常用属性或方法还有 isEmpty, count, filter(), first(), map(), contains(), remove(), removeFirst(), removeLast(), removeAll() 等
         */
        
        return "\(a), \(b), \(c), \(d), \(e), \(f), \(g), \(h), \(i)"
    }
    
    func sample2() -> String {
        // Array 是有序的，且可重复的
        // 本例介绍数组中闭包和高阶函数的使用
        
        var a = [1, 2, 3, 4] // [1, 2, 3, 4]

        // filter - 获取符合指定条件的数据
        let b = a.filter { p in
            p > 2
        } // [3, 4]
        
        // first - 获取符合指定条件的数据的第一条
        let c = a.first(where: { (p) -> Bool in
            p > 2
        }) // Optional(3)
        
        // map - 处理每个元素后再放入新的数组
        let d = a.map { p in String(p) } // ["1", "2", "3", "4"]
        
        // 使用 $0 引用第一个参数，从而进一步简化代码
        let e = a.filter { $0 > 2 } // [3, 4]
        
        // 使用 $0 引用第一个参数，从而进一步简化代码
        let f = a.first { $0 > 2 } // Optional(3)
        
        // 删除值为 3 的元素
        a.removeAll { $0 == 3 } // [1, 2, 4]
        
        return "\(a), \(b), \(c), \(d), \(e), \(f)"
    }

    func sample3() -> String {
        // Set 是无序的，且不可重复的（重复数据会被自动过滤掉）
        
        // 声明一个空的不可重复无序集合
        var a = Set<Int>()
        // insert() - 添加元素
        a.insert(1)
        a.insert(2)
        a.insert(2)
        a.insert(2)
        a.insert(3) // 此时元素有 1, 2, 3（元素顺序是不一定的）
        
        // 声明一个不可重复无序集合，并初始化数据
        let b: Set<Int> = [1, 2, 3]
        let c: Set<Int> = [1, 2, 3, 4, 5]
        let d: Set<Int> = [3, 4, 5, 6]
        let e: Set<Int> = [7, 8, 9]
        
        // 可以通过 == 判断两个集合的元素是否相同
        let f = (a == b) // true
        
        // isSubset() - 右侧是否包含左侧，相同也算包含
        let g = a.isSubset(of: c) // true
        // isSuperset() - 左侧是否包含右侧，相同也算包含
        let h = c.isSuperset(of: a) // true
        // isStrictSubset() - 右侧是否包含左侧，相同不算包含
        let i = a.isStrictSubset(of: c) // true
        // isStrictSuperset() - 左侧是否包含右侧，相同不算包含
        let j = c.isStrictSuperset(of: a) // true
        // isDisjoint() - 两个集合是否没有任何相同的元素
        let k = c.isDisjoint(with: e) // true
        
        // intersection() - 取两个集合中共有的元素
        let l = a.intersection(d) // 此时元素有 3
        // symmetricDifference() - 取两个集合中一方有而另一方没有的元素
        let m = a.symmetricDifference(d) // 此时元素有 1, 2, 4, 5, 6
        // union() - 包含两个集合的全部元素
        let n = a.union(d) // 此时元素有 1, 2, 3, 4, 5, 6
        // subtracting() - 取左侧集合的元素，但是要去掉两个集合共有的元素
        let o = a.subtracting(d) // 此时元素有 1, 2
        
        /*
         * 其他常用属性或方法还有 isEmpty, count, contains(), remove(), removeFirst(), removeAll() 等
         */
        
        // Set 类型被桥接到了 NSSet，如果要调用 oc 的方法和属性，需要先加上 import Foundation
        let p = (a as NSSet).count // 3
        
        return "\(a), \(b), \(c), \(d), \(e), \(f), \(g), \(h), \(i), \(j), \(k), \(l), \(m), \(n), \(o), \(p)"
    }
    
    func sample4() -> String {
        // Set 是无序的（但是可以排序），且不可重复的
        
        let a: Set<Int> = [1, 2, 3, 4, 5]
        // sorted(by: >) - 降序排序
        let b = a.sorted(by: >) // [5, 4, 3, 2, 1]
        // sorted(by: >) - 升序排序
        let c = a.sorted(by: <) // [1, 2, 3, 4, 5]
        
        // Set 转换为 Array
        let d = Array(a) // d 的数据类型是 Array<Int>
        // Array 转换为 Set
        let e = Set(d)  // e 的数据类型是 Set<Int>
        // Set 转换为 Array
        let f = [Int](a) // f 的数据类型是 Array<Int>
        
        return "\(a), \(b), \(c), \(type(of: d)), \(type(of: e)), \(type(of: f))"
    }
    
    func sample5() -> String {
        // Dictionary 是 key/value 字典表
        
        // 声明一个空字典，[String : String]() 就是 Dictionary<String, String>()
        var a = [String : String]()
        // 设置字典的 key 和 value
        a["k1"] = "v1"
        
        // 声明一个空字典
        var b: [String : String] = [:]
        b["k1"] = "v1"
        
        // 声明一个字典，并初始化数据
        var c = ["k1":"v1", "k2":"v2"]
        c["k1"] = "v111" // 更新字典指定 key 的 value
        c.updateValue("v222", forKey: "k2") // 更新字典指定 key 的 value
        
        // 判断是否有指定 key 的数据
        let d = c["k3"] // nil
        
        // 将 keys 转换为 String 数组
        let e = [String](b.keys) // ["k1"]
        
        // 遍历字典的 key 数据
        for key in b.keys {
            print(key)
        }
        
        // 遍历字典的 key/value 数据
        for (key, value) in b {
            print(key + value)
        }
        
        /*
         * 其他常用属性或方法还有 isEmpty, count, keys, values, contains(), removeValue(), removeAll() 等
         */
        
        // Dictionary 类型被桥接到了 NSDictionary，如果要调用 oc 的方法和属性，需要先加上 import Foundation
        let f = (a as NSDictionary).count // 1
        
        return "\(a), \(b), \(c), \(d), \(e), \(f)"
    }
}
