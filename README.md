## ZWZNavigationControllerDemo
Custom UINavigationController subclass which allows animated transitions on navigation bar background color.

[![ZWZNavigationControllerDemo Animation](https://github.com/xc4ll0c/ZWZNavigationControllerDemo/blob/master/demo.gif)](https://github.com/xc4ll0c/ZWZNavigationControllerDemo/blob/master/demo)

## Usage

#### Storyboard
If you've set up a Navigation Controller in your Storyboard, you'll need to specify `ZWZNavigationBar` as the custom class for the Navigation Bar in your Navigation Controller scene.

#### Programmatically
If you're initializing your Navigation Controller programmatically, you'll need to use the [`initWithNavigationBarClass:toolbarClass:`](https://developer.apple.com/library/ios/documentation/uikit/reference/UINavigationController_Class/Reference/Reference.html#//apple_ref/occ/instm/UINavigationController/initWithNavigationBarClass:toolbarClass:) initializer, passing `[ZWZNavigationBar class]` for the `*navigationBarClass*` parameter.

You'll need to import `ZWZNavigationController.h` when you want to change navigation bar background color, as described below.

### Configuration
The best place to set navigation bar background color for a view controller is the view controller's 'viewDidLoad:' method

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    [(ZWZNavigationController *)self.navigationController setNavigationBarBackgroudColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0
                                                                                                         green:arc4random_uniform(255)/255.0
                                                                                                          blue:arc4random_uniform(255)/255.0
                                                                                                         alpha:1]
                                                                       forViewController:self];
}
```

If you want to change the navigation bar background color after view did appeared, use the 'setBarBackgroundColor:animationDuration:options:usingSpring:'

Animated:
```objc
    ZWZNavigationController *nvc = (ZWZNavigationController *)self.navigationController;
    [nvc.zwzNavigationBar setBarBackgroundColor:color
                              animationDuration:0.35
                                        options:UIViewAnimationOptionCurveEaseInOut
                                    usingSpring:NO];
```

Not Animated:
```objc
    ZWZNavigationController *nvc = (ZWZNavigationController *)self.navigationController;
    [nvc.zwzNavigationBar setBarBackgroundColor:color
                              animationDuration:0
                                        options:0
                                    usingSpring:NO];
```

## About

WenZheng Zhang
- [GitHub](https://github.com/xc4ll0c)
