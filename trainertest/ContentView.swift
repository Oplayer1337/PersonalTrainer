//
//  ContentView.swift
//  trainertest
//
//  Created by Oplayer on 28.05.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .frame(height: 120.0)
            
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Сеня соси")
                .fontWeight(.thin)
            
            Image("Sentx")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            
            Text("лооол ну ты и даун дебил")
                .fontWeight(.bold)
                .foregroundColor(Color.pink)
                .padding(.bottom)
                .frame(width: 300.0, height: 200.0)
                /*.position(CGPoint(x: 180.0, y: 650.0))*/
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
