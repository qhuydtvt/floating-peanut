//
//  EnemyControllerGenerator.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit
import SwiftyJSON

class EnemyControllerGenerator {
    
    var enemyDataList : [EnemyData] = []
    var enemyCurrentIndex = 0
    var lastTimeGenerate : Double = -1
    
    init(jsonFile: String) {
        if let path = Bundle.main.path(forResource: jsonFile, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let json = JSON.init(data: data)
                for jsonItem in json.array! {
                    let time = jsonItem["time"].double!
                    let type = jsonItem["type"].int!
                    self.enemyDataList.append(EnemyData(time: time, type: type))
                }
            }
        }
    }
    
    func run(parent: SKNode, time: TimeInterval) -> Void {
        if lastTimeGenerate == -1 {
            lastTimeGenerate = time
            return
        }
        
        let delta = time - lastTimeGenerate
        if (enemyCurrentIndex < enemyDataList.count) {
            
            let enemyData = enemyDataList[enemyCurrentIndex]
            if delta >= enemyData.time {
                let enemyController = EnemyController.create(type: enemyData.type)
                let enemyPosition = CGPoint(x: parent.frame.size.width, y: parent.frame.size.height / 2 + 20)
                enemyController.config(position: enemyPosition, parent: parent)
                enemyCurrentIndex += 1
            }
        }
    }
    
    func generate(time: TimeInterval) -> (EnemyController?, Int, Bool) {
        if lastTimeGenerate == -1 {
            lastTimeGenerate = time
            return (nil, 0, false)
        }
        
        let delta = time - lastTimeGenerate
        if (enemyCurrentIndex < enemyDataList.count) {
            
            let enemyData = enemyDataList[enemyCurrentIndex]
            if delta >= enemyData.time {
                enemyCurrentIndex += 1
                return (EnemyController.create(type: enemyData.type), enemyData.type, false)
            }
        } else {
            return (nil, 0, true)
        }
        
        return (nil, 0, false)
    }
}

struct EnemyData {
    let time: TimeInterval
    let type: Int
}
