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
  var lila: SKSpriteNode?
  var selected: Bool = false
  
  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: size.width / 2, y: size.height / 2)
    background.size = frame.size
    background.zPosition = -1
    addChild(background)
    
    let lila = SKSpriteNode(imageNamed: "lila-on-land")
    lila.position = CGPoint(x: 0.52, y: 0.6)
    lila.size = CGSize(width: 0.15, height: 0.15)
    lila.zPosition = 1
    addChild(lila)
    self.lila = lila
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let lila = self.lila, let touch = touches.first else { return }
    let location = touch.location(in: self)
    if lila.contains(location) {
      selected = true
    }
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !selected { return }
    guard let lila = self.lila, let touch = touches.first else { return }
    let location = touch.location(in: self)
    lila.position = location
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    selected = false
  }

  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    touchesEnded(touches, with: event)
  }
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
