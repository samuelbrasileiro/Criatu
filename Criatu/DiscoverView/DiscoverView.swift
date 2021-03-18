//
//  DiscoverView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI

struct DiscoverView: View {
    
    @ObservedObject var palette = Palette.shared
    @ObservedObject var bank: DiscoverBank
    @State var index = 0
    
    var body: some View {
        NavigationView{
            
            VStack{
                SearchBarView(bank: bank)
                ZStack{
                    ZStack(alignment: .bottom) {
                        VStack {
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                LazyHStack{//list of USER'S INTERESTS
                                    ForEach(0..<bank.interests.count, id: \.self){ index in
                                        InterestView(item: bank.interests[index], delegate: bank)
                                    }
                                }.frame(height: 50)
                                .padding(.leading)
                            }
                            LazyWaterfallGrid(data: bank.items, numberOfColumns: 2, horizontalSpacing: 8, verticalSpacing: 8, edgeInsets: EdgeInsets(top: 10, leading: 10, bottom: 75, trailing: 10)){ item in
                                
                                BasicItemView(item: item, delegate: bank)
                                
                                
                            }.background(Color(.systemGray6))
                        }
                        Button(action: {
                            self.bank.discoverStyle()
                        }){
                            Text("Combinar")
                                .padding()
                                .padding(.horizontal, 80)
                                .background(bank.items.filter({$0.isSelected}).count == 0 ? Color(.systemGray3) : palette.main)
                                .foregroundColor(Color(.systemBackground))
                                .cornerRadius(15)
                                .shadow(radius: 7)
                            
                            
                        }
                        .disabled(bank.items.filter({$0.isSelected}).count == 0)
                        .offset(y: bank.isDiscovering ? 300 : 0)
                        .padding(10)
                    }
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(30)
                        .background(Color(.systemBackground))
                        .cornerRadius(20)
                        .opacity(self.bank.isDiscovering ? 1 : 0)
                }
                if let style = bank.discoveredStyle{
                    NavigationLink( destination: DiscoveredStyleView(style: style), isActive: $bank.didDiscoverNewStyle){
                        EmptyView()
                    }
                }
                
                
            }
            .navigationBarTitle("Descubra")
            .navigationBarHidden(true)
            .onAppear{
                if bank.didDiscoverNewStyle || Interest.restore()!.contains(where: { cdInterest in !bank.interests.contains(where: {$0.attributes.id == cdInterest.attributes.id})}){
                    bank.clear()
                    bank.addInterests()
                }
                
            }
            
            .alert(isPresented: $bank.didNotDiscoverStyle, content: {
                Alert(title: Text("Algo deu errado..."), message: Text("Tente de novo adicionando mais itens!"), dismissButton: .default(Text("Beleza"), action: {
                    self.bank.clear()
                    self.bank.addInterests()
                }))
                
            })
            .animation(.spring())
        }.accentColor(palette.main)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(bank: DiscoverBank.shared)
    }
}
