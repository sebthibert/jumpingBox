import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  let ground = Ground()
  let player = Player()
  let encounterManager = EncounterManager()
  let cam = SKCameraNode()
  var playerProgress = CGFloat(0)
  let initialPlayerPosition = CGPoint(x: 75, y: 200)
  var nextEncounterSpawnPosition = CGFloat(150)
  
  override func didMove(to view: SKView) {
    self.backgroundColor = UIColor.white
    encounterManager.addEncountersToScene(gameScene: self)
    encounterManager.encounters[0].position =
      CGPoint(x: 1000, y: 330)
    
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

}

enum PhysicsCategory:UInt32 {
  case box = 1
  case ground = 2
  case ledge = 4
}
