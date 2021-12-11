//
//  CheckOutView.swift
//  iDine
//
//  Created by Srinivas Sahu on 18/11/21.
//

import SwiftUI
import AlertToast

struct CheckOutView: View {
    //STATE AND ENVIRONMENT VARIABLES
    @EnvironmentObject var order:Order
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 15
    @State private var showingAlert = false
    @State var navigated = false
    
    let paymentTypes = ["Cash","Credit Card","iDine Points"]
    let tipAmounts = [10,15,20,25,0]
    var totalPrice:String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let total = Double(order.total)
        let tipValue = total / 100 * Double(tipAmount)
        return formatter.string(from: NSNumber(value: total + tipValue)) ?? "$0"
    }
    
    var body: some View {
        Form{
            
            //MARK: PAYMENT MODE INFO
            Section{
                Picker("How do you want to pay",selection: $paymentType){
                    ForEach(paymentTypes,id: \.self){
                        Text($0)
                    }
                }
                Toggle("Add iDine loyalty card",isOn: $addLoyaltyDetails.animation())
                if addLoyaltyDetails{
                    TextField("Enter your iDIne ID",text: $loyaltyNumber)
                }
            }
            
            //MARK: TIP PERCENTAGE
            Section(header:Text("Add a tip?")) {
                Picker("Percentage:",selection: $tipAmount){
                    ForEach(tipAmounts,id:\.self){
                        Text("\($0)%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            //MARK: TOTAL PRICE
            Section(header:Text("Total:\(totalPrice)")
                        .font(.largeTitle)
            ){
                Button("Confirm order"){
                    showingAlert.toggle()
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Order confirmed"), message: Text("Your total was: \(totalPrice)"), dismissButton: .default(Text("OK"), action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    
                })
            }))
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView()
            .environmentObject(Order())
    }
}

