//
//  Compiler.swift
//  Book_Sources
//
//  Created by WILLIAM CHAPMAN on 1/8/19.
//

import Foundation

struct Compiler: CustomStringConvertible {
    var entities = [Entity]()
    static var entityCount = 0
    
    public mutating func parse(linesOfCode: [String]) {
//        print("inside parse...")
//        let linesOfCode = code.split(separator: "\n")
        print("about to parse \(linesOfCode.count) lines of code...")
        for line in linesOfCode {
            print("parsing: \(line)")
            if let entity = Entity(lineOfCode: String(line)) {
                entities.append(entity)
                Compiler.entityCount += 1
            }
        }
        
        //  At this point, we have an array of compiled commands, BUT String initializations have not been deconstructed into
        //  the Character components.  Find all strings and create Character Entities for each character in the String.
        //  Here's the fun part ... assign the 'value' of the String entity to be the beginning 'memory address' of
        //  the first Character from the string.
        for index in entities.indices {
            let type = entities[index].value
            if case Input.string(let stringValue) = type {
                print("Compiler found a string: \(stringValue)")
                
                for (i, aChar) in stringValue.replacingOccurrences(of: "\"", with: "").enumerated() {
                    //  let's use the available initializer and create a Character initialization command to compile
                    
                    let charCommand = "let \(entities[index].name)[\(i)]:Character = \"\(aChar)\""
                    print("creating an entity for : \(charCommand)")
                    if i == 0 {
                        let memoryAddressBitString = Compiler.entityCount.eightBitRepresentation
                        entities[index].setBitString(newBitString: memoryAddressBitString)
                    }
                    if let newEntity = Entity(lineOfCode: charCommand) {
                        entities.append(newEntity)
                        Compiler.entityCount += 1
                    }
                }
            }
        }
    }
    
    var description: String {
        var stringRepresentation = "---------------- BEGIN Description of Compiler ------------------\n"
        for anEntity in entities {
            stringRepresentation += anEntity.description + "\n"
        }
        stringRepresentation += "---------------- END Description of Compiler --------------\n"
        return stringRepresentation
    }
}
