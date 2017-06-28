import SpriteKit
import GameplayKit

class ShopScene: SKScene {
  var playerAtlas = SKTextureAtlas(named: "Player")
  let titleLabel = SKLabelNode(text: "Shop")
  let player = Player()
  
  override func didMove(to view: SKView) {
    self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    self.backgroundColor = .gray
    
    titleLabel.fontName = font
    titleLabel.fontSize = fontSizeLarge
    titleLabel.position = CGPoint(x: 0, y: 120)
    self.addChild(titleLabel)
    
    player.size = CGSize(width: 80, height: 80)
    player.position = CGPoint(x: 0, y: 0)
    player.physicsBody?.affectedByGravity = false
    self.addChild(player)
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


