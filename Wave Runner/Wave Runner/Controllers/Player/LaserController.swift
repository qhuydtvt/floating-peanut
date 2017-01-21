//
//  LaserController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

enum LaserType {
    case straight, upward, downward
}

class LaserSkill {
    var coolDownTime: Int = 1
    var isCoolingDown = false
    
    
}

class LaserController: SingleControler {
    var type: LaserType!
    var cropNode: SKCropNode!
    var laser: View!
    
    init(type: LaserType) {
        super.init(view: View())
        self.type = type
        self.laser = View(image: #imageLiteral(resourceName: "laser"))
        self.cropNode = SKCropNode()
        cropNode.maskNode = SKSpriteNode(image: #imageLiteral(resourceName: "laser"))
        cropNode.addChild(laser)
        view.addChild(cropNode)
        
        laser.position = CGPoint(x: -laser.width, y: 0)
        
        if type == .upward {
            view.zRotation = view.zRotation + CGFloat.pi / 6
        }
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
    }
    
    func move(speed: CGFloat) {
        let distance = laser.width
        let time = distance / speed
        laser.run(.move(by: CGVector(dx: distance, dy: 0), duration: TimeInterval(time))) { [unowned self] in
            self.laser.run(.fadeAlpha(to: 0, duration: 0.15)) {
                self.view.removeFromParent()
            }
        }
    }
}
