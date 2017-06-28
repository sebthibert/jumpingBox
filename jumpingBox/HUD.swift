import SpriteKit

class HUD: SKNode {
  let coinIcon = SKSpriteNode(texture: SKTextureAtlas(named:"Environment").textureNamed("coin"), color: .clear, size: CGSize(width: 20, height: 20))
  let scoreLabel = SKLabelNode(fontNamed: font)
  let highscoreLabel = SKLabelNode(fontNamed: font)
  let coinCountLabel = SKLabelNode(text: String(describing: coinsCollected))
  let pauseButton = SKSpriteNode(texture: SKTextureAtlas(named:"HUD").textureNamed("pause"), color: .clear, size: CGSize(width: 20, height: 25))
  let playButton = SKSpriteNode(texture: SKTextureAtlas(named:"HUD").textureNamed("play"), color: .clear, size: CGSize(width: 25, height: 25))
  let scoreTable = Button()
  let restartButton = Button()
  let restartLabel = SKLabelNode(text: "Restart")
  let newLifeBackground = Button()
  let newLife = SKSpriteNode(texture: SKTextureAtlas(named:"HUD").textureNamed("heart"), color: .clear, size: CGSize(width: 40, height: 40))
  let newLifeLabel = SKLabelNode(text: "25")
  let newLifeCoin = SKSpriteNode(texture: SKTextureAtlas(named:"Environment").textureNamed("coin"), color: .clear, size: CGSize(width: 15, height: 15))
  
  func createHudNodes(screenSize: CGSize) {
    pauseButton.name = "pauseGame"
    pauseButton.position = CGPoint(x: 305, y: 155)
    self.addChild(pauseButton)
    
    playButton.isHidden = true
    playButton.name = "playGame"
    playButton.position = CGPoint(x: 305, y: 155)
    self.addChild(playButton)
    
    scoreLabel.fontSize = fontSizeSmall
    scoreLabel.position = CGPoint(x: -325, y: 160)
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
    self.addChild(scoreLabel)
    
    coinIcon.position = CGPoint(x: scoreLabel.frame.minX + (coinIcon.frame.width / 2), y: scoreLabel.frame.minY - 15)
    self.addChild(coinIcon)
    
    coinCountLabel.fontName = font
    coinCountLabel.fontSize = fontSizeSmall
    coinCountLabel.position = CGPoint(x: coinIcon.frame.maxX + 5, y: coinIcon.frame.midY)
    coinCountLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
    coinCountLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    self.addChild(coinCountLabel)
  }
  
  func setScoreDisplay(newScore: Int) {
    let formatter = NumberFormatter()
    let number = NSNumber(value: newScore)
    if let scoreString = formatter.string(from: number) { scoreLabel.text = "Score: " + scoreString }
  }
  
  func setCoinCountDisplay(newScore: Int) {
    let formatter = NumberFormatter()
    let number = NSNumber(value: newScore)
    if let coinString = formatter.string(from: number) { coinCountLabel.text = coinString }
  }
  
  func showDeadNodes() {
    self.removeAllChildren()
    
    scoreTable.size = CGSize(width: 375, height: 210)
    scoreTable.position = CGPoint(x: 0, y: 60)
    scoreTable.zPosition = 4
    self.addChild(scoreTable)
    
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
    highscoreLabel.fontSize = fontSizeMedium
    highscoreLabel.position = CGPoint(x: 0, y: scoreTable.frame.maxY - 50)
    highscoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    highscoreLabel.zPosition = 5
    self.addChild(highscoreLabel)
    
    scoreLabel.text = "Score: " + String(Int(playerProgress / 100))
    scoreLabel.fontName = font
    scoreLabel.fontSize = fontSizeMedium
    scoreLabel.position = CGPoint(x: highscoreLabel.frame.minX, y: highscoreLabel.frame.minY - 30)
    scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    scoreLabel.zPosition = 5
    self.addChild(scoreLabel)
    
    coinIcon.size = CGSize(width: 30, height: 30)
    coinIcon.position = CGPoint(x: highscoreLabel.frame.minX + (coinIcon.frame.width / 2), y: scoreLabel.frame.minY - 40)
    coinIcon.zPosition = 5
    self.addChild(coinIcon)
    
    coinCountLabel.fontSize = fontSizeMedium
    coinCountLabel.position = CGPoint(x: coinIcon.frame.maxX + 15, y: coinIcon.frame.midY)
    coinCountLabel.zPosition = 5
    self.addChild(coinCountLabel)
    
    newLife.position = CGPoint(x: restartButton.frame.maxX + 50, y: restartButton.frame.midY + 10)
    newLife.name = "newLife"
    newLife.zPosition = 5
    wiggleAction(newLife)
    self.addChild(newLife)
    
    newLifeCoin.position = CGPoint(x: newLife.frame.minX + 5, y: newLife.frame.minY - 10)
    newLifeCoin.name = "newLife"
    newLifeCoin.zPosition = 5
    self.addChild(newLifeCoin)
    
    newLifeLabel.name = "newLife"
    newLifeLabel.fontName = font
    newLifeLabel.fontSize = fontSizeTiny
    newLifeLabel.position = CGPoint(x: newLifeCoin.frame.maxX + 15, y: newLifeCoin.frame.midY)
    newLifeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    newLifeLabel.zPosition = 5
    self.addChild(newLifeLabel)
    
    newLifeBackground.name = "newLife"
    newLifeBackground.size = CGSize(width: 70, height: 70)
    newLifeBackground.position = CGPoint(x: newLife.frame.midX, y: newLife.frame.midY - 10)
    newLifeBackground.zPosition = 4
    self.addChild(newLifeBackground)
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
  
  func notEnoughCoins() {
    let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
    let scaleDown = SKAction.scale(to: 1, duration: 0.2)
    let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
    coinIcon.run(scaleSequence)
  }
}
