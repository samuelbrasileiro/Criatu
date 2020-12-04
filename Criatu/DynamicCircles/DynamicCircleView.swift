//
//  DynamicCircleView.swift
//  Criatu
//
//  Created by Luis Pereira on 30/11/20.
//

import SwiftUI
import SpriteKit

class InterestBank: ObservableObject {
    
    @Published var interests:[Interest] = []
    
    init(){
        
    }
}

class GameScene:SKScene{
    
    @ObservedObject var bank:InterestBank = InterestBank()
    let circleRadius:CGFloat = 25
    //var tags = ["A", "B", "C", "D","E","F","G","H","I","J","K","L","M","N"]
    var circles:[SKShapeNode] = []
    let bgColor = UIColor.systemBackground
    let unSelectedColor = UIColor.systemGray
    let selectedColor = UIColor.systemPurple
    public var selectedTags:[String] = []
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody?.isDynamic = false
        backgroundColor = bgColor
        FirebaseHandler.readAllCollection(.interests, dataType: [Interest.Database].self) { result in
            
            if case .success(let interestDatabases) = result {
                
                self.bank.interests = interestDatabases.map{
                    Interest(attributes: $0)
                }
                self.addTags()
                self.applyForces()
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {return}
        
        let nodes = self.nodes(at: location)
        
        for node in nodes{
            
            if node.name != "text"{
                
                let circle = node as! SKShapeNode
                
                if circle.physicsBody?.isDynamic == true{
                    
                    circle.fillColor = selectedColor
                    circle.physicsBody?.isDynamic = false
                    waveEffect(centralCircle: circle)
                    selectedTags.append(circle.name!)
                }
                
                else if circle.physicsBody?.isDynamic == false {
                    circle.fillColor = unSelectedColor
                    circle.physicsBody?.isDynamic = true
                    let index = selectedTags.firstIndex(of: circle.name!)
                    selectedTags.remove(at: index!)
                }
                
            }
        }
        
        
    }
    
    func waveEffect(centralCircle: SKShapeNode){
        
        for circle in circles{
            
            if circle != centralCircle{
                
                let x = circle.position.x - centralCircle.position.x
                let y = circle.position.y - centralCircle.position.y
                
                var normVector = CGVector(dx: x, dy: y)
                let dist = sqrt(pow(normVector.dx, 2) + pow(normVector.dy, 2))
                
                normVector.dx = normVector.dx / dist
                
                normVector.dy = normVector.dy / dist
                
                let forceX = normVector.dx*300 / dist
                let forceY = normVector.dy*300 / dist
                
                circle.physicsBody?.applyImpulse(CGVector(dx: forceX, dy: forceY))
                
            }
        }
        
    }
    func addTags(){
        
        for tag in bank.interests.prefix(15){
            
            let x = CGFloat.random(in: 0...self.frame.width - circleRadius)
            let y = CGFloat.random(in: 0...self.frame.height - circleRadius)
            let position = CGPoint(x: x, y: y)
            circles.append(addCircle(tag: tag.attributes.name, position: position))
        }
    }
    
    func applyForces(){
        
        for circle in circles{
            circle.physicsBody?.applyImpulse(CGVector(dx: CGFloat.random(in: -10...10), dy: CGFloat.random(in: -10...10)))
        }
    }
    
    func addCircle(tag:String, position:CGPoint)->SKShapeNode{
        
        let circle = SKShapeNode(circleOfRadius: circleRadius)
        circle.fillColor = unSelectedColor
        circle.strokeColor = .clear
        circle.position = position
        circle.physicsBody = SKPhysicsBody(circleOfRadius: circleRadius)
        circle.physicsBody?.isDynamic = true
        circle.physicsBody?.allowsRotation = false
        circle.physicsBody?.affectedByGravity = false
        circle.physicsBody?.restitution = 1
        circle.name = tag
        let insideText = SKLabelNode(text: tag)
        insideText.fontColor = .black
        insideText.numberOfLines = 0
        insideText.verticalAlignmentMode = .center
        insideText.horizontalAlignmentMode = .center
        insideText.name = "text"
        calculateFontSize(labelNode: insideText, rect: circle.frame)
        circle.addChild(insideText)
        
        
        self.addChild(circle)
        return circle
    }
    
    func calculateFontSize(labelNode:SKLabelNode, rect:CGRect){
        
        let scalingFactor = min(rect.width / labelNode.frame.width, rect.height / labelNode.frame.height)
        
        labelNode.fontSize *= scalingFactor
    }
    
    
}

struct DynamicCircleView: View {
    
    var scene : SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 200, height: 400)
        scene.scaleMode = .fill
        return scene
    }
    var body: some View {
        
        
        VStack {
            
            SpriteView(scene: scene)
    
            Button(action: {}, label: {
                Text("Terminei")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.systemBackground))
            })
            .foregroundColor(Color.primary)
            .padding(.vertical)
            .padding(.horizontal,80)
            .background(Color(.systemPurple))
            .cornerRadius(10)
            
        }.ignoresSafeArea(.all, edges: .horizontal)
    }
}

struct DynamicCircleView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicCircleView()
    }
}
