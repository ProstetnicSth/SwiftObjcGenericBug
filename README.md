# A Bug in Exporting Swift Classes With Generics to Objective-C

* Add a Dynamic Framework. 
* Add a class:

```swift
public class MyClass: NSObject {
    public var name: String
    public init(name: String) {
        self.name = name
    }
}
```

* Add a class with a generic type

```swift
class MyGenericClass<ClassType where ClassType: MyClass>: NSObject {
    var objectArray: [ClassType] = []
    
    init(objectArray: [ClassType]) {
        self.objectArray = objectArray
    }
}
```

* Compile. **Compiles with no problem ✓** 
* Make the classes public and try to use them in the main target.
* Compile again. **Compiler gets angry with the following problem ✕:**

```
#import "Headers/TestFramework-Swift.h"
        ^
[...]/TestFramework.framework/Headers/TestFramework-Swift.h:104:52: error: expected a type
@property (nonatomic, copy) NSArray</* ClassType */> * __nonnull objectArray;
                                                   ^
<unknown>:0: error: could not build Objective-C module 'TestFramework'
```

When you look at the `TestFramework-Swift.h`, you'll see the problem:

``` objc
SWIFT_CLASS("_TtC13TestFramework14MyGenericClass")
@interface MyGenericClass : NSObject
@property (nonatomic, copy) NSArray</* ClassType */> * __nonnull objectArray;
@end
```

The generic part of `NSArray` is somehow commented out.
