//: Playground - noun: a place where people can play

//import UIKit
//
//var str = "Hello, playground"

print("Hello world")

var optionalStr: String? = "myname"

print("optionalStr = \(optionalStr!)")

let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int)
{
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max
        {
            max = score
        }
        else if score < min
        {
            min = score
        }
        
        sum += score
    }
    
    return (min, max, sum);
}

let statistics = calculateStatistics([5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)


func sumOf(numbers: Int...) -> Int
{
    var sum = 0
    for number in numbers
    {
        sum += number
    }
    
    return sum
}

sumOf()
sumOf(42, 597, 12)

func returnFifteen() -> Int
{
    var y = 120
    func add()
    {
        y += 5
    }
    
    add()
    return y
}

returnFifteen()

func makeIncrementer() -> (Int -> Int)
{
    func addOne(number: Int) -> Int
    {
        return 1 + number
    }
    
    return addOne
}

var increment = makeIncrementer()
increment(7)

func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool
{
    for item in list
    {
        if condition(item)
        {
            return true
        }
    }
    
    return false
}

func lessThanTen(number: Int) -> Bool
{
    return number < 10
}

var numbers = [20, 19, 7, 12]
hasAnyMatches(numbers, condition: lessThanTen)

numbers.map { (number: Int) -> Int in
    let result = 3 * number
    return result
}

let mappedNumbers = numbers.map( { number in 3 * number })
print(mappedNumbers)

let sortedNumbers = numbers.sort { $0 > $1}
print(sortedNumbers)


class Shape
{
    var numberOfSides = 0
    func simpleDescription() -> String
    {
        return "A shape with \(numberOfSides) sides."
    }
}

var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

class NamedShape
{
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String)
    {
        self.name = name
    }
    
    func simpleDescription() -> String
    {
        return "A shape with \(numberOfSides) sides."
    }
}

class Square: NamedShape
{
    var sideLength: Double
    
    init(sideLength: Double, name: String)
    {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double
    {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

class EquilateralTriangle: NamedShape
{
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String)
    {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double
    {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triagle with sides of length \(sideLength)."
    }
}

var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)

class TriangleAndSquare
{
    var triangle: EquilateralTriangle {
        willSet {
            print("aaa")
            square.sideLength = newValue.sideLength
        }
    }
    
    var square: Square {
        willSet {
            print("bbb")
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String)
    {
        print("cc")
        square = Square(sideLength: size, name: name)
        print("dd")
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}

var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)

let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength


enum Rank: Int
{
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String
    {
        switch self
        {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.Ace
let aceRawValue = ace.rawValue

if let convertedRank = Rank(rawValue: 3)
{
    let threeDescription = convertedRank.simpleDescription()
}

enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()

struct Card
{
    var rank: Rank
    var suit: Suit
    
    func simpleDescription() -> String
    {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}

let threeOfSpades = Card(rank: .Three, suit: .Spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

enum ServerResponse
{
    case Result(String, String)
    case Failure(String)
}

let success = ServerResponse.Result("6:00 am", "8:09 pm")
let failure = ServerResponse.Failure("Out of cheese.")

switch success
{
case let .Result(sunrise, sunset):
    let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
case let .Failure(message):
    print("Failure... \(message)")
}

protocol ExampleProtocol
{
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol
{
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}

var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

enum Test: Int, ExampleProtocol
{
    case Ace = 1
    case Two
    var simpleDescription: String {
        get {
            return "A test meiju Protocol."
        }
    }
    mutating func adjust() {
        switch self {
        case .Ace:
            print("aaaaaaa")
            self = .Two
        default:
            self = .Ace
        }
    }
}

var testmeiju = Test.Ace
testmeiju.simpleDescription
testmeiju.adjust()

enum PrinterError: ErrorType
{
    case OutOfPager
    case NoToner
    case OnFire
}

func sendToPrinter(printerName: String) throws -> String
{
    if printerName == "Never Has Toner"
    {
        throw PrinterError.NoToner
    }
    
    return "Job sent"
}

do
{
    let printerResponse = try sendToPrinter("Bi Sheng")
    print(printerResponse)
}catch{
    print(error)
}

do {
    let printerResponse = try sendToPrinter("Gutenberg")
    print(printerResponse)
} catch PrinterError.OnFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}

var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(itemName: String) -> Bool
{
    fridgeIsOpen = true
    defer{
        fridgeIsOpen = false
    }
    
    let result = fridgeContent.contains(itemName)
    return result
}

fridgeContains("banana")
print(fridgeIsOpen)

func repeatItem<Item>(item: Item, numberOfTimes: Int) -> [Item]
{
    var result = [Item]()
    for _ in 0..<numberOfTimes
    {
        result.append(item)
    }
    
    return result
}
repeatItem("knock", numberOfTimes: 4)

enum OptionalValue<Wrapped>
{
    case None
    case Some(Wrapped)
}

var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)

func anyCommonElements <T: SequenceType, U: SequenceType where T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element>(lhs: T, _ rhs: U) -> Bool
{
    for lhsItem in lhs
    {
        for rhsItem in rhs
        {
            if lhsItem == rhsItem
            {
                return true
            }
        }
    }
    
    return false
}

anyCommonElements([1, 2, 3], [3])

