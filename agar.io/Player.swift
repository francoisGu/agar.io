//
//  Player.swift
//  agar.io
//
//  Created by F on 12/10/2015.
//  Copyright © 2015 UniMelb. All rights reserved.
//
import Foundation
import SpriteKit

class Player{
    var playerName : String
    var centralCell : Cell
    var cellsList : [Cell]
    var foodEaten : Int
    var highestMass : CGFloat
    var startTime : Double
    var cellsEaten : Int
    var lastTouch: CGPoint?{
        didSet{
            for cell in cellsList{
                cell.move(lastTouch!)
            }
        }
    }
    //leaderboard time
    
    init(playerName : String){
        self.playerName = playerName
        self.cellsList = [Cell]()
        self.foodEaten = 0
        self.highestMass = 0
        self.cellsEaten = 0
        self.startTime = NSDate().timeIntervalSince1970
        self.centralCell = Cell(userName: playerName, location: CGPointZero)
        cellsList.append(centralCell)
    }
    
    //return the central cell in the screen
    func getCentralCell()->Cell{
        return centralCell
    }
    
    //return cells list
    func getCellsList()->[Cell]{
        return cellsList
    }
    
    //User do action to split cells
    //Each cell exist could split to 2 same size cells
    func splitCells()->[Cell]{
        let splitCells:[Cell] = [Cell]()
        if(cellsList.count >= 2){
            return splitCells
        }
        for cell in cellsList {
            cell.split()
        }
        return splitCells
    }
    
    func ejectMass(){
        
    }
}