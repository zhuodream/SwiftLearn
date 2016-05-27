// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"
str = "Hello, Swift"
let constStr = str

var nextYear: Int
var bodyTemp: Float
var hasPet: Bool

var arrayOfInts: [Int]
var dictionaryOfCapitalsByCountry: [String:String]
var winningLotteryNumbers: Set<Int>

//: # Literals and Subscripting

let number = 42
let fmStation = 91.1

let countingUp = ["one", "two"]
let secondElement = countingUp[1]
let nameByParkingSpace = [13: "Alice", 27: "Bob"]
//let space13Assignee = nameByParkingSpace[13]
//let space42Assignee = nameByParkingSpace[42]
if let space13Assignee = nameByParkingSpace[13] {
    print("Key 13 was in the dictionary!")
}

//: # Initializers

let emptyString = String()
let emptyArrayOfInts = [Int]()
let emptySetOfFloats = Set<Float>()



let defaultNumber = Int()
let defaultBool = Bool()

let meaningOfLife = String(42)

let availableRooms = Set([205, 411, 412])

let defaultFloat = Float()
let floatFromLiteral = Float(3.14)

let easyPi = 3.14
let floatFromDouble = Float(easyPi)
let floatingPi: Float = 3.14


var reading1: Float? = 9.8
var reading2: Float? = 9.2
var reading3: Float? = 9.7

if let r1 = reading1,
    r2 = reading2,
    r3 = reading3 {
        let avgReading = (r1 + r2 + r3) / 3
} else {
    let errorString = "Instrument reported a reading that was nil."
}

//: # Control Flow


if defaultBool {
    // do something
}
else {
    // do something else
}

for var i = 0; i < countingUp.count; i++ {
    let string = countingUp[i]
}

let range = 0..<countingUp.count
for i in range {
    let string = countingUp[i]
}

for string in countingUp {
    
}

for (i, string) in countingUp.enumerate() {
    
}

//: # String Interpolation

for (space, name) in nameByParkingSpace {
    let permit = "Space \(space): \(name)"
}



enum PieType {
    case Apple
    case Cherry
    case Pecan
}
let favoritePie = PieType.Apple

var piesToBake: [PieType] = []
piesToBake.append(.Apple)

let name: String
switch favoritePie {
case .Apple:
    name = "Apple"
case .Cherry:
    name = "Cherry"
case .Pecan:
    name = "Pecan"
}


enum PieTypeInt: Int {
    case Apple = 0
    case Cherry = 1
    case Pecan = 2
}
let pieRawValue = PieTypeInt.Pecan.rawValue
if let pie = PieTypeInt(rawValue: pieRawValue) {
    
}

