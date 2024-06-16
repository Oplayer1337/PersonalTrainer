//
//  BaseProgram.swift
//  trainertest
//
//  Created by Oplayer on 05.06.2024.
//

import SwiftUI

struct BaseProgram: View {
    var programData: ProgramData
//    var name: String
//    var info: String
//    var workout: String
    var body: some View {
        Rectangle()
            .scaledToFill()
            .background(Color.black)
            .foregroundColor(.black)
            .overlay{
        ScrollView{
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30){
                Text(programData.name)
                    .foregroundColor(.white)
                    .font(.custom("Khand-Light",size: 42))
                    .kerning(6)
                    .frame(maxWidth: 393)
                
                Rectangle()
                    .frame(maxWidth: 200, maxHeight:2)
                    .frame(alignment: .bottom)
                    .background(Color.gray)
                    .foregroundColor(.gray)
                
                Text(programData.workout)
                    .foregroundColor(.white)
                    .font(.custom("Khand-Medium",size: 24))
                    .kerning(2)
                    .frame(maxWidth: 393)
                    
                Rectangle()
                    .frame(maxWidth: 200, maxHeight:2)
                    .frame(alignment: .bottom)
                    .background(Color.gray)
                    .foregroundColor(.gray)
                    
                Text(programData.info)
                    .foregroundColor(.gray)
                    .font(.custom("Khand-Regular",size: 20))
                    .kerning(2)
                    .frame(maxWidth: 393)
                
                
                
                }
            }
        }
        .background(Color.black)
        .accentColor(.black)
        
    }
}

#Preview {
    BaseProgram(programData: ProgramData(name: "name", smallInfo: "", info: "info about that set, how is it that good and super cool", workout: "12 sets of squats\n5 sets of pols\n3 sets of EMOM workout", emoji: "🏋️‍♂️"))
}
