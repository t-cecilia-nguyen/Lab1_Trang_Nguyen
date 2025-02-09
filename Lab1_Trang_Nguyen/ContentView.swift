//
//  ContentView.swift
//  Lab1_Trang_Nguyen
//
//  Created by Trang Nguyen on 2025-02-08.
//

import SwiftUI

struct ContentView: View {
    @State private var currentNumber: Int = Int.random(in: 1...10)
    @State private var showResponse: Bool = false
    @State private var isCorrect: Bool = false
    @State private var correctAnswers: Int = 0
    @State private var incorrectAnswers: Int = 0
    @State private var attempts: Int = 0
    @State private var score: Bool = false
    
    var body: some View {

        VStack(spacing: 50) {
            Text("\(currentNumber)")
                .font(.system(size: 60, weight: .bold))
            
            Button(action:  { checkAnswer(isPrimeSelected: true) }) {
                Text("Prime")
                    .font(.system(size: 40))
            }
            
            Button(action: { checkAnswer(isPrimeSelected: false) }) {
                Text("Not Prime")
                    .font(.system(size: 40))
            }
            
            
            if showResponse {
                if isCorrect {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        .font(.system(size: 125))
                } else {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .font(.system(size: 125))
                }
            } else {
                Text(" ")
                    .font(.system(size: 100))
            }
            

                // For Testing - Remove
                Text("\(correctAnswers)")
                Text("\(incorrectAnswers)")
                Button ("New") {
                    currentNumber = Int.random(in: 1...10)
                }
        }
        .alert(isPresented: $score) {
            Alert(title: Text("Final Score"),
                  message: Text("Correct Answers: \(correctAnswers)\nIncorrect Answers: \(incorrectAnswers)"),dismissButton: .default(Text("OK"))
                
                  )
          }
        
    }
    // Check if prime
    func isPrime(_ number: Int) -> Bool {
        return number > 1 && !(2..<number).contains { number % $0 == 0 }
    }
    
    // Check answer
    func checkAnswer(isPrimeSelected: Bool) {
        let correct = isPrimeSelected == isPrime(currentNumber)
        updateScore(correct: correct)
    }
    
    // Update score
    func updateScore(correct: Bool) {
        attempts += 1
        if correct {
            correctAnswers += 1
        } else {
            incorrectAnswers += 1
        }
        
        isCorrect = correct
        showResponse = true
        
        if attempts % 10 == 0 {
            score = true
        }
    }
}


#Preview {
    ContentView()
}
