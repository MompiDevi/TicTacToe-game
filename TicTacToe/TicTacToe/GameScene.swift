//
//  GameScene.swift
//  TicTacToe
//
//  Created by N. Mompi Devi on 29/08/18.
//  Copyright © 2018 momiv. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var xos:[SKSpriteNode] = []
    var player = 0
    var cross:SKTexture?
    var nought:SKTexture?
    var restart:SKSpriteNode?
    var label:SKLabelNode?
    var gameOver = false
    var marked:[Int] = [0,0,0,0,0,0,0,0,0]
    var winningIndexes:[[Int]] = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    override func didMove(to view: SKView) {
        xos.append(self.childNode(withName: "1") as! SKSpriteNode)
        xos.append(self.childNode(withName: "2") as! SKSpriteNode)
        xos.append(self.childNode(withName: "3") as! SKSpriteNode)
        xos.append(self.childNode(withName: "4") as! SKSpriteNode)
        xos.append(self.childNode(withName: "5") as! SKSpriteNode)
        xos.append(self.childNode(withName: "6") as! SKSpriteNode)
        xos.append(self.childNode(withName: "7") as! SKSpriteNode)
        xos.append(self.childNode(withName: "8") as! SKSpriteNode)
        xos.append(self.childNode(withName: "9") as! SKSpriteNode)
        cross = SKTexture(imageNamed: "X")
        nought = SKTexture(imageNamed: "O")
        restart = self.childNode(withName: "restart") as? SKSpriteNode
        label = self.childNode(withName: "label") as? SKLabelNode
        restart?.alpha = 0
        label?.text = ""
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            for i in 0 ... xos.count-1{
                let location = touch.location(in: self)
                if(xos[i].contains(location) && gameOver == false){
                    if(marked[i] == 0){
                        if(player == 0){
                            xos[i].texture = cross
                            player = 1
                            marked[i] = 1
                        } else {
                            xos[i].texture = nought
                            player = 0
                            marked[i] = 1
                        }
                        for tempArr in winningIndexes {
                            if(xos[tempArr[0]].texture == cross && xos[tempArr[1]].texture == cross && xos[tempArr[2]].texture == cross){
                                label?.text = "Player 1 is the winner"
                                gameOver = true
                            }
                            if(xos[tempArr[0]].texture == nought && xos[tempArr[1]].texture == nought && xos[tempArr[2]].texture == nought){
                                label?.text = "Player 2 is the winner"
                                gameOver = true
                            }
                        }
                        if(i == 8 && gameOver != true){
                            label?.text = "Draw"
                            gameOver = true
                        }
                    }
                }
                if(gameOver){
                    restart?.alpha = 1
                    if(restart?.contains(location))!{
                        gameOver = false
                        restart?.alpha = 0
                        marked = [0,0,0,0,0,0,0,0,0]
                        for node in xos{
                            node.texture = nil
                            node.color = UIColor.white
                            label?.text = ""
                        }
                    }
                }
            }
        }
    }
    

    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
