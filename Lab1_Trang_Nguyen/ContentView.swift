//
//  ContentView.swift
//  Lab1_Trang_Nguyen
//
//  Created by Trang Nguyen on 2025-02-08.
//

import SwiftUI

struct ContentView: View {
    private let numberRange = 1...10 // Change range
    
    @State private var currentNumber: Int = Int.random(in: 1...10) // Inital range
    @State private var showResponse: Bool = false
    @State private var isCorrect: Bool = false
    @State private var correctAnswers: Int = 0
    @State private var incorrectAnswers: Int = 0
    @State private var attempts: Int = 0
    @State private var score: Bool = false
    @State private var timeRemaining = 5
    @State private var pauseTimer = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let backgroundColor = Color(red: 244/255, green: 248/255, blue: 211/255)
    
    let gradientColor = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 247/255, green: 207/255, blue: 216/255),
            Color(red: 115/255, green: 199/255, blue: 199/255)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
        )
    
    var body: some View {
        
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("\(currentNumber)")
                    .font(.system(size: 60, weight: .bold))
                    .padding(.bottom, 100)
                
                Button(action:  { checkAnswer(isPrimeSelected: true) }) {
                    Text("Prime")
                        .font(.system(size: 40))
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                        .background {
                            Capsule()
                                .stroke(gradientColor, lineWidth: 5)
                                .saturation(2)
                        }
                        
                }
                
                Button(action: { checkAnswer(isPrimeSelected: false) }) {
                    Text("Not Prime")
                        .font(.system(size: 40))
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                        .background {
                            Capsule()
                                .stroke(gradientColor, lineWidth: 5)
                                .saturation(2)
                        }
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
                        .font(.system(size: 97))
                }
                
                Text("Time Remaining: \(timeRemaining)")
                    .foregroundColor(.red)
                
            }
            .alert(isPresented: $score) {
                Alert(
                    title: Text("Final Score"),
                    message: Text("Correct Answers: \(correctAnswers)\nIncorrect Answers: \(incorrectAnswers)"),
                    dismissButton: .default(Text("New Game"), action: {
                        pauseTimer = false
                        newGame()
                    })
                )
            }
            .onReceive(timer) { _ in
                if !pauseTimer && timeRemaining > 0 {
                    timeRemaining -= 1
                } else if !pauseTimer {
                    wrongAnswer()
                }
            }
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
        pauseTimer = true
        
        if attempts % 10 == 0 {
            pauseTimer = true
            score = true
        } else {
            changeNumber()
        }
    }
    
    // Start new game
    func newGame() {
        correctAnswers = 0
        incorrectAnswers = 0
        attempts = 0
        currentNumber = Int.random(in: numberRange)
        showResponse = false
        pauseTimer = false
        timeRemaining = 5
    }
    
    // Change number
    func changeNumber() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showResponse = false
            self.currentNumber = Int.random(in: numberRange)
            self.pauseTimer = false
            self.timeRemaining = 5

        }
    }
    
    // Record wrong answer
    func wrongAnswer() {
        attempts += 1
        incorrectAnswers += 1
        
        isCorrect = false
        showResponse = true
        pauseTimer = true
        
        if attempts % 10 == 0 {
            pauseTimer = true
            score = true
        } else {
            changeNumber()
        }
    }
}
    

#Preview {
    ContentView()
}
