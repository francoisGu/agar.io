//
//  Disk.swift
//  agar.io
//
//  Created by F on 12/10/2015.
//  Copyright © 2015 UniMelb. All rights reserved.
//

//
//  Disk.swift
//  agar.io
//
//  Created by F on 2/10/2015.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import SpriteKit
import Foundation

class Disk : SKShapeNode{
    //collision related
    
    static let ejectSpeed : CGFloat = 100
    var ejectSec : Int16
    //var ejectDirect: CGVector?
    
    var radius : CGFloat {
        didSet {
            self.path = Disk.path(self.radius)
            self.lineWidth = radius/8
            self.setPhysicsBody()
        }
    }
    //var speed : CGFloat
    
    //Initiate class
    init(radius : CGFloat, position : CGPoint){
        self.ejectSec = 0
        self.radius = radius
        super.init()
        self.path = Disk.path(self.radius)
        self.position = position
        self.lineWidth = radius/8
        self.strokeColor = Disk.getRandomColor()
        self.fillColor = Disk.getRandomColor()
        self.zPosition = 5
        self.setPhysicsBody()
    }
    
    
    //Init for copy?
    override init(){
        ejectSec = 0
        radius = 0
        super.init()
    }    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPhysicsBody(){
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.radius)
        self.physicsBody!.affectedByGravity = false
        //self.physicsBody!.mass = 1.0
        self.physicsBody!.friction = 1.0
        
        self.physicsBody!.usesPreciseCollisionDetection = true
        self.physicsBody!.dynamic = true  //false: engine handle moving, true: dev handle moving
    }
    
    class func path(radius: CGFloat) -> CGMutablePathRef {
        let path: CGMutablePathRef = CGPathCreateMutable()
        CGPathAddArc(path, nil, 0.0, 0.0, radius, 0.0, CGFloat(Float(M_PI) * 2.0), true)
        return path
    }
    
   /*--------------------------------------------------------------------------------------*/
    class func speedVector(vector : CGVector, maxSpeed : CGFloat) -> CGVector{
        let scale = Disk.scaleOfVector(CGVectorMake(maxSpeed, 0), vectorB: vector)
        if(scale > 1) {
            return vector
        }
        return CGVectorMake(
            vector.dx * scale,
            vector.dy * scale)
    }
    
    class func scaleOfVector(vectorA: CGVector, vectorB: CGVector)-> CGFloat{
        let lengthA = sqrt(vectorA.dx * vectorA.dx + vectorA.dy * vectorA.dy)
        let lengthB = sqrt(vectorB.dx * vectorB.dx + vectorB.dy * vectorB.dy)
        return lengthA/lengthB
    }
    
    
    class func scaleVectorWithLength(length: CGFloat, vector: CGVector) ->CGFloat {
        let lengthVector = sqrt(vector.dx * vector.dx + vector.dy * vector.dy)
        return length/lengthVector
    }
    
    func getHalfSizeRadius()->CGFloat{
        return sqrt(self.radius*self.radius/2)
    }
    
    // Get a random color
    class func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    //Get the add position for split disks
    //The new postion should be like:
    //parent position + radius + moveDistance
    func getNewPositionForSplitDisk() -> CGPoint{
        let direction = self.physicsBody?.velocity
        let scale = Disk.scaleOfVector(CGVectorMake(self.radius, 0), vectorB: direction!)
        let splitX = self.position.x + (direction?.dx)!*scale + (direction?.dx)!*0.5
        let splitY = self.position.y + (direction?.dy)!*scale + (direction?.dy)!*0.5
        return CGPointMake(splitX, splitY)
    }
    
    /*--------------------------------------------------------------------------------------*/
    // Disk absorb another disk
    func absorb(disk : Disk){
        
    }
    
    // Disk split to a new disk
    func eject(){
        self.ejectSec = 5
        let direction = self.physicsBody!.velocity
        let scale = Disk.scaleVectorWithLength(Disk.ejectSpeed, vector: direction)
        let speedVector = CGVectorMake(direction.dx * scale, direction.dy * scale)
        //self.physicsBody!.applyForce(speedVector)
        print("Eject " + String(speedVector))
        self.physicsBody?.applyForce(speedVector)
    }
    /*-----------------------------------------------------------------------------------*/    
    
    /*
    disk.position = CGPointMake(self.frame.size.Width/4, self.frame.size.height/4)
    */
}

