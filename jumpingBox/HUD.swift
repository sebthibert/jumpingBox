import SpriteKit

class HUD: SKNode {
  var textureAtlas = SKTextureAtlas(named:"HUD")
  let scoreLabel = SKLabelNode(text: "Score: ")
  let finalScoreLabel = SKLabelNode()
  let scoreCountText = SKLabelNode(text: "0")
  let highscoreLabel = SKLabelNode()
  let pauseButton = SKSpriteNode()
  let playButton = SKSpriteNode()
  let pauseButtonPosition = CGPoint(x: 335, y: 180)
  let scoreTable = Button()
  let restartButton = Button()
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
    scoreLabel.fontSize = fontSizeSmall
    scoreLabel.position = CGPoint(x: -355, y: 180)
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
    scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    scoreCountText.fontName = font
    scoreCountText.fontSize = fontSizeSmall
    scoreCountText.position = CGPoint(x: scoreLabel.frame.maxX + 5, y: scoreLabel.frame.midY)
    scoreCountText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
    scoreCountText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    self.addChild(scoreLabel)
    self.addChild(scoreCountText)
    
    scoreTable.size = CGSize(width: 450, height: 150)
    scoreTable.position = CGPoint(x: 0, y: 50)
    scoreTable.zPosition = 4
    
    restartButton.name = "restartGame"
    restartButton.size = CGSize(width: 200, height: 70)
    restartButton.position = CGPoint(x: 0, y: scoreTable.frame.minY - 50)
    restartButton.zPosition = 4
    
    restartLabel.fontName = font
    restartLabel.fontSize = fontSizeMedium
    restartLabel.verticalAlignmentMode = .center
    restartLabel.name = "restartGame"
    restartLabel.zPosition = 5
    restartButton.addChild(restartLabel)
  }
  
  func pulseAction(_ node: SKSpriteNode) {
    let scaleUp = SKAction.scale(to: 1.03, duration: 0.6)
    let scaleDown = SKAction.scale(to: 1, duration: 0.6)
    let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
    node.run(SKAction.repeatForever(scaleSequence))
  }
  
  func setScoreDisplay(newScore: Int) {
    let formatter = NumberFormatter()
    let number = NSNumber(value: newScore)
    if let scoreString = formatter.string(from: number) { scoreCountText.text = scoreString }
  }
  
  func showDeadNodes() {
    self.removeAllChildren()
    pulseAction(restartButton)
    self.addChild(restartButton)
    
    let highScore = UserDefaults.standard.object(forKey: "HighScore") as? CGFloat ?? 0
    highscoreLabel.text = "Highscore: " + String(Int(highScore))
    highscoreLabel.fontName = font
    highscoreLabel.fontSize = fontSizeMedium
    highscoreLabel.position = CGPoint(x: 0, y: scoreTable.frame.maxY - 50)
    highscoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    highscoreLabel.zPosition = 5
    
    finalScoreLabel.text = "Score: " + String(Int(playerProgress / 100))
    finalScoreLabel.fontName = font
    finalScoreLabel.fontSize = fontSizeMedium
    finalScoreLabel.position = CGPoint(x: 0, y: highscoreLabel.frame.minY - 30)
    finalScoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    finalScoreLabel.zPosition = 5
    
    self.addChild(scoreTable)
    self.addChild(highscoreLabel)
    self.addChild(finalScoreLabel)
  }
}

