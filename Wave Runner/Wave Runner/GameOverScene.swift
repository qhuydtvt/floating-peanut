//
//  GameOverScene.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/22/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    var gameOverLabel: SKLabelNode!
    var replayLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let labels = self.children.flatMap { $0 as? SKLabelNode }
        for label in labels {
            label.fontName = "Game Over Regular"
            if label.name == "GAME OVER" {
                label.fontSize = 300
                gameOverLabel = label
            } else {
                label.fontSize = 200
                replayLabel = label
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        if nodes(at: location).contains(replayLabel) {
            // new game
        }
    }
    
    static func present(with view: SKView) {
        let scene = SKScene(fileNamed: "GameOverScene")!
        // Set the scale mode to scale to fit the window
        if UIDevice.current.userInterfaceIdiom == .phone {
            let width = scene.size.width
            let height = width * 9 / 16
            scene.size = CGSize(width: width, height: height)
        }
        
        scene.scaleMode = .aspectFill
        
        // Present the scene
        view.presentScene(scene)
    }
}
