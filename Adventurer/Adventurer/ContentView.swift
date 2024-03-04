//
//  ContentView.swift
//  Adventurer
//
//  Created by Geoffrey Irving on 3/3/24.
//

import SwiftUI
import SpriteKit

// Useful example: https://www.hackingwithswift.com/quick-start/swiftui/how-to-integrate-spritekit-using-spriteview

class GameScene: SKScene {
  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: size.width / 2, y: size.height / 2)
    background.size = frame.size
    background.zPosition = -1
    addChild(background)
  }

  //override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  //}
}

struct ContentView: View {
  var scene: SKScene {
    let scene = GameScene()
    scene.scaleMode = .aspectFit
    return scene
  }
  var body: some View {
    SpriteView(scene: scene)
      .ignoresSafeArea()
    .padding()
  }
}

#Preview {
  ContentView()
}
