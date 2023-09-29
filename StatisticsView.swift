//
//  StatisticsView.swift
//  exploPersistingData
//
//  Created by Daryl FELIX on 08.09.23.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    @Binding var competitions: [Competitions]
    struct TLSPEvolution: Identifiable {
        var id = UUID()
        var hole: String
        var tlsp: Float

    }
    
    
    let tlspdata = [
        TLSPEvolution(hole:"", tlsp:0.0)
    ]
    
    struct ScoreEvolution: Identifiable {
        var id = UUID()
        
        var hole: String
        var score: Int
    }
    let data = [
        ScoreEvolution(hole:"", score:0)
    ]

    
    func cumulScore() -> [ScoreEvolution] {
        var d = data
        let c = competitions.count - 1
        var h: String
        var s: Int
        var cumul: Int = 0
        for i in 0...c {
            h = "h\(competitions[i].details.hole)"
            s = competitions[i].details.score
            cumul = cumul + s
            d.append(ScoreEvolution(hole:h, score:cumul))
        }

        print(data.count)
        d.remove(at: 0)
        return d
    }
    

    func parBrk() -> [ScoreEvolution] {
        var d = data
        let c = competitions.count - 1
        var eagle: Int = 0
        var birdie: Int = 0
        var par: Int = 0
        var bogey: Int = 0
        var bogey2: Int = 0
        var over: Int = 0
        
        for i in 0...c {
            let sco = competitions[i].details.score
            switch sco  {
            case -2:
                eagle = eagle + 1
            case -1:
                birdie = birdie  + 1
            case 0:
                par = par + 1
            case 1:
                bogey = bogey + 1
            case 2:
                bogey2 = bogey2 + 1
            default:
                over = over + 1
            }
            
        }
        d.append(ScoreEvolution(hole:"eagle", score:eagle))
        d.append(ScoreEvolution(hole:"birdie", score:birdie))
        d.append(ScoreEvolution(hole:"par", score:par))
        d.append(ScoreEvolution(hole:"bogey", score:bogey))
        d.append(ScoreEvolution(hole:"bogey2", score:bogey2))
        d.append(ScoreEvolution(hole:"over", score:over))
        
        print(data.count)
        d.remove(at: 0)
        return d

    }

    
    
    func cumulTLSP() -> [TLSPEvolution] {
        var d = tlspdata
        let c = competitions.count - 1
        var h: String
        var t: Float = 0.0
        for i in 0...c {
            h = "h\(competitions[i].details.hole)"
            t = (competitions[i].details.tlsp_t + competitions[i].details.tlsp_l + competitions[i].details.tlsp_s + competitions[i].details.tlsp_p) / 4
            d.append(TLSPEvolution(hole:h, tlsp:t))
            
        }
        d.remove(at: 0)
        return d
    }
    

    var body: some View {
        VStack {
            
            Text("Day Performances: \(competitions.count) holes").font(.headline)
            if competitions.count > 0 {
                Chart {
                    ForEach(cumulScore()) { datum in
                        LineMark(x: .value("hole", datum.hole), y: .value("score", datum.score))
                        //.opacity(.infinity)
                            .foregroundStyle(Color.black)
                        
                    }
                }
                Text("TLSP Performance Chart").font(.headline)
                Chart {
                    ForEach(cumulTLSP()) { datum in
                        BarMark(x: .value("hole", datum.hole), y: .value("score", datum.tlsp))
                            .foregroundStyle(Color.gray)
                    }
                }
                Text("Holes Results").font(.headline)
                Chart {
                    ForEach(parBrk()) { datum in
                        BarMark(x: .value("hole", datum.hole), y: .value("score", datum.score))
                            .foregroundStyle(Color.gray)
                            .annotation(position: .overlay, alignment: .center) {
                                Text("\(datum.score)")
                            }
                    }
                }
                
            .background(Image("background_tlsp")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                         //.scaledToFit()
                .opacity(0.9)
                .brightness(0.64)
            )
            } else {
                Text("You need a minimum of 1 hole to display game statistic.")
            }
        
        }

    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(competitions: .constant(Competitions.sampleData))
    }
}
