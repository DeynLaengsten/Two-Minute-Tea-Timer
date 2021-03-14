//
//  ContentView.swift
//  Two Minute Tea Timer
//
//  Created by Nico Bertsch on 14.03.21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var timerModel = TimerModel()
    
    var body: some View {
        
        Text(timerModel.getTime())
            .padding()
    
            .onAppear(perform: {
                timerModel.startTimer()
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
