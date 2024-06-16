//
//  ProgramView.swift
//  trainertest
//
//  Created by Oplayer on 01.06.2024.
//

import SwiftUI

struct ProgramView: View {
    var programData: ProgramData
    var body: some View {
            Text("")
                .frame(width: 313, height: 120)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.white, lineWidth: 4)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.black)
                        )
                        .overlay(
                            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                                VStack(alignment: .center, spacing: 10){
                                    Text(programData.name)
                                        .font(.custom("Khand-SemiBold",size: 18))
                                        .foregroundColor(.white)
                                    Text(programData.smallInfo)
                                        .frame(width: 212, height: 47)
                                        .font(.custom("Khand-Regular",size: 14))
                                        .foregroundColor(.gray)
                                        
                                }
                                
                                Text(programData.emoji)
                                    .font(.custom("Khand-SemiBold",size: 36))
                                    .frame(width: 40, height: 40)
                                    .accentColor(.white)
                                
                            }
                        )
                )
        }
    }


#Preview {
    ProgramView(programData: ProgramData(name: "name", smallInfo: "smallinfo", info: "info info", workout: "workout", emoji: "🏋️‍♂️"))
}
