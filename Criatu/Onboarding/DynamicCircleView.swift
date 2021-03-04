//
//  DynamicCircleView.swift
//  Criatu
//
//  Created by Luis Pereira on 30/11/20.
//

import SwiftUI
import SpriteKit

protocol LoaderDelegate{
    func updateFinishButton(hide: Bool)
}
class GameScene: SKScene{
    
    let circleRadius:CGFloat = 50
    var circles:[SKShapeNode] = []
    let bgColor = UIColor.systemGray6
    let unSelectedColor = UIColor.systemGray
    let selectedColor = Palette.shared.main
    
    var loaderDelegate: LoaderDelegate?
    var interests:[Interest] = []
    
    var selectedInterests: [String] = []{
        didSet{
            
            loaderDelegate?.updateFinishButton(hide: selectedInterests.isEmpty)
            
        }
    }
    
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
            circle.run(SKAction.fadeOut(withDuration: 1))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {circle.removeFromParent()})
        })
        
        circles = circles.filter({ item in
            selectedInterests.contains(where: {
                item.name == $0
            })
        })
        
        for interest in filteredInterest.shuffled().prefix(9 - circles.count){
            
            let x = CGFloat.random(in: 0...self.frame.width - circleRadius)
            let y = CGFloat.random(in: 0...self.frame.height - circleRadius)
            let position = CGPoint(x: x, y: y)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
                let newCircle = self.addCircle(interest: interest, position: position)
                newCircle.alpha = 0
                newCircle.run(SKAction.fadeIn(withDuration: 1))
                self.applyForces()
                self.circles.append(newCircle)
            })
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {return}
        
        let nodes = self.nodes(at: location)
        
        for node in nodes{
            
            if node.name != "text" && node.name != "node"{
                
                let circle = node as! SKShapeNode
                
                if circle.physicsBody?.isDynamic == true{
                    
                    circle.fillColor = UIColor(selectedColor)
                    circle.physicsBody?.isDynamic = false
                    waveEffect(centralCircle: circle)
                    self.selectedInterests.append(circle.name!)
                    print("Cirlce name: \(circle.name!)")
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
                
                let forceX = normVector.dx*2000 / dist
                let forceY = normVector.dy*2000 / dist
                
                circle.physicsBody?.applyImpulse(CGVector(dx: forceX, dy: forceY))
                
            }
        }
        
    }
    func addTags(){
        
        for interest in self.interests.shuffled().prefix(9){
            
            let x = CGFloat.random(in: 0...self.frame.width - circleRadius)
            let y = CGFloat.random(in: 0...self.frame.height - circleRadius)
            let position = CGPoint(x: x, y: y)
            circles.append(addCircle(interest: interest, position: position))
        }
    }
    
    func applyForces(){
        
        for circle in circles{
            circle.physicsBody?.applyImpulse(CGVector(dx: CGFloat.random(in: -14...14), dy: CGFloat.random(in: -14...14)))
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
        circle.name = interest.attributes.name
        circle.addChild(textNode(text: interest.attributes.name, circle: circle))
        
        self.addChild(circle)
        return circle
    }
    
    func textNode(text:String,circle:SKShapeNode)->SKNode{
        
        let words = text.components(separatedBy: " ")
        let node = SKNode()
        node.name = "node"
        
        if words.count > 0{
            
            let insideText = SKLabelNode(text:text)
            insideText.numberOfLines = 1
            insideText.verticalAlignmentMode = .center
            insideText.horizontalAlignmentMode = .center
            insideText.fontSize = 32
            insideText.name = "text"
            insideText.fontName = "system"
            insideText.fontColor = .systemBackground
            insideText.colorBlendFactor = 1.0
            let _ = calculateFontSize(labelNode: insideText, circle: circle)
            node.addChild(insideText)
        }
        
        return node
        
    }
    
    func fixString(text:String) -> String{
        var newString = ""
        let words = text.components(separatedBy: " ")
        var index = 0
        
        for word in words{
            
            if index < words.count-1{
                
                newString = newString + word + "\n"
            }
            else{
                newString = newString + word
            }
            index = index + 1
        }
        return newString
    }
    
    func calculateFontSize(labelNode:SKLabelNode, circle: SKShapeNode) -> CGFloat{
        
        
        let scalingFactor = min(circle.frame.width / labelNode.frame.width, (circle.frame.height - 10) / labelNode.frame.height)
        
        let words = labelNode.text!.components(separatedBy: "\n ")
        
        if words.count == 1{
            labelNode.fontSize *= (scalingFactor - CGFloat(1.0/Double(labelNode.text!.count)))
        }
        
        return labelNode.fontSize
    }
    
    
}

class GameSceneLoader: ObservableObject, LoaderDelegate {
    func updateFinishButton(hide: Bool) {
        buttonIsDisabled = hide
    }
    
    
    @Published var scene : GameScene
    
    @Published var buttonIsDisabled = true
    init(){
        
        let scene = GameScene()
        
        
        if UserDefaults.standard.bool(forKey: Keys.kHasLaunchedOnce){
            let window = UIApplication.shared.windows[0]
            let width = window.safeAreaLayoutGuide.layoutFrame.width
            let height = window.safeAreaLayoutGuide.layoutFrame.height - 320
            
            scene.size = CGSize(width: width, height: height)
            scene.position = CGPoint(x: scene.position.x, y: scene.position.y - 100)
        }
        else{
            let window = UIApplication.shared.windows[0]
            let width = window.safeAreaLayoutGuide.layoutFrame.width
            let height = window.safeAreaLayoutGuide.layoutFrame.height - 230
            print(width, height)
            scene.size = CGSize(width: width, height: height)
        }
        
        
        scene.scaleMode = .aspectFill
        self.scene = scene
        self.scene.loaderDelegate = self
    }
    
    func changeSize(size: CGSize){
        scene.size = size
        print(size)
        scene.scaleMode = .aspectFill
    }
    
}

struct DynamicCircleView: View {
    
    var selectedTags: [String] = []
    @ObservedObject var loader = GameSceneLoader()
    @ObservedObject var palette = Palette.shared
    
    var delegate: OnboardingDelegate?
    var body: some View {
        
        
        VStack {
            
            HStack(alignment: .center) {
                
                VStack(alignment: .leading) {
                    
                    Text("Agora é o momento de escolher seus interesses!")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.leading)
                    
                    Text("Use o botão de recarregar para descobrir novos interesses.")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.leading)
                    
                }
                .padding(.horizontal)
                Spacer()
                Button(action: {
                    loader.scene.reloadData()
                    
                }){
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(Color(.systemBackground))
                        .font(.largeTitle)
                        .padding()
                        .background(palette.main)
                        .clipShape(Circle())
                        .shadow(radius: 7)
                        .padding(.trailing, 20)
                    
                }
                
            }
            .padding(.vertical)
            
            SpriteView(scene: loader.scene)
            
            
            Button(action: {
                var interests: [Interest] = []
                let apiHandler = PixabayAPI()
                
                for tag in loader.scene.selectedInterests{
                    apiHandler.GetData(tagsSearched: tag, completionHandler: {response in
                        print("Tag: \(tag)")
                        print("Images: \(DiscoverBank.shared.$items.count)")
                        
                    })
                    
                    if let first = loader.scene.interests.first(where: {$0.attributes.id == tag}){
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
                    .foregroundColor(Color.primary)
                    .padding(.vertical)
                    .padding(.horizontal,80)
                    .background(loader.buttonIsDisabled ? Color(.systemGray3) : palette.main)
                    .cornerRadius(10)
            })
            .disabled(loader.buttonIsDisabled)
            
            .padding(.bottom, 40)
        }
        .background(Color(.systemGray6))
        .navigationBarHidden((delegate!.isOnboarding()))
        .navigationBarTitle("", displayMode: .inline)
        
    }
}

struct DynamicCircleView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicCircleView()
    }
}
