import SpriteKit

class Player: SKSpriteNode {
  var initialSize = CGSize(width: 45, height: 45 )
  var textureAtlas = SKTextureAtlas(named:"Player")
  var forwardVelocity = CGFloat(225)
  var jumpVelocity = CGFloat(600)
  var dieForwardVelocity = CGFloat(0)
  var dieUpwardVelocity = CGFloat(300)
  var jumping = false
  
  init() {
    super.init(texture: nil, color: .clear, size: initialSize)
    self.name = "player"
    self.texture = textureAtlas.textureNamed("square")
    self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
    self.physicsBody?.affectedByGravity = true
    self.physicsBody?.categoryBitMask =
      PhysicsCategory.player.rawValue
    self.physicsBody?.contactTestBitMask =
      PhysicsCategory.ledge.rawValue |
      PhysicsCategory.edge.rawValue |
      PhysicsCategory.spike.rawValue
    self.physicsBody?.collisionBitMask =
      PhysicsCategory.ledge.rawValue |
      PhysicsCategory.edge.rawValue |
      PhysicsCategory.spike.rawValue
  }
  
  func jump() {
    self.physicsBody?.velocity.dy = self.jumpVelocity
    let rotateAction = SKAction.rotate(byAngle: CGFloat(-.pi/0.5), duration: 0.6)
    self.run(rotateAction)
  }
  
  func die() {
    dead = true
    self.texture = textureAtlas.textureNamed("square-dead")
    self.physicsBody?.velocity.dx = 0
    self.physicsBody?.velocity.dy = self.dieUpwardVelocity
    self.physicsBody?.collisionBitMask = 0
    
    if playerProgress / 100 > highScore {
      UserDefaults.standard.set(playerProgress / 100, forKey:"HighScore")
      UserDefaults.standard.synchronize()
    }
  }
  
  func update() {
    if dead { return }
    self.physicsBody?.allowsRotation = false
    self.physicsBody?.velocity.dx = self.forwardVelocity
    if self.physicsBody?.velocity.dy != 0 {
      jumping = true
      self.texture = textureAtlas.textureNamed("square-jump")
    } else {
      jumping = false
      self.texture = textureAtlas.textureNamed("square")
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
