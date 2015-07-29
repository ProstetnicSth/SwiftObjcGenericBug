//
//  MyClass.swift
//  GenericBug
//
//  Created by Seyithan Teymur on 29/07/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

public class MyClass: NSObject {
    public var name: String
    public init(name: String) {
        self.name = name
    }
}

public class MyGenericClass<ClassType where ClassType: MyClass>: NSObject {
    public var objectArray: [ClassType] = []
    
    init(objectArray: [ClassType]) {
        self.objectArray = objectArray
    }
}