//
//  ImageCaro.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-05-01.
//

import SwiftUI



struct ImageCaro: View {
    private var numberOfImages = 5
    private var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    
    var body: some View {
        
        VStack{
        Text("About Us").font(.headline)
        }
        GeometryReader { proxy in
        TabView(selection: $currentIndex){
            ForEach(0..<numberOfImages){
                num in
                Image("\(num)")
                    .resizable()
                    .scaledToFill()
                    .tag(num)
                    .overlay(Color.black.opacity(0.4))
            }
        }.tabViewStyle(PageTabViewStyle())
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding()
//                .frame(width: proxy.size.width, height: proxy.size.height / 3)
                .onReceive(timer, perform: { _ in
                    withAnimation{
                    currentIndex = currentIndex < numberOfImages ? currentIndex + 1 : 0
                    }
                })
    }
        Text("Established in 2008, CyberTek Computer Solutions has strived to be one of the leading retailers for branded & customizable computers and related products in today’s market. Our many years of experience has provided us with the expertise to cater you; our valued customers with the latest technology").font(.body).padding()
        
        
    
    }
}

struct ImageCaro_Previews: PreviewProvider {
    static var previews: some View {
        ImageCaro()
    }
}
