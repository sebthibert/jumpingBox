//
//  GameViewController.swift
//  jumpingBox
//
//  Created by Sebastien Thibert on 13/06/2017.
//  Copyright © 2017 Sebastien Thibert. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    let gameScene = GameScene()
    let skView = self.view as! SKView
    skView.ignoresSiblingOrder = true
    gameScene.size = view.bounds.size
    skView.presentScene(gameScene)
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .landscape
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
