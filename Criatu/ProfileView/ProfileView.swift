//
//  ProfileView.swift
//  Criatu
//
//  Created by Alanis Lima Santa Clara on 30/11/20.
//

import SwiftUI
import CoreData
import UserNotifications
import FirebaseAnalytics

class Palette: ObservableObject{
    static var shared: Palette = Palette()
    
    let colors: [Color] = [.systemPurple, .systemBlue, .systemRed, .systemGreen, .systemPink, .systemTeal, .systemOrange, .systemIndigo].map{Color($0)}
    
    let descriptions: [String] = ["Roxo Elétrico", "Azul Pacífico","Vermelho Melancia", "Verde Amoeba", "Rosa Choque", "Ciano Tiffany", "Laranja Laranja", "Roxo Duquesa"]
    
    var selectedMainColor: Int = 0{
        didSet{
            main = colors[selectedMainColor]
            archive(color: selectedMainColor, for: Keys.kPaletteMainColor)
        }
    }
    
    @Published var main: Color
    
    private init(){
        
        selectedMainColor = Palette.restore(for: Keys.kPaletteMainColor)
        if selectedMainColor >= colors.count{
            selectedMainColor -= 1
        }
        self.main = colors[selectedMainColor]
    }
    
    func archive(color: Int, for key: String){
        let defaults = UserDefaults(suiteName: "group.ufpe.academy.criatu")!
        
        defaults.setValue(color, forKey: key)
        print("Changed color to ", colors[color])
        
        
    }
    
    class func restore(for key: String) -> Int {
        let defaults = UserDefaults(suiteName: "group.ufpe.academy.criatu")!
        let color = defaults.integer(forKey: key)
        return color
    }
    
}


struct ProfileView: View, OnboardingDelegate {
    func isOnboarding() -> Bool {
        return false
    }
    
    
    func finishOnboarding() {
        
    }
    
    func endInterestSelection() {
        isSelectingInterest = false
    }
    
    @State var isSelectingInterest = false
    
    var name: String = "E aí, beleza?"
    var wardrobe: Int{
        let closetsRequest: NSFetchRequest<Closet> = Closet.fetchRequest()
        do{
            let closets = try AppDelegate.viewContext.fetch(closetsRequest)
            return closets.count
        }catch{
            print(error)
            return 0
        }
        
    }
    
    @State var selectedIndex = Palette.shared.selectedMainColor
    @State var showNotification = true

    @State var changeColors = true
    @State var updateView = true
    @ObservedObject var palette = Palette.shared
    
    var body: some View {
        NavigationView{
            VStack{
                
                Text("E aí, Beleza?")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(palette.main)
                    .padding(.bottom, 10.0)
                
                Text("Até o momento você já descobriu ")
                    .padding(10.0)
                
                ZStack{
                    Circle()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(palette.main)
                        .opacity(0.6)
                        .position(x: 70, y: 60)
                    Circle()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(palette.main)
                        .opacity(0.8)
                        .position(x: 20, y: 30)
                    Circle()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(palette.main)
                        .opacity(0.8)
                        .position(x: 70, y: 20)
                    
                    Circle()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(palette.main)
                        .opacity(0.8)
                        .position(x: 15, y: 80)
                    Circle()
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(palette.main)
                        .opacity(0.4)
                        .position(x: 47, y: 85)
                    
                    Text(String(wardrobe))
                        .font(.system(size: 48, weight: .bold, design: .default))
                        
                        .shadow(radius: 7)
                        .padding(20.0)
                    
                } .frame(width: 80, height: 80, alignment: .center)
                
                
                Text("Armários")
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding(10.0)
                
                Spacer()
                
                ZStack{
                    
                    Rectangle()
                        .fill(Color(.systemGray6).opacity(0.9))
                        .cornerRadius(40, corners: [.topLeft, .topRight])
                        .shadow(radius: 15).opacity(0.9)
                    VStack(alignment: .leading, spacing: 5){
                        Text("Cor do tema")
                            .font(.title3)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .padding()
                        ScrollView(.horizontal){
                            LazyHStack(spacing: 15){
                                ForEach(0..<palette.colors.count, id: \.self) { index in
                                    
                                    Button(action: {
                                        selectedIndex = index
                                        palette.selectedMainColor = selectedIndex
                                        Analytics.logEvent("Trocou_de_cor", parameters: ["Cor_selecionada": palette.descriptions[selectedIndex]])
                                    }, label: {
                                        if selectedIndex == index{
                                            VStack(){
                                                Circle()
                                                    .foregroundColor(palette.colors[index])
                                                    
                                                    .frame(width: 40, height: 40, alignment: .center)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .stroke(palette.colors[index], lineWidth: 5)
                                                    )
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .stroke(Color(.systemGray6), lineWidth: 1)
                                                    )
                                            }
                                        }
                                        else{
                                            VStack{
                                                Circle().foregroundColor(palette.colors[index])
                                                    .frame(width: 40, height: 40, alignment: .center)
                                                
                                            }
                                        }
                                    })
                                }
                                
                            }.padding()
                        }
                        .frame(height: 60)
                        Text("\(palette.descriptions[selectedIndex])" + " é o seu tema no momento")
                            .font(.footnote)
                            .fontWeight(.thin)
                            .italic()
                            .padding(.leading)
                            .foregroundColor(Color(.systemGray))
                            .lineLimit(1)
                        
                        Divider()
                        
                        VStack {
                            Toggle(isOn: $showNotification) {
                                Text("Notificações")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: palette.main))
                            .disabled(true)
                            .padding()
                            
                        }
                        Divider()
                        
                        NavigationLink(destination: DynamicCircleView(delegate: self), isActive: $isSelectingInterest){
                            EmptyView()
                        }
                        Button(action: {
                            isSelectingInterest = true
                        }){
                            HStack{
                                Text("Interesses")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(palette.main)
                            }.padding()
                        }
                        
                        Divider()
                        
                        
                        
                        Spacer()
                    }
                    
                }
                
                
            }
            .animation(.spring())
            .navigationBarHidden(true)
            .onAppear{
                self.updateView.toggle()
                let center = UNUserNotificationCenter.current()
                
                center.getNotificationSettings{settings in
                    if settings .authorizationStatus == .authorized{
                        showNotification = true
                    }
                    else{
                        showNotification = false
                    }
                }
            }
            .navigationTitle("Perfil")
        }.accentColor(palette.main)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(name: "Salumalatrix")
    }
}

