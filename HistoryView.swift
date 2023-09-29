//
//  HistoryView.swift
//  exploPersistingData
//
//  Created by Daryl FELIX on 15.09.23.
//

import SwiftUI
import Charts


struct HistoryView: View {
    @Binding var history: [History]
    
    
    struct DataPoints: Identifiable {
        var id = UUID()
        var dp: String
        var point: Float
    }
    // init an empty structure
    let data = [
        DataPoints(dp:"0", point:0.0)
    ]

    func GetHistoricalPointsBreakdown() -> [DataPoints] {
        var d = data
        
        var minus2: Float = 0
        var minus1: Float = 0
        var plus1: Float = 0
        var plus2: Float = 0
        var plus3: Float = 0

        let c = history.count - 1
        
        for i in 0...c {
            var sco = history[i].details.tlsp_t
            if sco != 0 {
                switch sco  {
                case -2:
                    minus2 += 1
                case -1:
                    minus1 += 1
                case 1:
                    plus1 += 1
                case 2:
                    plus2 += 1
                default:
                    plus3 += 1
                }
            }
 
            sco = history[i].details.tlsp_l
            if sco != 0 {
                switch sco  {
                case -2:
                    minus2 += 1
                case -1:
                    minus1 += 1
                case 1:
                    plus1 += 1
                case 2:
                    plus2 += 1
                default:
                    plus3 += 1
                }
            }

            sco = history[i].details.tlsp_s
            if sco != 0 {
                switch sco  {
                case -2:
                    minus2 += 1
                case -1:
                    minus1 += 1
                case 1:
                    plus1 += 1
                case 2:
                    plus2 += 1
                default:
                    plus3 += 1
                }
            }

            sco = history[i].details.tlsp_p
            if sco != 0 {
                switch sco  {
                case -2:
                    minus2 += 1
                case -1:
                    minus1 += 1
                case 1:
                    plus1 += 1
                case 2:
                    plus2 += 1
                default:
                    plus3 += 1
                }
            }

            
            
            
        }
        
        d.append(DataPoints(dp:"-2", point:minus2))
        d.append(DataPoints(dp:"-1", point:minus1))
        d.append(DataPoints(dp:"+1", point:plus1))
        d.append(DataPoints(dp:"+2", point:plus2))
        d.append(DataPoints(dp:"+3", point:plus3))
        
        print(data.count)
        d.remove(at: 0)
        return d

        
    }
    

    func GetHistoricalPoints() -> [DataPoints] {
        var d = data
        let c = history.count - 1
        var dp = 0
        for i in 0...c {
            if history[i].details.tlsp_t != 0 {
                dp += 1
                d.append(DataPoints(dp:"\(dp)", point: history[i].details.tlsp_t))
            }
            if history[i].details.tlsp_l != 0 {
                dp += 1
                d.append(DataPoints(dp:"\(dp)", point: history[i].details.tlsp_l))
            }
            if history[i].details.tlsp_s != 0 {
                dp += 1
                d.append(DataPoints(dp:"\(dp)", point: history[i].details.tlsp_s))
            }
            if history[i].details.tlsp_p != 0 {
                dp += 1
                d.append(DataPoints(dp:"\(dp)", point: history[i].details.tlsp_p))
            }


        }
        print(data.count)
        d.remove(at: 0)
        return d

    }
    
    
    var controler_title: String = "vide"
    var body: some View {
        VStack {
            //Spacer()
            Text("Historical Data")
                .font(.largeTitle)
            Text("Your historical data contains \(history.count) holes")
            Text("Your historical data contains \(GetHistoricalPoints().count) shots")
            
            //
            Chart {
                ForEach(GetHistoricalPoints()) { datum in
                    LineMark(x: .value("hole", datum.dp), y: .value("score", datum.point))
                        .interpolationMethod(.catmullRom)
                    //.opacity(.infinity)
                        .foregroundStyle(Color.black)
                    
                }
            }
            Divider()
            HStack {
                Chart {
                    ForEach(GetHistoricalPointsBreakdown()) { datum in
                        BarMark(x: .value("hole", datum.dp), y: .value("score", datum.point))
                            .foregroundStyle(Color.gray)
                            .annotation(position: .overlay, alignment: .center) {
                                Text("\(Int(datum.point))")
                            }
                    }
                }
                Divider()
                Chart {
                    ForEach(GetHistoricalPointsBreakdown()) { datum in
                        BarMark(x: .value("hole", datum.dp), y: .value("score", datum.point))
                            .foregroundStyle(Color.blue)
                            .annotation(position: .overlay, alignment: .center) {
                                Text("\(Int(datum.point))")
                            }
                    }
                }

            }
            Spacer()
        }.background(Image("background_tlsp")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            //.scaledToFit()
            .opacity(0.9)
            .brightness(0.74)
        )
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(history: .constant(History.sampleData), controler_title: "")
    }
}
