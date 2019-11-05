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
  
  var body: some View {
    ZStack {
      Color(red: 31 / 255,
            green: 56 / 255,
            blue: 100 / 255)
        .edgesIgnoringSafeArea(.all)
      VStack(spacing: 30) {
        VStack {
          Text("Tap the flag of")
            .foregroundColor(.white)
          Text(countries[correctAnswer])
            .foregroundColor(.white)
        }
        
        ForEach(0 ..< 3) { number in
          Button(action: {
            self.flagTapped(number)
          }) {
            Image(self.countries[number])
              .renderingMode(.original)
          }
        }
        Spacer()
      }
    }.alert(isPresented: $showingScore) {
      Alert(title: Text(scoreTitle),
            message: Text("Your score is ???"),
            dismissButton: .default(Text("Continue")) {
              self.askQuestion()
        })
    }
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      print("flagTapped - Correct")
    } else {
      scoreTitle = "Wrong"
      print("flagTapped - Wrong")
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
