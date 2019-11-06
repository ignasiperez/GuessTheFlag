//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by ignasi - Swiftland.training on 05/11/2019.
//  Copyright © 2019 Swiftland. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var countries = ["Estonia",
                                  "France",
                                  "Germany",
                                  "Ireland",
                                  "Italy",
                                  "Nigeria",
                                  "Poland",
                                  "Russia",
                                  "Spain",
                                  "UK",
                                  "US"].shuffled()
  
  @State private var correctAnswer = Int.random(in: 0...2)
  
  @State private var showingScore = false
  @State private var scoreTitle = ""
  
  @State private var score = 0
  
  
  var body: some View {
    ZStack {
      //      Color(red: 31 / 255,
      //            green: 56 / 255,
      //            blue: 100 / 255)
      //        .edgesIgnoringSafeArea(.all)
      LinearGradient(
        gradient: Gradient(colors: [Color(red: 31 / 255,
                                          green: 56 / 255,
                                          blue: 100 / 255),
                                    .black]),
        startPoint: .top,
        endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
      VStack(spacing: 50) {
        VStack {
          Text("Tap the flag of")
            .foregroundColor(.white)
            .font(.title)
          Text(countries[correctAnswer])
            .foregroundColor(.white)
            .font(.largeTitle)
            .fontWeight(.bold)
        }
        
        ForEach(0 ..< 3) { number in
          Button(action: {
            self.flagTapped(number)
          }) {
            Image(self.countries[number])
              .renderingMode(.original)
          }
          .clipShape(Capsule())
          .overlay(Capsule().stroke(
            Color.black,
            lineWidth: 1))
            .shadow(color: .gray, radius: 10)
        }
        Text("Your score is \(score) points")
          .foregroundColor(.white).font(.title)
        Spacer()
      }
    }.alert(isPresented: $showingScore) {
      Alert(title: Text(scoreTitle),
            message: Text("Your score is \(score) points"),
            dismissButton: .default(Text("Continue")) {
              self.askQuestion()
        })
    }
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      score += 1
    } else {
      scoreTitle = "Wrong! That’s the flag of \(countries[number])"
    }
    
    showingScore = true
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
