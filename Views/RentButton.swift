//
//  RentButton.swift
//  Patinfly
//
//  Created by Xavier Romeu on 1/12/22.
//

import SwiftUI

struct RentButton: View {
    let label: String
    let buttonColor: Color
        
    var body: some View {
        Text(label)
            .foregroundColor(.white)
            .padding(.vertical, 20)
            .padding(.horizontal, 90)
            .background(buttonColor)
            .cornerRadius(10)
    }
}
