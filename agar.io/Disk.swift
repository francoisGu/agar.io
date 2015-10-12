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
    var radius : CGFloat {
        didSet {
            self.path = Disk.path(self.radius)
            self.lineWidth = radius/8
            self.setPhysicsBody()
        }
    }
    
    //Initiate class
    init(radius : CGFloat, position : CGPoint){0
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
        radius = 0
        super.init()
    }    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPhysicsBody(){
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.radius)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.friction = 1.0
        self.physicsBody!.usesPreciseCollisionDetection = true
        self.physicsBody!.dynamic = true
    }
    
    class func path(radius: CGFloat) -> CGMutablePathRef {
        let path: CGMutablePathRef = CGPathCreateMutable()
        CGPathAddArc(path, nil, 0.0, 0.0, radius, 0.0, CGFloat(Float(M_PI) * 2.0), true)
        return path
    }
    
   /*--------------------------------------------------------------------------------------*/
    // Get a random color
    class func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }

    /*-----------------------------------------------------------------------------------*/

}

