//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  An auxiliary source file which is part of the book-level auxiliary sources.
//  Provides the implementation of the "always-on" live view.
//

import UIKit
import PlaygroundSupport
import AVFoundation


@objc(Book_Sources_LiveViewController)
public class LiveViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    @IBOutlet weak var codeSourceLabel: UILabel!
    @IBOutlet weak var diagLabel: UILabel!
    @IBOutlet weak var gearView: UIView!
    
    @IBOutlet weak var constantLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var binaryLabel: UILabel!
    
    var numberOfLights = 8
    var darkLights = [UIImageView]()
    var lightLights = [UIImageView]()
    
    var numberOfBanksOfMemory = 6
    var memoryBankInUse = 0
    var bitString = [Bool]()

    var valueLabels = [UILabel]()
    var typeLabels = [UILabel]()
    var nameLabels = [UILabel]()
    
    let lightOn = UIImage(named: "steampunk.light.lighted.png")
    let lightOff = UIImage(named: "steampunk.light.notlighted.png")
    
    var entityCounter = 0
    
    var gearLayerCounter = 0
    var bigTimer: Timer?
    
    let soundPlayer = AVQueuePlayer()
    
    var diagText = "" {
        didSet {
            diagLabel.text = diagText
        }
    }
    
    public override func viewDidLoad() {
        print("inside LiveViewController ... viewDidLoad")
        GearUtilities.setUpGears(inView: gearView)
        setUpAllBanks()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .orange
    }
    /*
    public func liveViewMessageConnectionOpened() {
        // Implement this method to be notified when the live view message connection is opened.
        // The connection will be opened when the process running Contents.swift starts running and listening for messages.
    }
    */
    
    /*
    public func liveViewMessageConnectionClosed() {
        // Implement this method to be notified when the live view message connection is closed.
        // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
        // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
    }
    */
    
    public func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
        
        if case let .string(text) = message {
            //  eventually set up a UILabel to display the message that got sent, but for now,
            //  let's just change the background color
            self.view.backgroundColor = .yellow
            self.codeSourceLabel.text = text
            
            process(code: text)
        }
    }
    
    func string2BitString(string: String) -> [Bool] {
//        var bitString = [Bool]()
//        for aChar in string {
//            bitString.append = (aChar == "1")
//        }
//        return bitString
        
        return string.map { $0 == "1" }
    }
    
    private func process(code: String) {
        diagText = ""
        diagText += "inside process(code:)\n"
        
        memoryBankInUse = 0
        entityCounter = 0
        
        var codeHelper = UserCodeHelper()
        var codeCompiler = Compiler()
        
        codeHelper.setUserCode(newCode: code)
        // diagText += "inside \(codeHelper.allText)\n"

        let individualLines = codeHelper.linesInUserCode()
        // diagText += "individualLines = \(individualLines)\n"
        
        let arrayOfUserCode = codeHelper.findUserCodeInputs()
        // diagText += "inside arrayOfUserCode = \(arrayOfUserCode); count = \(arrayOfUserCode.count)\n"

        let arrayOfUserVarsAndLets = codeHelper.findUserVarLet()
        // diagText += "inside array = \(arrayOfUserVarsAndLets); count = \(arrayOfUserVarsAndLets.count)\n"

        codeCompiler.parse(linesOfCode: arrayOfUserVarsAndLets)

        diagText += codeCompiler.description
        
//        for line in arrayOfUserVarsAndLets {
//            sleep(5)
////            if  line.hasSuffix("let ") ||
////                line.hasSuffix("var ") {
////                //  this line of code is either a var or let
////                //  create an instance of Entity
//            self.diagText += "Creating an entity from:" + line + "\n"
//            if let entity = Entity(lineOfCode: line) {
//                //  successfully created an entity from the code
//                //  the user entered
//                self.diagText += entity.description
//                constantLabel.text = (entity.isConstant) ? "CONSTANT" :
//                "VARIABLE"
//                nameLabel.text = entity.name
//                valueLabel.text = "\(entity.value)"
//            }
//
//            //  BILL : add these entities to an array to be the model
//            //  for the visualization
//
//            self.diagText += "Why is this done? \n"
//        }
        
        animateGears()
 
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            if self.entityCounter <= self.numberOfBanksOfMemory - 1 {
                let anEntity = codeCompiler.entities[self.entityCounter]
                self.constantLabel.text = (anEntity.isConstant) ? "CONSTANT" :
                "VARIABLE"
                self.nameLabel.text = anEntity.name
                self.valueLabel.text = "\(anEntity.value)"
                self.binaryLabel.text = anEntity.bitString
                
                self.memoryBankInUse = self.entityCounter
                self.bitString = self.string2BitString(string: anEntity.bitString)
                self.updateLights()
                self.updateLabels(withEntity: anEntity)
                
                self.entityCounter += 1
                if self.entityCounter == codeCompiler.entities.count { self.entityCounter = 0 }
            }
        }
        
//        for anEntity in codeCompiler.entities {
//            // sleep(5)
//            //            if  line.hasSuffix("let ") ||
//            //                line.hasSuffix("var ") {
//            //                //  this line of code is either a var or let
//            //                //  create an instance of Entity
//
//            //  successfully created an entity from the code
//            //  the user entered
//            self.diagText += anEntity.description
//            constantLabel.text = (anEntity.isConstant) ? "CONSTANT" :
//            "VARIABLE"
//            nameLabel.text = anEntity.name
//            valueLabel.text = "\(anEntity.value)"
//            binaryLabel.text = anEntity.bitString
//        }
        
        //  BILL : add these entities to an array to be the model
        //  for the visualization
        
        self.diagText += "Why is this done? \n"
    }
    
    private func animateGearHelper() {
        if gearLayerCounter == 0 {
            GearUtilities.backAnimatedGearView.startRotating()
        } else if gearLayerCounter == 1 {
            GearUtilities.middleAnimatedGearView.startRotating()
        } else if gearLayerCounter == 2 {
            GearUtilities.frontAnimatedGearView.startRotating()
        } else {
            GearUtilities.backAnimatedGearView.stopRotating()
            GearUtilities.middleAnimatedGearView.stopRotating()
            GearUtilities.frontAnimatedGearView.stopRotating()
            bigTimer?.invalidate()
        }
        gearLayerCounter += 1
        if gearLayerCounter >= 4 {
            gearLayerCounter = 0
            bigTimer?.invalidate()
        }
    }
    
    private func playGearSound() {
        //  setup sound player
        if let url = Bundle.main.url(forResource: "machine.gears.sound.trimmed", withExtension: "m4a") {
            soundPlayer.removeAllItems()
            soundPlayer.insert(AVPlayerItem(url: url), after: nil)
        }
        soundPlayer.play()
    }
    
    private func animateGears() {
        playGearSound()
        bigTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.animateGearHelper()
        }
    }
    
/***********************************************************************************************/
/*                                                                                             */
/*                   SET UP LIGHT BANKS                                                        */
/*                                                                                             */
/***********************************************************************************************/
    
    private func setUpAllBanks() {
        // set up all banks of lights

        let deltaY:CGFloat = CGFloat(view.frame.height) / CGFloat(numberOfBanksOfMemory)
        
        let newX:CGFloat = view.frame.width/2.0 - 278.0
        var newY:CGFloat = 0.5 * deltaY - 14.0
        
        for _ in 1 ... numberOfBanksOfMemory {
            setUpLights(startingX: newX, startingY: newY)
            newY += deltaY - 3.0
        }
        
        //  set up all banks of value and type labels
        let newValueX:CGFloat = view.frame.width/2.0 - 320.0

        var newValueY:CGFloat = 0.5 * deltaY - 14.0
        for _ in 1 ... numberOfBanksOfMemory {
            setUpValueAndTypeLabels(startingX: newValueX, startingY: newValueY)
            newValueY += deltaY - 3.0
        }
    }
    
    private func setUpValueAndTypeLabels(startingX:CGFloat, startingY:CGFloat) {
        
        //  valueLabel
        let valueLabelWidth:CGFloat = 64.0
        let valueLabelHeight:CGFloat = 64.0
        
        let aFrame = CGRect(x: startingX, y: startingY, width: valueLabelWidth, height: valueLabelHeight)
        let aValueLabel = UILabel(frame: aFrame)
        aValueLabel.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.5)
        aValueLabel.text = "888"
        aValueLabel.alpha = 0.7
        aValueLabel.textAlignment = .right
        aValueLabel.font = UIFont(name: "Helvetica", size: 40.0) // set fontName and Size
        aValueLabel.adjustsFontSizeToFitWidth = true
        aValueLabel.minimumScaleFactor = 0.1
        aValueLabel.textColor = .white
        aValueLabel.isHidden = true
        valueLabels.append(aValueLabel)
        view.addSubview(aValueLabel)
        
        //  typeLabel
        let typeFrame = CGRect(x: startingX + 135.0, y: startingY + 34.0, width: valueLabelWidth, height: valueLabelHeight)
        let aTypeLabel = UILabel(frame: typeFrame)
        aTypeLabel.text = "Integer"
        aTypeLabel.alpha = 0.7
        aTypeLabel.textAlignment = .right
        aTypeLabel.font = UIFont(name: "Helvetica", size: 14.0) // set fontName and Size
        aTypeLabel.adjustsFontSizeToFitWidth = true
        aTypeLabel.minimumScaleFactor = 0.1
        aTypeLabel.textColor = .white
        aTypeLabel.isHidden = true
        typeLabels.append(aTypeLabel)
        view.addSubview(aTypeLabel)
        
        //  variable name label
        
        let nameFrame = CGRect(x: startingX + 74.0, y: startingY - 42.0, width: valueLabelWidth, height: valueLabelHeight)
        let aNameLabel = UILabel(frame: nameFrame)
        aNameLabel.text = "x:"
        aNameLabel.alpha = 0.7
        aNameLabel.textAlignment = .left
        aNameLabel.font = UIFont(name: "Helvetica", size: 14.0) // set fontName and Size
        aNameLabel.adjustsFontSizeToFitWidth = true
        aNameLabel.minimumScaleFactor = 0.1
        aNameLabel.textColor = .white
        aNameLabel.isHidden = true
        nameLabels.append(aNameLabel)
        view.addSubview(aNameLabel)
    }
    
    
    private func setUpLights(startingX:CGFloat, startingY:CGFloat) {
        //  setup lights
        let numberOfLights = 8
        
        let lightDisplayWidth:CGFloat = 24.0
        let lightDisplayHeight:CGFloat = (lightDisplayWidth/49.0) * 138.0
        let paddingWidth:CGFloat = 5.0
        
        var xValue = startingX + 0.5*lightDisplayWidth
        let yValue = startingY
        
        for _ in 0 ..< numberOfLights {
            xValue = xValue + (lightDisplayWidth + paddingWidth)
            
            let aFrame = CGRect(x: xValue, y: yValue, width: lightDisplayWidth, height: lightDisplayHeight)
            let aLightImageView = UIImageView(image: lightOff)
            darkLights.append(aLightImageView)
            darkLights.last!.frame = aFrame
            view.addSubview(aLightImageView)
        }
        
        // add conduit for lights
        let conduitFrame = CGRect(x: startingX+lightDisplayWidth*1.5,
                                  y: startingY + lightDisplayHeight-7.0,
                                  width: (lightDisplayWidth+paddingWidth)*9.0,
                                  height: 7.0)
        let conduitImageView = UIImageView(image: UIImage(named: "steampunk.light.tube.png"))
        conduitImageView.frame = conduitFrame
        conduitImageView.alpha = 0.65
        view.addSubview(conduitImageView)
    }
    
    private func updateLights() {
        let startingLightIndex = memoryBankInUse*8
        for i in 0 ..< numberOfLights {
            //  BILL : This needs to be fixed up!!
            
            if bitString[i] {
                darkLights[i + startingLightIndex].image = lightOn
            } else {
                darkLights[i + startingLightIndex].image = lightOff
            }
        }
    }
    
    private func updateLabels(withEntity entity:Entity) {
        if memoryBankInUse <= 5 {
//            nameLabels[memoryBankInUse].isHidden = false
//            nameLabels[memoryBankInUse].text = entity.name
            
            var typeString = ""
            let nameString = entity.name + ":"
            var valueString = ""

            switch entity.value {
            case .int(let assocVal):
                typeString = "Integer"
                valueString = "\(assocVal)"
            case .double(let assocVal):
                typeString = "Double"
                valueString = "\(assocVal)"
            case .bool(let assocVal):
                typeString = "Boolean"
                valueString = "\(assocVal)"
            case .character(let assocVal):
                typeString = "Character"
                valueString = "\(assocVal)"
            case .string(let assocVal):
                typeString = "String"
                valueString = "\(assocVal)"
//            case .none:
//                typeString = ""
//                valueString = ""
            }

            valueLabels[memoryBankInUse].isHidden = false
            typeLabels[memoryBankInUse].isHidden = false
            nameLabels[memoryBankInUse].isHidden = false

            valueLabels[memoryBankInUse].text = valueString
            typeLabels[memoryBankInUse].text = typeString
            nameLabels[memoryBankInUse].text = nameString
            
        }
    }


//    private func process(code: String) {
//        diagText += "inside process(code:)\n" +  code
//        let lines = code.components(separatedBy: .newlines)
//
//        for line in lines {
//            if  line.hasSuffix("let ") ||
//                line.hasSuffix("var ") {
//                //  this line of code is either a var or let
//                //  create an instance of Entity
//                self.diagText += line + "\n"
//
//            }
//        }
//    }
}
