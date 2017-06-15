import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  let ground = Ground()
  let player = Player()
  let encounterManager = EncounterManager()
  let cam = SKCameraNode()
  var playerProgress = CGFloat(0)
  let initialPlayerPosition = CGPoint(x: 75, y: 200)
  var nextEncounterSpawnPosition = CGFloat(150)
  
  override func didMove(to view: SKView) {
    self.physicsWorld.contactDelegate = self
    self.backgroundColor = UIColor.white
    encounterManager.addEncountersToScene(gameScene: self)
    
    ground.position = CGPoint(x: -self.size.width * 2, y: 30)
    ground.size = CGSize(width: self.size.width * 6, height: 0)
    ground.createChildren()
    self.addChild(ground)
    
    player.position = initialPlayerPosition
    self.addChild(player)
    
    self.camera = cam
    self.addChild(self.camera!)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if player.jumping { return }
    if dead {
      dead = false
      self.view?.presentScene(GameScene(size: self.size))
      return
    }
    player.jump()
  }
  
  override func didSimulatePhysics() {
    self.camera!.position = CGPoint(x: player.position.x + 300, y: ground.position.y + 160)
    playerProgress = player.position.x - initialPlayerPosition.x
    ground.checkForReposition(playerProgress: playerProgress)

    if player.position.x > nextEncounterSpawnPosition {
      encounterManager.placeNextEncounter(
        currentXPos: nextEncounterSpawnPosition)
      nextEncounterSpawnPosition += 900
    }
  }
  
  override func update(_ currentTime: TimeInterval) {
    player.update()
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    let otherBody: SKPhysicsBody
    let playerMask = PhysicsCategory.player.rawValue
    if (contact.bodyA.categoryBitMask & playerMask) > 0 { otherBody = contact.bodyB }
    else { otherBody = contact.bodyA }
    
    switch otherBody.categoryBitMask {
    case PhysicsCategory.spike.rawValue:
      if dead { return }
      player.die()
    default: break
    }
  }

}

enum PhysicsCategory:UInt32 {
  case player = 1
  case ground = 2
  case ledge = 4
  case spike = 8
}
