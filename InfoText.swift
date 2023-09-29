//
//  InfoText.swift
//  exploPersistingData
//
//  Created by Daryl FELIX on 08.09.23.
//

import SwiftUI

struct InfoText: View {
    let t1: String = "T.L.S.P suits for Tee shot, long game, chipping & putting. It's the way to rate a hole on the 4 area of game if relevant"
    let t2: String = "The issue is to rate each compartment played on a hole with a value from minus 2 (-2) to plus 3 (+3)."
    
    let t3: String = "To rate the outcome of a shot, you should simply think about the advantage or disadvantage the shot will give you for the next one. A bast shipping (worst contact) but less then 1 feet to the hole 'given' will have a good rate. At the opposite, a well touched ship but the ball take the hill a go out of the green will be badly rated."
    
    let t4:String = "An exceptional outcome as a ship in (no need to put), a hole in one or a long shot dunked will be rated 3 points. A very good shot which will clearly give an advantage for the next one as a ship 'given' or a super tee shot will be rated 2 points. A normal shot without advantage or disadvantage will be qualify as 1. 0 (zero) is not playable area (or not applicatbale) - probably no long shot on a par 3. -1 will the rate when you are in dificulty but can do something. -2 is the rate for a penalty zone, a OB or a ball in a bush or behind a tree without any solution other a short recovery shot."
    
    var body: some View {
        VStack {
            Text("What is T.L.S.P ?")
                .font(.largeTitle)
            Text(t1).frame(maxWidth: .infinity, alignment: .leading)
            Divider()
                //.padding(5)
            Text(t2).frame(maxWidth: .infinity, alignment: .leading)
                //.padding(5)
            Divider()
            Text(t3).frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Divider()
            Text(t4).frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            
        }
        .padding(10)
        .cornerRadius(8)
        .background(Image("background_tlsp")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                //.scaledToFit()
                .opacity(0.9)
                .brightness(0.74)
        )

    }
}

struct InfoText_Previews: PreviewProvider {
    static var previews: some View {
        InfoText()
    }
}
