//
//  ContentView.swift
//  Two Minute Tea Timer
//
//  Created by Nico Bertsch on 14.03.21.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @ObservedObject var timerModel = TimerModel(startDuration: 120)
    let myColors = MyColors()

    var body: some View {
        
        ZStack {
            // Background Color
            Color(#colorLiteral(red: 0.9921568627, green: 0.9450980392, blue: 0.8392156863, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            Pulsation(pulsColor: myColors.pulsColor)
            Track(trackColor: myColors.backgroundColor)
            progressCircle(progressColor: myColors.progressBarColor, circleColor: myColors.circleColor, percentage: timerModel.getPercentage())
            
            Button(action: { timerModel.startTimer()
            })
            {
                Text(timerModel.getTime())
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .foregroundColor(myColors.timerButtonColor)
                    .padding()
            }
            .onAppear(perform: {
                timerModel.startTimer()
            })
        }
    }
}

struct progressCircle: View {
    let progressColor: Color
    let circleColor: Color
    let percentage: CGFloat
    var colors: [Color] {
        return [progressColor]
    }

    var body: some View {
        Circle()
            .fill(circleColor)
            .frame(width: 220, height: 220, alignment: .center)
            .overlay(
                Circle()
                    .trim(from: 0.0, to: percentage * 0.01)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .fill(AngularGradient(gradient: Gradient(colors: colors), center: .center, startAngle: .zero, endAngle: .init(degrees: 360)))
                    .frame(width: 200, height: 200, alignment: .center)
            ).animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0))
    }
}

struct Track: View {
    let trackColor: Color
    var percentage: CGFloat = 50
    var colors: [Color] {
        return [trackColor]
    }
    var body: some View {
        ZStack {
            Circle()
                .fill(trackColor)
                .frame(width: 200, height: 200)
                .overlay(
                 Circle()
                    .stroke(lineWidth: 20)
                    .fill(AngularGradient(gradient: .init(colors: colors), center: .center))
                )
        }
    }
}

struct Pulsation: View {
    @State private var pulsate = false
    let pulsColor: Color
    var colors: [Color] {
        [pulsColor]
    }
    var body: some View {
        ZStack{
            Circle()
                .fill(pulsColor)
                .frame(width: 220, height: 220)
                .scaleEffect(pulsate ? 1.2 : 1.0)
                .animation(Animation.easeInOut(duration: 1.1).repeatForever(autoreverses: true))
                .onAppear {
                    pulsate.toggle()
                }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
