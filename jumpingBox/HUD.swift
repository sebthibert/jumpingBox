import SpriteKit

class HUD: SKNode {
  var textureAtlas = SKTextureAtlas(named:"HUD")
  let scoreLabel = SKLabelNode(text: "Score: ")
  let scoreCountText = SKLabelNode(text: "0")
  let pauseButton = SKSpriteNode()
  let playButton = SKSpriteNode()
  let pauseButtonPosition = CGPoint(x: 305, y: 155)
  let restartButton = SKSpriteNode()
  let restartLabel = SKLabelNode(text: "Restart")
  
  func createHudNodes(screenSize: CGSize) {
    playButton.isHidden = true
    pauseButton.texture = textureAtlas.textureNamed("pause")
    playButton.texture = textureAtlas.textureNamed("play")
    pauseButton.name = "pauseGame"
    playButton.name = "playGame"
    pauseButton.size = CGSize(width: 20, height: 25)
    playButton.size = CGSize(width: 25, height: 25)
    pauseButton.position = pauseButtonPosition
    playButton.position = pauseButtonPosition
    self.addChild(pauseButton)
    self.addChild(playButton)
    
    scoreLabel.fontName = font
    scoreLabel.fontSize = CGFloat(fontSizeSmall)
    scoreLabel.position = CGPoint(x: -330, y: 170)
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
    scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    scoreCountText.fontName = font
    scoreCountText.fontSize = CGFloat(fontSizeSmall)
    scoreCountText.position = CGPoint(x: scoreLabel.frame.maxX + 5, y: scoreLabel.frame.midY)
    scoreCountText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
    scoreCountText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    self.addChild(scoreLabel)
    self.addChild(scoreCountText)
    
    restartButton.texture = textureAtlas.textureNamed("button")
    restartButton.name = "restartGame"
    restartButton.size = CGSize(width: 200, height: 70)
    restartButton.color = .white
    restartButton.position = CGPoint(x: 0, y: 0)
    restartButton.zPosition = 4
    
    restartLabel.fontName = font
    restartLabel.fontSize = CGFloat(fontSizeMedium)
    restartLabel.verticalAlignmentMode = .center
    restartLabel.name = "restartGame"
    restartLabel.zPosition = 5
    restartButton.addChild(restartLabel)
  }
  
  func setScoreDisplay(newScore: Int) {
    let formatter = NumberFormatter()
    let number = NSNumber(value: newScore)
    if let scoreString = formatter.string(from: number) { scoreCountText.text = scoreString }
  }
  
  func showDeadNodes() {
    self.addChild(restartButton)
  }
}

