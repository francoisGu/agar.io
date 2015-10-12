//
//  FoodController.swift
//  agar.io
//
//  Created by F on 12/10/2015.
//  Copyright © 2015 UniMelb. All rights reserved.
//

import Foundation
import SpriteKit

class ModController {
    let initFoodNum = 15
    let initViruseNum = 1
    var frameWidth: UInt32?
    var frameHeight: UInt32?
    var foodsList: [Food]
    var viruseList: [Viruse]
    
    init(){
        foodsList = []
        viruseList = []
    }
    
    func createFoodsForInit()->[Food]{
        var appendList : [Food] = []
        for _ in 0...initFoodNum{
            appendList.append(createFood())
        }
        return appendList
    }
    
    func createViruseForInit()->[Viruse]{
        var appendList : [Viruse] = []
        for _ in 0...initViruseNum{
            appendList.append(createViruse())
        }
        return appendList
    }
    
    func getRandomPosition() ->CGPoint{
        return CGPoint(
            x: Int(arc4random_uniform(frameWidth!)),
            y: Int(arc4random_uniform(frameHeight!))
        )
    }
    
    func setupFrameSize(width: UInt32, height: UInt32 ){
        self.frameWidth = width
        self.frameHeight = height
    }
    
    func createFood()->Food{
        let newFood = Food(position: getRandomPosition())
        foodsList.append(newFood)
        return newFood
    }
    
    func createViruse() ->Viruse{
        let newViruse = Viruse(radius: 40, position: getRandomPosition())
        viruseList.append(newViruse)
        return newViruse
    }
}