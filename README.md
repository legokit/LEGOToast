# LEGOToast

[![CI Status](https://img.shields.io/travis/564008993@qq.com/LEGOToast.svg?style=flat)](https://travis-ci.org/564008993@qq.com/LEGOToast)
[![Version](https://img.shields.io/cocoapods/v/LEGOToast.svg?style=flat)](https://cocoapods.org/pods/LEGOToast)
[![License](https://img.shields.io/cocoapods/l/LEGOToast.svg?style=flat)](https://cocoapods.org/pods/LEGOToast)
[![Platform](https://img.shields.io/cocoapods/p/LEGOToast.svg?style=flat)](https://cocoapods.org/pods/LEGOToast)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LEGOToast is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LEGOToast'
```

```
/**
 default position show center. inView is window.
 
 @param msg msg
 */
+ (void)showByMessage:(NSString *)msg;

/**
 position show position. inView is window.
 
 @param msg msg
 @param position custom show position
 */
+ (void)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position;


/**
 default position show center. inView is custom.

 @param msg msg
 @param view inView
 */
+ (void)showByMessage:(NSString *)msg inView:(UIView *)view;


/**
 default position show center. inView is custom.
 
 @param msg msg
 @param position position show position
 */
+ (void)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position
               inView:(UIView *)view;


/**
 position show position. inView is window.
 
 @param msg msg
 @param position custom show custom
 @param offsetY offset position value (60 + offsetY)

 */
+ (void)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position
              offsetY:(CGFloat)offsetY;

/**
 position show position. inView is window.
 
 @param msg msg
 @param position custom show custom
 @param offsetY offset position value (60 + offsetY)
 
 */
+ (void)showByAttributedString:(NSAttributedString *)attributedString
                  positionType:(LGNoticePopuViewPosition)position
                       offsetY:(CGFloat)offsetY;
```
                       
## Author

564008993@qq.com, 564008993@qq.com

## License

LEGOToast is available under the MIT license. See the LICENSE file for more info.
