/*
 * 本例用于演示 swift 如何调用 oc，以及被 oc 调用
 *
 *
 * 如果需要 swift 调用 oc
 * 1、需要创建一个名为 项目名称-Bridging-Header.h 的文件（桥接文件），并在 Build Settings 的 Objective-C Bridging Header 中配置好此文件的路径（注：在 oc 项目中新建一个 swift 文件时，xcode 会提示是否需要自动创建桥接文件）
 *    a) 本例中会有一个 IosDemo-Bridging-Header.h 文件，Objective-C Bridging Header 配置的值是 IosDemo/Swift/IosDemo-Bridging-Header.h
 *    b) 如果是在 swift 项目中创建 oc 文件，则会有弹窗提示是否需要创建此文件，如果确认的话则 xcode 会自动完成上述工作
 * 2、在 项目名称-Bridging-Header.h 的文件中通过 import 导入你需要调用的 .h 文件
 *    a) 本例中的 IosDemo-Bridging-Header.h 文件的内容为 # import "SwiftView16_oc.h"
 * 3、然后你就可以按 swift 的方式调用 oc 了
 *
 *
 * 如果需要 swift 被 oc 调用
 * 1、swift 的类要继承 NSObject
 * 2、允许被 oc 调用的 swift 的方法要用 @objc 标记
 */

import Foundation

class SwiftView16_swift : NSObject
{
    // swift 被 oc 调用的示例
    @objc func hello(message: String) -> String
    {
        return "hello: \(message)";
    }
    
    // swift 调用 oc 的示例
    func swiftToOc() -> String
    {
        let x = SwiftView16_oc();
        return x.hello("swift 调用 oc");
    }
}
