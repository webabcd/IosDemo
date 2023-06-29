/*
 * 本例用于演示 oc 如何调用 swift，以及被 swift 调用
 *
 *
 * 如果需要 oc 调用 swift
 * 1、需要桥接文件（此文件是不可见，但是可引用的）
 *    a) 对于 swift 项目来说，此文件在你新建项目的时候就自动生成了，在 Build Settings 中的 Objective-C Generated Interface Header Name 配置的值是 $(SWIFT_MODULE_NAME)-Swift.h
 *    b) 如果是在 oc 项目中创建 swift 文件，则会有弹窗提示是否需要创建此文件，如果确认的话则 xcode 会自动完成上述工作
 * 2、引用桥接文件
 *    a) 桥接文件的文件名为 项目名称-Swift.h
 *    b) 本例中此桥接文件的文件名为 IosDemo-Swift.h，通过 #import "IosDemo-Swift.h" 引用即可
 * 3、然后你就可以按 oc 的方式调用 swift 了
 *
 *
 * 注：
 * 如果你的 Build Settings 中没有 Objective-C Generated Interface Header Name 配置的话则可以文本方式编辑 project.pbxproj 文件，并在相关的位置增加 SWIFT_OBJC_INTERFACE_HEADER_NAME = "$(SWIFT_MODULE_NAME)-Swift.h";
 */

#import "SwiftView16_oc.h"
#import "IosDemo-Swift.h"

@implementation SwiftView16_oc

// oc 被 swift 调用的示例
- (NSString *)hello:(NSString *)message
{
    return [@"hello: " stringByAppendingString:message];
}

// oc 调用 swift 的示例
- (NSString *)ocToSwift
{
    SwiftView16_swift *x = [[SwiftView16_swift alloc] init];
    return [x helloWithMessage:@"oc 调用 swift"];
}

@end
