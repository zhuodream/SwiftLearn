//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var shoppingList = ["Eggs", "Milk"]
shoppingList.append("Flour")

shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Buffer"]

shoppingList[4...6] = ["Bananas", "Apples"]
for str in shoppingList
{
   print(str)
}

for (index, value) in shoppingList.enumerate()
{
    print("Item \(String(index + 1)) : \(value)")
}

var letters = Set<Character>()
print("letter is of type Set<Character> with \(letters.count) items.")
letters.insert("a")
letters = []

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

let removedGenre = favoriteGenres.remove("Rock")
print(removedGenre!)

if #available(iOS 9, *)
{
    print("iOS 9")
}
else
{
    print("old")
}

func someFunction(externalParameterName firstName: Int, secondParameterName: Int)
{
    
}

someFunction(externalParameterName: 1, secondParameterName: 2)

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: () -> Void)
{
    completionHandlers.append(completionHandler)
}

func Test() -> Void
{
    print("aaaaa")
}

someFunctionWithEscapingClosure({ () -> Void in print("bbbb")})

someFunctionWithEscapingClosure{ print("aaaa")}
completionHandlers.first?()

let cons = "str"
var test1 = cons
var test2 = test1
print(unsafeAddressOf(cons))
print(unsafeAddressOf(test1))
print(unsafeAddressOf(test2))

class Food
{
    var name: String
    init(name: String)
    {
        self.name = name
    }
    
    convenience init()
    {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class ReceiptIngredient: Food
{
    var quantity:Int
    init(name: String, quantity: Int)
    {
        self.quantity = quantity
        super.init(name: name)
    }
    
    convenience override init(name: String)
    {
        self.init(name: name, quantity: 1)
    }
}

let oneMusteryItem = ReceiptIngredient()

class ShoppingListItem: ReceiptIngredient
{
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "√" : "×"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: '\(song.name)', by \(song.artist)")
    }
}

func twoSum(nums: [Int], _ target: Int) -> [Int] {
    var result: [Int] = []
    if nums.count == 1 {
        return result
    }
    
    var dict: Dictionary<Int, Int> = [:]
    for sub in 0..<nums.count {
        dict[nums[sub]] = sub
    }
    
    for sub in 0..<nums.count {
        if let res = dict[target - nums[sub]] {
            if res > sub
            {
                result.append(sub)
                result.append(res)
            }
        }
//        let res = dict[target - nums[sub]]
//        if (res != nil) && (res! > sub) {
//            result.append(sub)
//            result.append(res!)
//            break
//        }
        
    }
    
    return result
}

