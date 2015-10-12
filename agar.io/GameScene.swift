//
//  GameScene.swift
//  agar.io
//
//  Created by F on 12/10/2015.
//  Copyright (c) 2015 UniMelb. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    //logic attributes
    let player = Player(playerName: "")
    let foodController = FoodController()
    let viruseController = ViruseController()
    
    //camerate related
    let camer:SKCameraNode = SKCameraNode()
    /*-----------------------------------------------------------------*/
    //Override function
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
        //setups
        setupAudio()
        setupCamera()
        setupPlayer()
        setupMod()
    }
    
    override func update(currentTime: CFTimeInterval) {
        camer.position = player.centralCell.position
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        player.lastTouch = touch.locationInNode(self)
        //player.touchOn = true
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in (touches ) {
            player.lastTouch = touch.locationInNode(self)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //player.touchOn = false
    }
    /*-----------------------------------------------------------------*/
    func setupCamera(){
        //camera related
        self.addChild(camer)
        self.camera = camer
        
        //var text = "position: \(camer.position.x) + \(camer.position.y))\n scale(\(camer.xScale),\(camer.yScale))"
        camer.position = player.centralCell.position
        camer.xScale = 1.0
        camer.yScale = 1.0
    }
    
    func setupPlayer(){
        for cell in player.cellsList{
            cell.position = self.getRandomPosition()
            self.addChild(cell)
        }
    }
    
    func setupMod(){
        //foodController
        //ViruseController
    }
    
    func setupAudio(){
    }
    
    func getRandomPosition()->CGPoint{
        return CGPoint(
            x: Int(arc4random_uniform(UInt32(CGRectGetWidth(self.frame)))),
            y: Int(arc4random_uniform(UInt32(CGRectGetHeight(self.frame))))
        )
    }
    /*-----------------------------------------------------------------*/
    func addSplitCellsToScene(){
        let splitCells = player.splitCells()
        for sCell in splitCells{
            self.addChild(sCell)
            sCell.eject()
        }
    }
    
    
    /*-----------------------------------------------------------------*/
    
}
