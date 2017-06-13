import SpriteKit

class Player: SKSpriteNode {
  var initialSize = CGSize(width: 30, height: 30)
  var forwardVelocity = CGFloat(200)
  var jumpVelocity = CGFloat(600)
  var jumping = false
  
  init() {
    super.init(texture: nil, color: .clear, size: initialSize)
    self.name = "player"
    self.size = CGSize(width: 30, height: 30)
    self.color = .blue
    self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
    self.physicsBody?.affectedByGravity = true
    self.physicsBody?.categoryBitMask =
      PhysicsCategory.box.rawValue
    self.physicsBody?.collisionBitMask =
      PhysicsCategory.ground.rawValue |
      PhysicsCategory.ledge.rawValue
  }
  
  func jump() {
    self.physicsBody?.velocity.dy = self.jumpVelocity
    let rotateAction = SKAction.rotate(byAngle: CGFloat(-.pi/1.0), duration: 0.6)
    self.run(rotateAction)
  }
  
  func update() {
    self.physicsBody?.allowsRotation = false
    self.physicsBody?.velocity.dx = self.forwardVelocity
    if self.physicsBody?.velocity.dy != 0 { jumping = true } else { jumping = false }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
