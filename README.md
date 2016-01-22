# DDStoryboard

Create a instance of UIViewController or it's subclass from any storyboard.

This category method will find out the UIViewController from all storyboard files in the Bundle by using class name as identifier. 

#Usage

1: Create UIViewController or it's subclass in storyboard.

2: Input UIViewController's class name in Xcode 's identity inspector.

3: Input UIViewController's class name as it's Stroyboard ID in Xcode 's identity inspector.

4: #import UIViewController's header file.

5: code:  CustomViewController *vc = [CustomViewController instanceFromStoryboard];

#中文

这个UIViewController的类别，提供了一个便利的方法，可以从storyboard中取出实例，而不用理会这个控制器是在哪个storyboard中创建的。

使用方法：

1：在storyboard中拖进去一个UIViewController或者它的子类

2：在storyboard中，打开Xcode的identity inspector，输入控制器的类名，用类名作为id输入Stroyboard ID

3：在需要用到控制器的地方，import 头文件

4：使用 instanceFromStoryboard 类方法获取控制器实例。