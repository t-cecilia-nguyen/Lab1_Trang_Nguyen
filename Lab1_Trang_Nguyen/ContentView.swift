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
        }
        .padding()

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
