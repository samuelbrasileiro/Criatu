////
////  ScrollView.swift
////  Criatu
////
////  Created by Alanis Lima Santa Clara on 26/11/20.
////
//
//import SwiftUI
//
//struct ScrollView: View {
//
//
//    struct CircleView: View {
//        @State var label: String
//
//        var body: some View {
//            ZStack {
//                Circle()
//                    .fill(Color.yellow)
//                    .frame(width: 70, height: 70)
//                Text(label)
//            }
//        }
//    }
//
//    var body: some View {
//        VStack {
//            Divider()
//            ScrollView(.horizontal) {
//                HStack(spacing: 10) {
//                    ForEach(0..<10) { index in
//                        CircleView(label: "\(index)")
//                    }
//                }.padding()
//            }.frame(height: 100)
//            Divider()
//            Spacer()
//        }
//    }
//}
//
////
////    ScrollView(Axis.Set.horizontal , showsIndicators: true) {
////        HStack{
////            ForEach(self.itensAleatorios , id: \.self) { item in
////                Circle()
////                    .fill(item)
////                    .frame(width: 100, height: 100)
////
////            }
////        }
////    }
//
//struct ScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollView()
//    }
//}
//
