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
    var body: some View {
        VStack {
            Text("\(currentNumber)")
                .font(.system(size: 60, weight: .bold))
            VStack {
                Button(action:  { checkAnswer(isPrimeSelected: true) }) {
                    Text("Prime")
                        .frame(width: 100, height: 100)
                        .font(.system(size: 40))
                }
                Button(action: { checkAnswer(isPrimeSelected: false) }) {
                    Text("Not Prime")
                        .frame(width: 200, height: 100)
                        .font(.system(size: 40))
                }
            }
        }
        .padding()
        
        if showResponse {
            Text(isCorrect ? "Correct" : "Wrong")
                .font(.system(size: 50))
        }
        
    }
    // Check if prime
    func isPrime(_ number: Int) -> Bool {
        return number > 1 && !(2..<number).contains { number % $0 == 0 }
    }
    
    // Check answer
    func checkAnswer(isPrimeSelected: Bool) {
        let isPrime = isPrime(currentNumber)
        isCorrect = (isPrime == isPrimeSelected)
        showResponse = true
    }
}

#Preview {
    ContentView()
}
