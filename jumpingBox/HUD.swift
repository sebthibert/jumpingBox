import SpriteKit

class HUD: SKNode {
  var textureAtlas = SKTextureAtlas(named:"HUD")
  var coinAtlas = SKTextureAtlas(named: "Environment")
  let coinIcon = SKSpriteNode()
  let scoreLabel = SKLabelNode(text: "Score: ")
  let finalScoreLabel = SKLabelNode()
  let scoreCountText = SKLabelNode(text: "0")
  let highscoreLabel = SKLabelNode()
  let coinCountLabel = SKLabelNode(text: String(describing: coinsCollected))
  let pauseButton = SKSpriteNode()
  let playButton = SKSpriteNode()
  let pauseButtonPosition = CGPoint(x: 305, y: 155)
  let scoreTable = Button()
  let restartButton = Button()
  let restartLabel = SKLabelNode(text: "Restart")
  let newLife = SKSpriteNode()
  let newLifeLabel = SKLabelNode(text: "25")
  let newLifeCoin = SKSpriteNode()
  
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
    scoreLabel.position = CGPoint(x: -325, y: 170)
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
    scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    scoreCountText.fontName = font
    scoreCountText.fontSize = fontSizeSmall
    scoreCountText.position = CGPoint(x: scoreLabel.frame.maxX + 5, y: scoreLabel.frame.midY)
    scoreCountText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
    scoreCountText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    self.addChild(scoreLabel)
    self.addChild(scoreCountText)
    
    coinIcon.texture = coinAtlas.textureNamed("coin")
    coinIcon.size = CGSize(width: 20, height: 20)
    coinIcon.position = CGPoint(x: scoreLabel.frame.minX + (coinIcon.frame.width / 2), y: scoreLabel.frame.minY - 15)
    coinCountLabel.fontName = font
    coinCountLabel.fontSize = fontSizeSmall
    coinCountLabel.position = CGPoint(x: coinIcon.frame.maxX + 5, y: coinIcon.frame.midY)
    coinCountLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
    coinCountLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    self.addChild(coinIcon)
    self.addChild(coinCountLabel)
  }
  
  func pulseAction(_ node: SKSpriteNode) {
    let scaleUp = SKAction.scale(to: 1.03, duration: 0.6)
    let scaleDown = SKAction.scale(to: 1, duration: 0.6)
    let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
    node.run(SKAction.repeatForever(scaleSequence))
  }
  
  func wiggleAction(_ node: SKSpriteNode) {
    let rotateLeft = SKAction.rotate(byAngle: 0.15, duration: 0.1)
    let rotateRight = SKAction.rotate(byAngle: -0.15, duration: 0.1)
    let wait = SKAction.wait(forDuration: 3)
    let rotateSequence = SKAction.sequence([rotateLeft, rotateRight, rotateRight, rotateLeft, rotateLeft, rotateRight, rotateRight, rotateLeft, wait])
    node.run(SKAction.repeatForever(rotateSequence))
  }
  
  func setScoreDisplay(newScore: Int) {
    let formatter = NumberFormatter()
    let number = NSNumber(value: newScore)
    if let scoreString = formatter.string(from: number) { scoreCountText.text = scoreString }
  }
  
  func setCoinCountDisplay(newScore: Int) {
    let formatter = NumberFormatter()
    let number = NSNumber(value: newScore)
    if let coinString = formatter.string(from: number) { coinCountLabel.text = coinString }
  }
  
  func notEnoughCoins() {
    let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
    let scaleDown = SKAction.scale(to: 1, duration: 0.2)
    let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
    coinIcon.run(scaleSequence)
  }
  
  func showDeadNodes() {
    self.removeAllChildren()
    
    scoreTable.size = CGSize(width: 375, height: 210)
    scoreTable.position = CGPoint(x: 0, y: 60)
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
    finalScoreLabel.position = CGPoint(x: highscoreLabel.frame.minX + (finalScoreLabel.frame.width / 2), y: highscoreLabel.frame.minY - 30)
    finalScoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    finalScoreLabel.zPosition = 5
    
    coinIcon.size = CGSize(width: 30, height: 30)
    coinIcon.position = CGPoint(x: highscoreLabel.frame.minX + (coinIcon.frame.width / 2), y: finalScoreLabel.frame.minY - 40)
    coinIcon.zPosition = 5
    coinCountLabel.fontSize = fontSizeMedium
    coinCountLabel.position = CGPoint(x: coinIcon.frame.maxX + 15, y: coinIcon.frame.midY)
    coinCountLabel.zPosition = 5
    
    newLife.texture = textureAtlas.textureNamed("heart")
    newLife.size = CGSize(width: 50, height: 50)
    newLife.position = CGPoint(x: restartButton.frame.maxX + 40, y: restartButton.frame.midY)
    newLife.name = "newLife"
    newLife.zPosition = 5
    
    newLifeLabel.fontName = font
    newLifeLabel.fontSize = fontSizeSmall
    newLifeLabel.position = CGPoint(x: newLife.frame.maxX + 25, y: newLife.frame.midY)
    newLifeLabel.zPosition = 5
    
    newLifeCoin.texture = coinAtlas.textureNamed("coin")
    newLifeCoin.size = CGSize(width: 15, height: 15)
    newLifeCoin.position = CGPoint(x: newLifeLabel.frame.midX, y: newLifeLabel.frame.minY - 15)
    
    self.addChild(scoreTable)
    self.addChild(highscoreLabel)
    self.addChild(finalScoreLabel)
    self.addChild(coinIcon)
    self.addChild(coinCountLabel)
    self.addChild(newLifeLabel)
    self.addChild(newLifeCoin)
    
    wiggleAction(newLife)
    self.addChild(newLife)
  }
}

