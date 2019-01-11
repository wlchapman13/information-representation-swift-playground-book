//
//  Entity.swift
//  Book_Sources
//
//  Created by WILLIAM CHAPMAN on 12/19/18.
//


import Foundation

extension Int {
    var eightBitRepresentation:String {
        let numBit = 8
        
        var i = self
        if i < 0 {
            i = 0b1 << numBit + i
        }
        
        var str = String(i, radix: 2)
        while str.count < numBit {
            str = "0" + str
        }
        return str
    }
}

enum Input: Equatable {
    case int(Int)
    case double(Double)
    case character(Character)
    case string(String)
    case bool(Bool)
}

struct Entity: CustomStringConvertible {
    var name = "x"
    var value:Input = .int(0)
    var isConstant = true
    var bitString = "00000000"
    
    init(newName: String, newValue: Input, newIsConstant: Bool, newBitString: String) {
        self.name = newName
        self.value = newValue
        self.isConstant = newIsConstant
        self.bitString = newBitString
    }
    
    //  Failable initializer that takes a line of code and creates an optional Entity instance.
    //  If it is a 'var' or 'let' statement, returns a populated instance of Entity.
    //  Returns nil if not.
    init?(lineOfCode: String) {
        
        var value:Input? = nil
        var constant = true
        
        let sides = lineOfCode.split(separator: "=")
        print("Sides: \(sides)")
        if sides.count != 2 { return nil }
        
        let lhs = sides.first!
        let rhs = sides.last!
        
        print("inside parser: lhs:\(lhs); rhs:\(rhs)")
        
        if lhs.count < 1 { return nil }
        if rhs.count < 1 { return nil }
        
        //  determine if it is a variable or a constant and obtain the tokenName
        if lhs.hasPrefix("var ") {
            constant = false
        } else if lhs.hasPrefix("let ") {
            constant = true
        } else {
            return nil
        }
        
        print("made it here 002")
        //  if we've made it this far without returning, we have a valid 'var' or 'let' with suffix as variable name
        let str = "********************"
        let suffix = lhs.suffix(from: str.index(lhs.startIndex, offsetBy: 4))
        let token = String(suffix).trimmingCharacters(in: .whitespacesAndNewlines)
        
        let tokenNameWithType = token.split(separator: ":")
        
        //  check to see if there is just a variable declared (1-element), or if there is both a variable and a TYPE declared (2-elements)
        //  var variableType:Input = .int(0)
        let variableName = tokenNameWithType[0].trimmingCharacters(in: .whitespacesAndNewlines)
        if tokenNameWithType.count == 2 {
            let possType = tokenNameWithType[1].trimmingCharacters(in: .whitespacesAndNewlines)
            switch possType {
            case "Int":
                value = .int(0)
            case "Double":
                value = .double(0.0)
            case "Bool":
                value = .bool(false)
            case "Character":
                value = .character(" ")
            case "String":
                value = .string("")
            default:
                value = nil
            }
        }
        
        let blankCharacter:Input = .character(" ")
        var aNewBitString = "00000000"
        //  Check if we can reasonably convert the string in the RHS to one of our valid input types
        print("***INPUT\(rhs.trimmingCharacters(in: .whitespacesAndNewlines))INPUT***")
        if let newValue = Int(rhs.trimmingCharacters(in: .whitespacesAndNewlines)) {
            print("found INTEGER")
            value = .int(newValue)
            aNewBitString = newValue.eightBitRepresentation
        } else if let newValue = Double(rhs.trimmingCharacters(in: .whitespacesAndNewlines)) {
            print("found DOUBLE")
            value = .double(newValue)
            aNewBitString = String(String(newValue.bitPattern, radix: 2).suffix(8))
        } else if let newValue = Bool(rhs.trimmingCharacters(in: .whitespacesAndNewlines)) {
            print("found BOOL")
            value = .bool(newValue)
            if newValue {
                aNewBitString = "00000001"
            } else {
                aNewBitString = "00000000"
            }
        } else if let newChar = value {
            if case Input.character = blankCharacter {
                if ((rhs.trimmingCharacters(in: .whitespacesAndNewlines)).count == 1) {
                    print("found CHARACTER")
                    let zChar = Character((rhs.trimmingCharacters(in: .whitespacesAndNewlines)))
                    print(zChar)
                    value = .character(zChar)
                }
            }
            
            print("found CHARACTER")
            let trimmedInput = rhs.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "")
            let newCh = Character(trimmedInput)
            value = .character(newCh)
            aNewBitString = String(newCh.unicodeScalars.first!.value, radix: 2).padding(toLength: 8, withPad: "0", startingAt: 0)
        } else {
            print("found STRING")
            let newValue = String(rhs.trimmingCharacters(in: .whitespacesAndNewlines))
            value = .string(newValue)
        }
        
        self.init(newName: variableName, newValue: value!, newIsConstant: constant, newBitString: aNewBitString)
        
    }
    
    mutating func setBitString(newBitString: String) {
        bitString = newBitString
    }
    
    var description:String {
        var stringRepresentation = "---------------------------------------------\n"
        stringRepresentation += (isConstant ? "constant" : "variable")
        stringRepresentation += " \"\(name)\" has value \(value) with bitString: \(bitString)\n"
        stringRepresentation += "---------------------------------------------\n"
        return stringRepresentation
    }
    
}
