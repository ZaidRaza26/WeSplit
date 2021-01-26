//
//  ContentView.swift
//  WeSplit
//
//  Created by Zaid Raza on 15/08/2020.
//  Copyright © 2020 Zaid Raza. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var zeroTip = false
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    
    @State private var tipPercentage = 2
    
    let tipPercentages = [0,5,10,15,20,25,30,35,40]
    
    var totalPerPerson : Double{
        
        let peopleCount = Double(numberOfPeople) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount * (tipSelection / 100)
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalPlusTip : Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount * (tipSelection / 100)
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }
    
    var body : some View{
        
        NavigationView{
            
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of People", text: $numberOfPeople).keyboardType(.numberPad)
                }
                .navigationBarTitle("WeSplit")
                
                Section(header: Text("How much tip do you want to leave?")){
                    Picker("Tip percentage" ,selection: $tipPercentage){
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onTapGesture {
                        let tipSelection = Double(self.tipPercentages[self.tipPercentage])
                        let orderAmount = Double(self.checkAmount) ?? 0
                        let tipValue = orderAmount * (tipSelection / 100)
                        if Int(tipValue) == 0 {
                            self.zeroTip = true
                        }
                        else{
                            self.zeroTip = false
                        }
                    }
                }
                
                Section(header: Text("Amount Per Person")){
                    Text("$\(totalPerPerson ,specifier: "%.2f")").foregroundColor(zeroTip ? .red : .blue)
                }
                
                Section(header: Text("Total amount plus tip")){
                    Text("$\(totalPlusTip ,specifier: "%.2f")")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
