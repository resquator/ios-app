//
//  CompetitionList.swift
//  exploPersistingData
//
//  Created by Daryl FELIX on 06.09.23.
//

import SwiftUI

struct CompetitionList: View {
    @Binding var competitions: [Competitions]
    var controler_title: String = "vide"

    let colors: [Int: Color] = [-2: .red, -1: .red, 0: .white, 1: .brown, 2: .green, 3: .green]

    func score_tlsp(t: Float, l: Float, s: Float, p: Float) -> String {
        var div_value: Float = 1
        if l != 0 {
            //long active
            if s != 0 {
                //short played
                if p != 0 {
                    div_value = 4
                } else {
                    div_value = 3
                }
            } else {
                // no short games
                div_value = 3
            }
        } else {
            // no long game
            if s != 0 {
                //short played
                if p != 0 {
                    div_value = 3
                } else {
                    div_value = 2
                }
            } else {
                // no short games
                div_value = 2
            }

        }
        

        print("div_value= \(div_value): \(t) \(l) \(s) \(p)  ")
        let perf = (t + l + s + p) / div_value
        return String(format: "%.1f", perf)
    }

    var body: some View {

        VStack {
            Text("Holes Played: \(competitions.count)")
            


                    Grid {
                        GridRow {
                            //Text("Date")
                            //Text("Compet")
                            Text("Hole")
                            Text("Par")
                            Text("S")
                            Text("TLSP")
                            Text("T")
                            Text("L")
                            Text("S")
                            Text("P")
                        }
                        .border(.bar)
                        ForEach(competitions) { compet in
                        GridRow {
                            //Text(compet.date_competition.formatted(.dateTime.day().month().year()))
                            //Text(compet.competition)
                            Text("\(compet.details.hole)")
                            //Text("\(compet.score)")
                            Text("\(compet.details.par)")
                            Text("\(compet.details.score)")
                            Text("\(score_tlsp(t: compet.details.tlsp_t, l: compet.details.tlsp_l, s: compet.details.tlsp_s, p: compet.details.tlsp_p))")
                            //Text("\(compet.date_competition.formatted()")
                            let t1 = compet.details.tlsp_t > 0 ? String(format: "+%.0f", compet.details.tlsp_t) : String(format: "%.0f", compet.details.tlsp_t)
                            let t2 = compet.details.tlsp_l > 0 ? String(format: "+%.0f", compet.details.tlsp_l) : String(format: "%.0f", compet.details.tlsp_l)
                            let t3 = compet.details.tlsp_s > 0 ? String(format: "+%.0f", compet.details.tlsp_s) : String(format: "%.0f", compet.details.tlsp_s)
                            let t4 = compet.details.tlsp_p > 0 ? String(format: "+%.0f", compet.details.tlsp_p) : String(format: "%.0f", compet.details.tlsp_p)

                            Text(t1)
                                //.font(.caption)
                                .padding(2)
                                .foregroundColor(.white)
                                .background(colors[Int(compet.details.tlsp_t), default: .clear])
                                .clipShape(Circle())
                            
                            Text(t2)
                                .padding(2)
                                .foregroundColor(.white)
                                .background(colors[Int(compet.details.tlsp_l), default: .clear])
                                .clipShape(Circle())
                            
                            Text(t3)
                                .padding(2)
                                .foregroundColor(.white)
                                .background(colors[Int(compet.details.tlsp_s), default: .clear])
                                .clipShape(Circle())
                            
                            Text(t4)
                                .padding(2)
                                .foregroundColor(.white)
                                .background(colors[Int(compet.details.tlsp_p), default: .clear])
                                .clipShape(Circle())
                            
                        }
                        
                    }




            }
        }.background(Image("background_tlsp")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            //.scaledToFit()
            .opacity(0.9)
            .brightness(0.64)
        )

    }
}

struct CompetitionList_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionList(competitions: .constant(Competitions.sampleData), controler_title: "")
    }
}
