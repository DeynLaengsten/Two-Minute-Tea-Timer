//
//  ContentView.swift
//  Two Minute Tea Timer
//
//  Created by Nico Bertsch on 14.03.21.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @ObservedObject var timerModel = TimerModel()
    
    var body: some View {
        
        ZStack {
            Circle()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200, alignment: .center)
                .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
            Circle()
                .trim(from: 0.0, to: 1.0)
                .fill(Color.blue, style: FillStyle())
                .frame(width: 200, height: 200, alignment: .center)
                
            Button(action: { timerModel.startTimer()
            })
            {
                Text(timerModel.getTime())
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .padding()
            }
            
            .onAppear(perform: {
                timerModel.startTimer()
        })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
