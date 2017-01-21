//
//  LightController.swift
//  Wave Runner
//
//  Created by Apple on 1/22/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit
import SwiftyJSON

class LightController: Controller {
    
    var lightItems : [LightItem] = []
    var currentLightItemIndex = 0
    weak var lightNode: SKLightNode?
    
    init(jsonFile: String) {
        super.init()
        if let path = Bundle.main.path(forResource: jsonFile, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let json = JSON.init(data: data)
                for item in json.array! {
                    let time = item["time"].double!
                    let light = item["light"].bool!
                    let lightItem = LightItem(time: time, light: light)
                    self.lightItems.append(lightItem)
                }
            }
        }
    }
    
    var lastTimeUpdate: TimeInterval = -1
    
    override func run(parent: SKNode, time: TimeInterval) {
        super.run(parent: parent, time: time)
        if lastTimeUpdate == -1 {
            lastTimeUpdate = time
        }
        let delta = time - lastTimeUpdate
        if currentLightItemIndex < self.lightItems.count {
            let lightItem = self.lightItems[self.currentLightItemIndex]
            if delta > lightItem.time {
                currentLightItemIndex += 1
                let light = lightItem.light
                lightNode?.isEnabled = !light
            }
        }
    }
}

struct LightItem {
    let time: TimeInterval
    let light: Bool
}
