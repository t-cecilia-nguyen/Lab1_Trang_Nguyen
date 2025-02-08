//
//  ContentView.swift
//  Lab1_Trang_Nguyen
//
//  Created by Trang Nguyen on 2025-02-08.
//

import SwiftUI

struct ContentView: View {
    @State private var currentNumber: Int = Int.random(in: 1...1000)
    @State private var showResponse: Bool = false
    @State private var isCorrect: Bool = false
    var body: some View {
        VStack {
            Text("\(currentNumber)")
                .font(.system(size: 60, weight: .bold))
            VStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Prime")
                        .frame(width: 100, height: 100)
                        .font(.system(size: 40))
                }
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
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
}

#Preview {
    ContentView()
}
