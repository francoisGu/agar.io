//
//  Cell.swift
//  agar.io
//
//  Created by F on 2/10/2015.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import Foundation
import SpriteKit

class Cell: Disk {
    var id = 0
    let cellStartRadius : CGFloat = 20
    var cellMaxSpeed : CGFloat = 50
    var label : SKLabelNode
   /*--------------------------------------------------------------------------------------*/
    //New user
    init(userName : String, location : CGPoint){
        //self.cellMaxSpeed = cellStartRadius
        label = SKLabelNode(fontNamed: "ArialMR")
        super.init(radius: cellStartRadius, position : location)
        self.setCellLabel(userName)
        self.addChild(label)
    }
    
    //Init for copy?
    override init(){
        self.id = id*2
        //self.cellMaxSpeed = cellStartRadius
        self.label = SKLabelNode(fontNamed: "ArialMR")
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   /*--------------------------------------------------------------------------------------*/
    //function for copy cell
    func copyCell() -> Cell {
        let newCell: Cell = self.copy() as! Cell
        newCell.radius = self.radius
        newCell.ejectSec = self.ejectSec
        newCell.cellMaxSpeed = self.cellMaxSpeed
        newCell.position = self.getNewPositionForSplitDisk()
        return newCell
    }
    
    private func setCellLabel(userName : String){
        label.text = userName
        label.fontSize = self.frame.size.height / 5
        label.fontColor = SKColor.whiteColor()
        label.zPosition = self.zPosition + 1
    }
    
    override func setPhysicsBody(){
        super.setPhysicsBody()
    }
    /*--------------------------------------------------------------------------------------*/
    //User move the cell
    func move(){
    }
    
    func setSpeedDirection(direction: CGPoint){
    }
    
    func split(){
    }
    
    func ejectMass(){
        
    }
    
}