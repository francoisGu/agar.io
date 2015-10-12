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
    var player = Player(playerName: "Player")
    var modController = ModController()
    
    //camerate related
    let camer:SKCameraNode = SKCameraNode()
    let hudSubView = SKView()
    let hudScene = HUDScene(size: CGSizeMake(1024, 768))
    var bgm:SKAudioNode = SKAudioNode()
    /*-----------------------------------------------------------------*/
    //Override function
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
        //setups
        setupAudio()
        setupCamera()
        setupPlayer()
        setupMod()
        //setupHUD(view)
    }
    
    override func update(currentTime: CFTimeInterval) {
        camer.position = player.centralCell.position
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        player.lastTouch = touch.locationInNode(self)
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
        modController.setupFrameSize(UInt32(self.frame.width), height: UInt32(self.frame.height))
        let initFoods = modController.createFoodsForInit()
        let initViruse = modController.createViruseForInit()
        for food in initFoods{
            self.addChild(food)
        }
        for viruse in initViruse{
            self.addChild(viruse)
        }
    }
    
    func setupAudio(){
        //audio
        let n = Int(arc4random_uniform(2))
        switch n{
        case 0:
            bgm = SKAudioNode(fileNamed: "mario.mp3")
        case 1:
            bgm = SKAudioNode(fileNamed: "underworld.mp3")
        default:
            bgm = SKAudioNode(fileNamed: "mario.mp3")
        }
        
        bgm.autoplayLooped = true
        self.addChild(bgm)
    }
    
    func setupHUD(view: SKView){
        //HUD sub View
        hudSubView.ignoresSiblingOrder = true
        hudSubView.backgroundColor = SKColor(red: 0.0, green: 0, blue: 0, alpha: 0.0)
        hudSubView.frame = CGRect(x: 0,y:0,width: 1024, height: 768)  //dont know why is this
        
        //HUD scene
        hudScene.scaleMode = .AspectFit
        hudScene.backgroundColor = SKColor(red: 0, green: 0, blue: 0.0, alpha: 0.0)
        //hudScene.s
        view.addSubview(hudSubView)
        hudSubView.presentScene(hudScene)
        
        hudScene.setDebugText(
            " hud scene (\(hudScene.size.width), \(hudScene.size.height))," +
            " sub view (\(hudSubView.frame.width) ,\(hudSubView.frame.height))")
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
        }
    }
    
    
    /*-----------------------------------------------------------------*/
    
}
