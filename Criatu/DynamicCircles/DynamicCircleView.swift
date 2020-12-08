//
//  DynamicCircleView.swift
//  Criatu
//
//  Created by Luis Pereira on 30/11/20.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene{
    
    let circleRadius:CGFloat = 30
    var circles:[SKShapeNode] = []
    let bgColor = UIColor.systemBackground
    let unSelectedColor = UIColor.systemGray
    let selectedColor = Palette.shared.main
    
    var interests:[Interest] = []
    
    var selectedInterests: [String] = []
    
    var palette = Palette.shared
    
    var didCreate: Bool = false
    override func didMove(to view: SKView) {
        if !didCreate{
            didCreate = true
            physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
            physicsWorld.gravity = CGVector(dx: 0, dy: 0)
            physicsBody?.isDynamic = false
            backgroundColor = bgColor
            
            FirebaseHandler.readAllCollection(.interests, dataType: [Interest.Database].self) { result in
                
                if case .success(let interestDatabases) = result {
                    
                    self.interests = interestDatabases.map{
                        Interest(attributes: $0)
                    }
                    self.addTags()
                    self.applyForces()
                }
            }
        }
        
    }
    
    func reloadData(){
        
        let filteredInterest = interests.filter({ item in
            !selectedInterests.contains(where: {
                item.attributes.id == $0
            })
        })
        
        circles.filter({ item in
            !selectedInterests.contains(where: {
                item.name == $0
            })
        }).forEach({circle in
            circle.removeFromParent()
        })
        
        circles = circles.filter({ item in
            selectedInterests.contains(where: {
                item.name == $0
            })
        })
        
        for interest in filteredInterest.shuffled().prefix(12 - circles.count){
            
            let x = CGFloat.random(in: 0...self.frame.width - circleRadius)
            let y = CGFloat.random(in: 0...self.frame.height - circleRadius)
            let position = CGPoint(x: x, y: y)
            circles.append(addCircle(interest: interest, position: position))
        }
        
        applyForces()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {return}
        
        let nodes = self.nodes(at: location)
        
        for node in nodes{
            
            if node.name != "text"{
                let circle = node as! SKShapeNode
                
                if circle.physicsBody?.isDynamic == true{
                    
                    circle.fillColor = UIColor(selectedColor)
                    circle.physicsBody?.isDynamic = false
                    waveEffect(centralCircle: circle)
                    self.selectedInterests.append(circle.name!)
                    print(self.selectedInterests.count)
                }
                
                else {
                    circle.fillColor = unSelectedColor
                    circle.physicsBody?.isDynamic = true
                    let index = self.selectedInterests.firstIndex(of: circle.name!)
                    self.selectedInterests.remove(at: index!)
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
        
        for interest in self.interests.shuffled().prefix(12){
            
            let x = CGFloat.random(in: 0...self.frame.width - circleRadius)
            let y = CGFloat.random(in: 0...self.frame.height - circleRadius)
            let position = CGPoint(x: x, y: y)
            circles.append(addCircle(interest: interest, position: position))
        }
    }
    
    func applyForces(){
        
        for circle in circles{
            circle.physicsBody?.applyImpulse(CGVector(dx: CGFloat.random(in: -7...7), dy: CGFloat.random(in: -7...7)))
        }
    }
    
    func addCircle(interest: Interest, position:CGPoint)->SKShapeNode{
        
        let circle = SKShapeNode(circleOfRadius: circleRadius)
        circle.fillColor = unSelectedColor
        circle.strokeColor = .clear
        circle.position = position
        circle.physicsBody = SKPhysicsBody(circleOfRadius: circleRadius)
        circle.physicsBody?.isDynamic = true
        circle.physicsBody?.allowsRotation = false
        circle.physicsBody?.affectedByGravity = false
        circle.physicsBody?.restitution = 1
        circle.name = interest.attributes.id
        
        let insideText = SKLabelNode(text: interest.attributes.name)
        
        insideText.numberOfLines = 0
        insideText.verticalAlignmentMode = .center
        insideText.horizontalAlignmentMode = .center
        insideText.fontSize = 32
        insideText.name = "text"
        insideText.fontName = "system"
        insideText.fontColor = .systemBackground
        insideText.colorBlendFactor = 1.0
        
        calculateFontSize(labelNode: insideText, circle: circle)
        circle.addChild(insideText)
        
        self.addChild(circle)
        return circle
    }
    
    func calculateFontSize(labelNode:SKLabelNode, circle: SKShapeNode){
        
        
        let scalingFactor = min(circle.frame.width / labelNode.frame.width, circle.frame.height / labelNode.frame.height)
        labelNode.fontSize *= (scalingFactor-0.01)
        
        /*if labelNode.text!.filter({$0 == " "}).count > 0{
         labelNode.preferredMaxLayoutWidth = circle.frame.width
         circle.setScale(0.5 / scalingFactor)
         labelNode.fontSize *= 1.1 * scalingFactor
         }
         
         
         else if labelNode.text!.count < 6{
         labelNode.fontSize *= scalingFactor
         }
         else{
         labelNode.fontSize *= scalingFactor
         circle.setScale(0.7 / scalingFactor)
         }*/
        
    }
    
    
}

class GameSceneLoader: ObservableObject {
    
    @Published var scene : GameScene
    
    init(){
        
        let scene = GameScene()
        scene.size = CGSize(width: 200, height: 400)
        scene.scaleMode = .fill
        self.scene = scene
    }
    
    

}

struct DynamicCircleView: View {
    
    var selectedTags: [String] = []
    @ObservedObject var loader = GameSceneLoader()
    @ObservedObject var palette = Palette.shared
    
    var delegate: OnboardingDelegate?
    var body: some View {
        
        
        VStack {
            
            ZStack(alignment: .topTrailing) {
                
                SpriteView(scene: loader.scene)
                
                Button(action: {
                    print("memeeeeeee")
                    loader.scene.reloadData()
                    
                }){
                    
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(Color(.systemBackground))
                        .font(.largeTitle)
                        .padding()
                        .background(palette.main)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
                
                
            }
            
            Button(action: {
                var interests: [Interest] = []
                
                for id in loader.scene.selectedInterests{
                    if let first = loader.scene.interests.first(where: {$0.attributes.id == id}){
                        interests.append(first)
                    }
                }
                Interest.archive(interests: interests)
                
                delegate?.endInterestSelection()
            }, label: {
                Text("Terminei")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.systemBackground))
                    .font(.title2)
            })
            .foregroundColor(Color.primary)
            .padding(.vertical)
            .padding(.horizontal,80)
            .background(palette.main)
            .cornerRadius(10)
            .padding(.bottom, 40)
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct DynamicCircleView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicCircleView()
    }
}
