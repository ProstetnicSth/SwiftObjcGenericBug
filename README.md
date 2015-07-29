# A Bug in Exporting Swift Classes With Generics to Objective-C

1. Add a Dynamic Framework. 
2. Add a class:

```swift
public class MyClass: NSObject {
    public var name: String
    public init(name: String) {
        self.name = name
    }
}
```

3. Add a class with a generic type

```swift
public class MyGenericClass<ClassType where ClassType: MyClass>: NSObject {
    public var objectArray: [ClassType] = []
    
    init(objectArray: [ClassType]) {
        self.objectArray = objectArray
    }
}
```

4. Compile. **Compiles with no problem ✓** 
5. Make the classes public and try to use them in the main target.
6. Compile. **Compiler gets angry with the following problem ✕:**

```
<module-includes>:2:9: note: in file included from <module-includes>:2:
#import "Headers/TestFramework-Swift.h"
        ^
/Users/sth/Library/Developer/Xcode/DerivedData/GenericBug-gffjukpgfwqybwdgfdopezrkfxdd/Build/Products/Debug-iphonesimulator/TestFramework.framework/Headers/TestFramework-Swift.h:104:52: error: expected a type
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