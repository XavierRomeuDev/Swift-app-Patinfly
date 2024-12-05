//
//  Condicions.swift
//  Patinfly
//
//  Created by Xavier Romeu on 7/10/22.
//

import SwiftUI

struct ConditionsView: View {

    var body: some View {
        VStack{
            Text("With the appearance of the electric scooter in city traffic, the law has responded as it usually does in such cases. First, a new, popular phenomenon arises. Second, owing to the risks and prolems arising from this phenomenon, users and legal practitioners see the need for regulation. And so also on this occasion, this new reality is gradually being regulated, at the European, national and local level.Because you do not need any authorization to use an electric scooter, scooter users, especially minors, may be unaware of the law applicable to the damage caused by scooters. EU and Spanish national and local authorities have done little to publicize the regulations applicable to the use of electric scooters and the fact that these rules can vary from place to place. For example, a trip across Madrid on an electric scooter will take you through areas with differing regultaions because local bylaws dictate what electric scooters are allowed and not allowed to do on the streets of each municipality.")
        }.padding(20)
         .padding(.vertical, 20)
    }
}

struct ConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        ConditionsView().previewInterfaceOrientation(.portrait)
        ConditionsView().previewInterfaceOrientation(.landscapeLeft)
    }
}
