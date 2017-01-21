//
//  Constants.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

let PLAYER_SCALE : CGFloat = 3

let PLAYER_ANIMATION_TIME_FER_FRAME : Double = 0.15

struct Masks {
    static let PLAYER          =   UInt32(1 << 0)
    static let PLAYER_WAVE     =   UInt32(1 << 1)
    
    static let ENEMY           =   UInt32(1 << 2)
    static let ENEMY_WAVE      =   UInt32(1 << 3)
    
    static let PLATFORM        =   UInt32(1 << 4)
    static let LASER           =   UInt32(1 << 5)
}

struct Speed {
    static let PLATFORM_SPEED : CGFloat = 5
    static let ENEMY_VELOCITY : CGFloat = PLATFORM_SPEED * 60
}

enum Element {
    case wind, water, thunder, light
}

struct Textures {
    static let arc = SKTexture(image: #imageLiteral(resourceName: "arc_right"))
    static let missle_small = SKTexture(image: #imageLiteral(resourceName: "missle_small"))
    static let laserStraightAnimation = SKTextureAtlas(named: "goku_laser_straight").toTextures()
    static let laserUpwardAnimation = SKTextureAtlas(named: "goku_laser_upward").toTextures()
    static let attackAnimation = SKTextureAtlas(named: "goku_attack").toTextures()
}

struct CoolDown {
    static let SONIC: Double = 1
    static let LASER: Double = 1
    static let PUSH: Double = 3
    static let PULL: Double = 3
}
