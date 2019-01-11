//
//  GearUtilities.swift
//  Book_Sources
//
//  Created by WILLIAM CHAPMAN on 1/9/19.
//

import Foundation
import UIKit

public class GearUtilities {
    
    // set up a texture for the gears
    static var animatedGearFrame = CGRect(x: 0.0, y: 0.0, width: 374.0, height: 670.0)
    
    static let gearTexture = UIImage(named: "steampunk.geartexture.withgears.jpg")
    static let gearTextureColor = UIColor(patternImage: gearTexture!)
    public static var backAnimatedGearView = MAAnimatedMultiGearView(frame: animatedGearFrame)
    public static var middleAnimatedGearView = MAAnimatedMultiGearView(frame: animatedGearFrame)
    public static var frontAnimatedGearView = MAAnimatedMultiGearView(frame: animatedGearFrame)
    
    
    
    public static func setUpGears(inView view:UIView) {
        
        // set up a texture for the gears
        animatedGearFrame = CGRect(x: -316.0, y: 100.0, width: view.frame.size.width, height: view.frame.size.height)
        
        backAnimatedGearView = MAAnimatedMultiGearView(frame: animatedGearFrame)
        middleAnimatedGearView = MAAnimatedMultiGearView(frame: animatedGearFrame)
        frontAnimatedGearView = MAAnimatedMultiGearView(frame: animatedGearFrame)
        
        //  create a interstitial black, semi-transarant view to make each layer of gears seem farther away
        
        let blackView = UIView()
        let blackView01 = UIView()
        let blackView02 = UIView()
        let backgroundImageViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        
        blackView.frame = backgroundImageViewFrame
        blackView.backgroundColor = .black
        blackView.alpha = 0.8
        
        blackView01.frame = backgroundImageViewFrame
        blackView01.backgroundColor = .black
        blackView01.alpha = 0.4
        
        blackView02.frame = backgroundImageViewFrame
        blackView02.backgroundColor = .black
        blackView02.alpha = 0.0
        
        
        backAnimatedGearView.backgroundColor = .clear
        backAnimatedGearView.showBars = false
        
        view.addSubview(blackView)
        
        
        // 0
        _ = backAnimatedGearView.addInitialGear(nbTeeth: 18, color: gearTextureColor, radius: 24.0)
        // 1
        _ = backAnimatedGearView.addLinkedGear(0, nbTeeth: 18, color:gearTextureColor,angleInDegree: 135.0, gearStyle:MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 3)
        // 2
        _ = backAnimatedGearView.addLinkedGear(1, nbTeeth: 48, color: gearTextureColor, angleInDegree: 90.0,gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 6)
        // 3
        _ = backAnimatedGearView.addLinkedGear(2, nbTeeth: 18, color: gearTextureColor, angleInDegree: -30.0)
        // 4
        _ = backAnimatedGearView.addLinkedGear(2, nbTeeth: 18, color: gearTextureColor, angleInDegree: 90.0)
        // 5
        _ = backAnimatedGearView.addLinkedGear(2, nbTeeth: 36, color: gearTextureColor, angleInDegree: 165.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 6)
        // 6
        _ = backAnimatedGearView.addLinkedGear(3, nbTeeth: 18, color: gearTextureColor, angleInDegree: 30.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 6)
        // 7
        _ = backAnimatedGearView.addLinkedGear(6, nbTeeth: 9, color: gearTextureColor, angleInDegree: 90.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        // 8
        _ = backAnimatedGearView.addLinkedGear(2, nbTeeth: 9, color: gearTextureColor, angleInDegree: 30.0)
        // 9
        _ = backAnimatedGearView.addLinkedGear(5, nbTeeth: 9, color: gearTextureColor, angleInDegree: 60.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        // 10
        _ = backAnimatedGearView.addLinkedGear(4, nbTeeth: 9, color: gearTextureColor, angleInDegree: 200.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        
        view.addSubview(backAnimatedGearView)
        backAnimatedGearView.addSubview(blackView01)
        
        // backAnimatedGearView.startRotating()
        
        middleAnimatedGearView.backgroundColor = .clear
        middleAnimatedGearView.showBars = false
        // 0
        _ = middleAnimatedGearView.addInitialGear(nbTeeth: 18, color: gearTextureColor, radius: 24.0)
        // 1
        _ = middleAnimatedGearView.addLinkedGear(0, nbTeeth: 24, color:gearTextureColor,angleInDegree: 30.0, gearStyle:MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 6)
        // 2
        _ = middleAnimatedGearView.addLinkedGear(0, nbTeeth: 48, color: gearTextureColor, angleInDegree: 150.0,gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 6)
        // 3
        _ = middleAnimatedGearView.addLinkedGear(1, nbTeeth: 18, color: gearTextureColor, angleInDegree: -30.0)
        // 4
        _ = middleAnimatedGearView.addLinkedGear(2, nbTeeth: 18, color: gearTextureColor, angleInDegree: 90.0)
        // 5
        _ = middleAnimatedGearView.addLinkedGear(3, nbTeeth: 36, color: gearTextureColor, angleInDegree: -30.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 6)
        
        // 6
        _ = middleAnimatedGearView.addLinkedGear(1, nbTeeth: 16, color: gearTextureColor, angleInDegree: 140.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 6)
        // 7
        _ = middleAnimatedGearView.addLinkedGear(2, nbTeeth: 18, color: gearTextureColor, angleInDegree: 210.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 6)
        // 8
        _ = middleAnimatedGearView.addLinkedGear(7, nbTeeth: 9, color: gearTextureColor, angleInDegree: 120.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        // 9
        _ = middleAnimatedGearView.addLinkedGear(2, nbTeeth: 18, color: gearTextureColor, angleInDegree: 90.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        // 10
        _ = middleAnimatedGearView.addLinkedGear(5, nbTeeth: 9, color: gearTextureColor, angleInDegree: 90.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        // 11
        _ = middleAnimatedGearView.addLinkedGear(4, nbTeeth: 9, color: gearTextureColor, angleInDegree: 200.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        // 12
        _ = middleAnimatedGearView.addLinkedGear(2, nbTeeth: 17, color: gearTextureColor, angleInDegree: 145.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 17)
        // 13
        _ = middleAnimatedGearView.addLinkedGear(0, nbTeeth: 16, color: gearTextureColor, angleInDegree: -60.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 16)
        
        view.addSubview(middleAnimatedGearView)
        view.addSubview(blackView02)
        
        //  middleAnimatedGearView.startRotating()
        
        
        frontAnimatedGearView.backgroundColor = .clear
        frontAnimatedGearView.showBars = false
        // 0
        _ = frontAnimatedGearView.addInitialGear(nbTeeth: 18, color: gearTextureColor, radius: 24.0)
        // 1
        _ = frontAnimatedGearView.addLinkedGear(0, nbTeeth: 72, color:gearTextureColor,angleInDegree: 210.0, gearStyle:MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 36)
        // 2
        _ = frontAnimatedGearView.addLinkedGear(1, nbTeeth: 54, color: gearTextureColor, angleInDegree: -30.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        // 3
        _ = frontAnimatedGearView.addLinkedGear(2, nbTeeth: 40, color: gearTextureColor, angleInDegree: 0.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        // 4
        _ = frontAnimatedGearView.addLinkedGear(2, nbTeeth: 27, color: gearTextureColor, angleInDegree: 240.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        // 5
        _ = frontAnimatedGearView.addLinkedGear(2, nbTeeth: 27, color: gearTextureColor, angleInDegree: 72.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        // 6
        _ = frontAnimatedGearView.addLinkedGear(4, nbTeeth: 48, color: gearTextureColor, angleInDegree: 180.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        // 7
        _ = frontAnimatedGearView.addLinkedGear(4, nbTeeth: 36, color: gearTextureColor, angleInDegree: 338.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 18)
        // 8
        _ = frontAnimatedGearView.addLinkedGear(7, nbTeeth: 9, color: gearTextureColor, angleInDegree:0.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 9)
        // 9
        _ = frontAnimatedGearView.addLinkedGear(8, nbTeeth: 18, color: gearTextureColor, angleInDegree:60.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 18)
        // 10
        _ = frontAnimatedGearView.addLinkedGear(9, nbTeeth: 12, color: gearTextureColor, angleInDegree:330.0, gearStyle: MASingleGearView.MAGearStyle.WithBranchs, nbBranches: 3)
        
        view.addSubview(frontAnimatedGearView)
        //  frontAnimatedGearView.startRotating()
        
    }
    
}
