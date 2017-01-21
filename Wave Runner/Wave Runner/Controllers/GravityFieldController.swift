//
//  GravityFieldController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

class GravityFieldController {
    var gravityNode: SKFieldNode!
    var parent: SKNode!
    
    init() {
        gravityNode = SKFieldNode.radialGravityField()
        gravityNode.categoryBitMask = 1
        gravityNode.strength = 10
        gravityNode.falloff = 1
    }
    
    func config(position: CGPoint, parent: SKNode) {
        gravityNode.position = position
        self.parent = parent
        parent.addChild(gravityNode)
        
//        gravityNode.region = SKRegion(radius: 400)
    }
}
