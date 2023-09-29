//
//  TlspView.swift
//  exploPersistingData
//
//  Created by Daryl FELIX on 09.09.23.
//

import SwiftUI
import Charts


struct TlspView: View {
    @Binding var competitions: [Competitions]
    let colors: [Int: Color] = [-2: .red, -1: .red, 0: .white, 1: .brown, 2: .green, 3: .green]
    
    struct TLSPEvolution: Identifiable {
        var id = UUID()
        var shot: String
        var tlsp: Float

    }
    
    let tlspdata = [
        TLSPEvolution(shot:"", tlsp:0.0)
    ]
    
    func cumulTLSP() -> [TLSPEvolution] {
        var d = tlspdata
        let c = competitions.count - 1
        var h: String
        var tot_tlsp: Float = 0.0
        
        for i in 0...c {
            var a: Int = 1
            h = "h\(competitions[i].details.hole)\(a)"
            d.append(TLSPEvolution(shot:h, tlsp:competitions[i].details.tlsp_t + tot_tlsp))
            tot_tlsp = competitions[i].details.tlsp_t + tot_tlsp
            
            if competitions[i].details.tlsp_l != 0 {
                a = a + 1
                h = "h\(competitions[i].details.hole)\(a)"
                d.append(TLSPEvolution(shot:h, tlsp:competitions[i].details.tlsp_l + tot_tlsp))
                tot_tlsp = competitions[i].details.tlsp_l + tot_tlsp
            }

            if competitions[i].details.tlsp_s != 0 {
                a = a + 1
                h = "h\(competitions[i].details.hole)\(a)"
                d.append(TLSPEvolution(shot:h, tlsp:competitions[i].details.tlsp_s + tot_tlsp))
                tot_tlsp = competitions[i].details.tlsp_s + tot_tlsp
            }
            
            if competitions[i].details.tlsp_p != 0 {
                a = a + 1
                h = "h\(competitions[i].details.hole)\(a)"
                d.append(TLSPEvolution(shot:h, tlsp:competitions[i].details.tlsp_p + tot_tlsp))
                tot_tlsp = competitions[i].details.tlsp_s + tot_tlsp
            }

        }
        d.remove(at: 0)
        return d
    }
    
    var body: some View {
        VStack {
            Text("Day Performances: \(competitions.count) holes").font(.headline)
            if competitions.count > 1 {
                Chart {
                    ForEach(cumulTLSP()) { datum in
                        LineMark(x: .value("hole", datum.shot), y: .value("score", datum.tlsp))
                            .interpolationMethod(.catmullRom)
                        //.opacity(.infinity)
                            .foregroundStyle(.gray)
                        
                    }
                }
                .chartXAxis {
                    AxisMarks(
                        //format: Decimal.FormatStyle.Percent.percent.scale(1),
                        values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
                        
                    ) {
                        AxisGridLine()
                    }
                }
            } else {
                Text("You need a minimum of 2 holes to display the TLSP statistics")
                    .font(.headline)
            }
        }                   .background(Image("background_tlsp")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            //.scaledToFit()
            .opacity(0.9)
            .brightness(0.64)
        )

        
        
        
        
    }
}


