import SpriteKit
import GameplayKit

class StartScene: SKScene {
  let titleLabel = SKLabelNode(text: "JUMBOX!")
  let startButton = Button()
  let startLabel = SKLabelNode(text: "Start")
  let player = Player()
  let hud = HUD()
  
  override func didMove(to view: SKView) {
    self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    self.backgroundColor = .gray
    
    titleLabel.fontName = font
    titleLabel.fontSize = fontSizeLarge
    titleLabel.position = CGPoint(x: 0, y: 120)
    self.addChild(titleLabel)
    
    startButton.name = "startGame"
    startButton.size = CGSize(width: 170, height: 60)
    startButton.position = CGPoint(x: 0, y: -135)
    startButton.zPosition = 4
    
    startLabel.fontName = font
    startLabel.fontSize = fontSizeMedium
    startLabel.verticalAlignmentMode = .center
    startLabel.name = "startGame"
    startLabel.zPosition = 5
    startButton.addChild(startLabel)
    hud.pulseAction(startButton)
    self.addChild(startButton)
    
    player.size = CGSize(width: 130, height: 130)
    player.position = CGPoint(x: 0, y: -25)
    player.physicsBody?.affectedByGravity = false
    jumpAction()
    self.addChild(player)
  }
  
  func jumpAction() {
    let jumpTexture = SKAction.setTexture(SKTextureAtlas(named: "Player").textureNamed("square-jump"))
    let upAction = SKAction.moveTo(y: player.position.y + 60, duration: 0.25)
    let downAction = SKAction.moveTo(y: -25, duration: 0.25)
    let bounceUp = SKAction.moveTo(y: player.position.y + 8, duration: 0.1)
    let bounceDown = SKAction.moveTo(y: -25, duration: 0.07)
    let landTexture = SKAction.setTexture(SKTextureAtlas(named: "Player").textureNamed("square"))
    let wait = SKAction.wait(forDuration: 4)
    let jumpSequence = SKAction.sequence([jumpTexture, upAction, downAction, bounceUp, bounceDown, landTexture, wait])
    player.run(SKAction.repeatForever(jumpSequence))
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in (touches) {
      let location = touch.location(in: self)
      let nodeTouched = atPoint(location)
      
      if nodeTouched.name == "startGame" {
        self.view?.presentScene(GameScene(size: self.size), transition: .crossFade(withDuration: 0.5))
      }
    }
  }
}

