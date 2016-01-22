# DDStoryboard

Create a instance of UIViewController or it's subclass from any storyboard.

This category method will find out the UIViewController from all storyboard files in the Bundle by using class name as identifier. 

#Usage

1: Create UIViewController or it's subclass in storyboard.
2: Input UIViewController's class name in Xcode 's identity inspector.
3: Input UIViewController's class name as it's Stroyboard ID in Xcode 's identity inspector.
4: #import UIViewController's header file.
5: code:  CustomViewController *vc = [CustomViewController instanceFromStoryboard];