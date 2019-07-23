//
//  main.swift
//  Calculator
//
//  Created by Alex Paul on 10/25/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//
import Foundation

var operations: ([String: (Double, Double) -> Double]) = ["+": { $0 + $1 },
                                                          "-": { $0 - $1 },
                                                          "*": { $0 * $1 },
                                                          "/": { $0 / $1 }]
func regularCalculator()-> String{
    print("Enter your operation eg 5 + 3")
    let userInput = readLine()!//get user Input
    let userInputArray = userInput.components(separatedBy: " ")// separate user input by spaces into a array
    guard userInputArray.count == 3 else {return "Wrong input. Please follow example 3 + 5"}// if user array has less or more than 3 values return eror
    if userInputArray[1] == "?"{// this check for the ? so it can generate a ramdom sign
        let randomOperator = operations.keys.randomElement()!
        guard let operand1 = Double(userInputArray[0]) else {return "oh no, wrong input"}
        guard let operand2 = Double(userInputArray[2])else { return "oh no, wrong input"}
        guard let operatorSign = operations[randomOperator] else {return "oh no, wrong input"}
        print("\(operand1) \(userInputArray[1]) \(operand2) = \(operatorSign(operand1, operand2 ))")
        print("Guess the operator used? +, -, * or / ")
        let anotherCheck = readLine()
        if anotherCheck == randomOperator{
            return "YAY, you guessed it"
        }
        return "Wrong, the operator was \(randomOperator)"
    }
    // this check for any answe that is in the dictionary
    guard let operand1 = Double(userInputArray[0]) else {return "oh no, wrong input"}
    guard let operand2 = Double(userInputArray[2])else { return "oh no, wrong input"}
    guard let operatorSign = operations[userInputArray[1]] else {return "oh no, wrong input"}
    print("\(operand1) \(userInputArray[1]) \(operand2) = \(operatorSign(operand1, operand2 ))")
    return  String("")
}
func myFilter(inputArray: [Int], filter: (Int) -> Bool) -> [Int] {
    var intArray = [Int]()
    for i in inputArray{
        if filter(i){
            intArray.append(i)
        }
    }
    return intArray
}
func myMap(inputArray: [Int], map: (Int) -> Int) -> [Int] {
    var intArray = [Int]()
    for i in inputArray{
        intArray.append(map(i))
    }
    return intArray
}
func higherOrder(){
    print("enter your operation e.g filter 1,2,3,4,5 by > 5")
    let userInput = readLine()!
    var checkedUserInput = userInput.components(separatedBy: " ")
    if checkedUserInput.count == 5 {
        let userNumberArray = checkedUserInput[1].components(separatedBy: ",").compactMap{Int($0)}// converts the input into Ints
        let userChoice = checkedUserInput[0]// 0 is would be filter,map or reduce
        let userSign = checkedUserInput[3]// check for the sign
        let userNumber = Int(checkedUserInput[4])// checks for the number
        
        let lessThan:(Int) -> Bool = {i in
            return i < userNumber!
        }
        let GreaterThan:(Int) -> Bool = {i in
            return i > userNumber!
        }
        let multiplyArray:(Int) -> Int = {i in
            return i * userNumber!
        }
        let divideArray :(Int) -> Int = {i in
            return i / userNumber!
        }
        switch userChoice {
        case "filter":
            if userSign == "<"{
                print(myFilter(inputArray: userNumberArray, filter: lessThan))
            } else if userSign == ">"{
                print(myFilter(inputArray: userNumberArray, filter: GreaterThan))
            }
        case "map":
            if userSign == "*"{
                print(myMap(inputArray: userNumberArray, map: multiplyArray))
            }else if userSign == "/"{
                print(myMap(inputArray: userNumberArray, map: divideArray))
            }
        default: print("Oh no, wrong input try again")
        }
    }else {
        print("Wrong input, please follow example, e.g filter 1,2,3,4,5 by > 5")
    }
}
while true {
    print("Please enter type of calculation, 1 (regular) or 2 (high order)")
    let typeCalcInput = readLine()!
    if typeCalcInput == "1" {
        print(regularCalculator())
    }else if typeCalcInput == "2"{
        higherOrder()
    }else {
        print("Invalid input, try again")
    }
    print("Do you want to keep calculating? y/n")
    let playAgainInput = readLine()!
    if playAgainInput != "y"{
        break
    }
}

