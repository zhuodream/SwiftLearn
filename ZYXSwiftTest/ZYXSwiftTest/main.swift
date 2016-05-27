//
//  main.swift
//  ZYXSwiftTest
//
//  Created by 卓酉鑫 on 16/5/23.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import Foundation

//class NamedShape
//{
//    var numberOfSides: Int = 0
//    var name: String
//    
//    init(name: String)
//    {
//        self.name = name
//    }
//    
//    func simpleDescription() -> String
//    {
//        return "A shape with \(numberOfSides) sides."
//    }
//}
//
//class Square: NamedShape
//{
//    var sideLength: Double
//    
//    init(sideLength: Double, name: String)
//    {
//        self.sideLength = sideLength
//        super.init(name: name)
//        numberOfSides = 4
//    }
//    
//    func area() -> Double
//    {
//        return sideLength * sideLength
//    }
//    
//    override func simpleDescription() -> String {
//        return "A square with sides of length \(sideLength)."
//    }
//}
//
//
//
//class EquilateralTriangle: NamedShape
//{
//    var sideLength: Double = 0.0
//    
//    init(sideLength: Double, name: String)
//    {
//        self.sideLength = sideLength
//        super.init(name: name)
//        numberOfSides = 3
//    }
//    
//    var perimeter: Double
//        {
//        get {
//            return 3.0 * sideLength
//        }
//        set {
//            sideLength = newValue / 3.0
//        }
//    }
//    
//    override func simpleDescription() -> String {
//        return "An equilateral triagle with sides of length \(sideLength)."
//    }
//}
//
//
//class TriangleAndSquare
//{
//    var triangle: EquilateralTriangle {
//        willSet {
//            print("aaa")
//            square.sideLength = newValue.sideLength
//        }
//    }
//    
//    var square: Square {
//        willSet {
//            print("bbb")
//            triangle.sideLength = newValue.sideLength
//        }
//    }
//    
//    init(size: Double, name: String)
//    {
//        print("cc")
//        square = Square(sideLength: size, name: name)
//        print("dd")
//        triangle = EquilateralTriangle(sideLength: size, name: name)
//    }
//}
//
//var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
//print(triangleAndSquare.square.sideLength)
//print(triangleAndSquare.triangle.sideLength)
//triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
//print(triangleAndSquare.triangle.sideLength)
//print("Hello, World!")
//
//protocol ExampleProtocol
//{
//    var simpleDescription: String { get set }
//    mutating func adjust()
//}
//
//class SimpleClass: ExampleProtocol
//{
//    var simpleDescription: String = "A very simple class."
//    var anotherProperty: Int = 69105
//    func adjust() {
//        simpleDescription += " Now 100% adjusted."
//    }
//}
//
//
//enum Test: Int, ExampleProtocol
//{
//    case Ace = 1
//    case Two
//    var simpleDescription: String {
//        get {
//            return "Test meiju Protocol."
//        }
//        set {
//            switch newValue {
//            case "aaa":
//                self = .Two
//            default:
//                self = .Ace
//            }
//        }
//    }
//    mutating func adjust() {
//        switch self {
//        case .Ace:
//            self = .Two
//        default:
//            self = .Ace
//        }
//    }
//}
//
//var testmeiju = Test.Ace
//testmeiju.simpleDescription = String("aaa")
//print("\(testmeiju.simpleDescription)")
//let str = testmeiju.simpleDescription
//testmeiju.adjust()

class Superclass
{
    var test: String {
        
        willSet {
            print("newValue = \(newValue)")
        }
        didSet {
            print("oldValue = \(oldValue)")
        }
    }
    
    init(test: String)
    {
        self.test = test
    }
}

class SubCalss: Superclass
{
    override var test: String {
        willSet {
            print("sub newValue = \(newValue)")
        }
        didSet {
            print("sub oldValue = \(oldValue)")
        }
    }
}

let sub = SubCalss(test: "aaaaa")
sub.test = "ss"
