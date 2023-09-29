//
//  CompetitionDetail.swift
//  exploPersistingData
//
//  Created by Daryl FELIX on 31.08.23.
//

import SwiftUI

struct CompetitionDetail: View {
    
    //let hls  = ["h01","h02"]
    
    enum Holes: Int, CaseIterable, Identifiable {
        case h01 = 1, h02 = 2
        , h03=3, h04=4, h05=5, h06=6, h07=7, h08=8, h09=9,
        h10=10, h11=11, h12=12, h13=13, h14=14, h15=15, h16=16, h17=17, h18=18
        
        var id: Self {self}
    }
    enum Scores: Int, CaseIterable, Identifiable {
        case Eagle = -2, Birdie = -1, Par = 0, Bogey = 1, DblBogey = 2, OverPar = 3
        
        var id: Self {self}
    }
    enum Pars: Int, CaseIterable, Identifiable {
        case par3 = 3, par4 = 4, par5 = 5
        
        var id: Self {self}
    }

    enum NbPutts: Int, CaseIterable, Identifiable {
        case Best = 1, Good = 2, Bad = 3, Worst = 4 //or more
        var id: Self {self}
    }
    
    enum PuttDistance: Int, CaseIterable, Identifiable {
        case Short = 1, ShortMedium = 5, Medium = 7, MediumLong = 10, Long = 15, VeryLong = 25, ExtraLong = 35 //and over
        var id: Self {self}
    }
    
    @State private var firstname: String = ""
    @State private var gamedate: Date = .now
    @State private var tlsp_tee: Float = 0
    @State private var tlsp_lng: Float = 0
    @State private var tlsp_shr: Float = 0
    @State private var tlsp_put: Float = 0
    @State private var isEditing = false
    @State private var nb_putt: Float = 0
    @State private var putt_distance: Float = 0

    var scoreHole: String = "Birdie"
    
    @State private var selectedHole: Holes = .h01
    @State private var selectedScore: Scores = .Par
    @State private var selectedPar: Pars = .par5

    @State private var newCompet = Competitions.emptyCompetition
    @Binding var compet: [Competitions]
    @State private var competition: String = ""
    @State private var score: String = ""
    
    var body: some View {

        VStack {
            Text("Insert a new hole in competition")
                .fontWeight(.bold)

            //TextField("Competition", text: $competition)
                .fontWeight(.bold)
                .background(.clear)
                .border(.black)
                .frame(width: 300, height:43)
            DatePicker("Game Date", selection: $gamedate, displayedComponents: .date).padding(15)

            HStack {
                Text("Hole:")

                HStack {
                    Picker("Hole", selection: $selectedHole) {
                        ForEach(Holes.allCases) { hole in
                                //Text(hole.rawValue.capitalized)
                            Text("\(hole.self.rawValue)")
                            }
                    
                    }
                    Picker("Par", selection: $selectedPar) {
                        ForEach(Pars.allCases) { par in
                            Text("\(par.self.rawValue)")
                            }
                    
                    }

                    Picker("Score", selection: $selectedScore) {
                        ForEach(Scores.allCases) { score in
                            Text("\(score.self.rawValue)")

                            }

                    }

                }.pickerStyle(.inline)

                
            }.padding(1)

            Group {
                //inser a slider with title
                HStack {
                    Text("T.L.S.P Tee:").labelStyle(.titleOnly)
                    Slider(value: $tlsp_tee, in:-2...3, step: 1, onEditingChanged: {editing in
                            isEditing = editing
                    } )
                    Text("\(String(tlsp_tee))")
                                .foregroundColor(isEditing ? .red : .brown)
                }

                HStack {
                    Text("T.L.S.P Lng:").labelStyle(.titleOnly)
                    Slider(value: $tlsp_lng, in:-2...3, step: 1, onEditingChanged: {editing in
                            isEditing = editing
                    } )
                    Text("\(String(format: "%.1f", tlsp_lng))")
                                .foregroundColor(isEditing ? .red : .brown)
                }

                HStack {
                    Text("T.L.S.P Sht:").labelStyle(.titleOnly)
                    Slider(value: $tlsp_shr, in:-2...3, step: 1, onEditingChanged: {editing in
                            isEditing = editing
                    } )
                    Text("\(String(format: "%.1f", tlsp_shr))")
                                .foregroundColor(isEditing ? .red : .brown)
                }

                HStack {
                    Text("T.L.S.P Put:").labelStyle(.titleOnly)
                    Slider(value: $tlsp_put, in:-2...3, step: 1, onEditingChanged: {editing in
                            isEditing = editing
                    } )
                    Text("\(String(format: "%.1f", tlsp_put))")
                                .foregroundColor(isEditing ? .red : .brown)
                }

                HStack {
                        let tlsp = tlsp_tee + tlsp_lng + tlsp_shr + tlsp_put
                        @State var sc = "\(tlsp)"
                        Text("T.L.S.P Score: ")
                        Spacer()
                        TextField("Score", text: $sc )
                            .fontWeight(.heavy)
                }
            }.padding(1)
            Group {
                VStack {
                    HStack {
                        Text("Nb. Putt:").labelStyle(.titleOnly)
                        Slider(value: $nb_putt, in:1...4, step: 1, onEditingChanged: {editing in
                                isEditing = editing
                        } )
                        Text("\(String(format: "%.00f", nb_putt))")
                                    .foregroundColor(isEditing ? .red : .brown)

                    }
                    HStack {
                        Text("Distance:").labelStyle(.titleOnly)
                        Slider(value: $putt_distance, in:1...35, step: 1, onEditingChanged: {editing in
                                isEditing = editing
                        } )
                        Text("\(String(format: "%.00f", putt_distance))")
                                    .foregroundColor(isEditing ? .red : .brown)

                    }


                }.padding(1)
            }

            
            
            Button(action: {
                var newEntry = Competitions.emptyCompetition
                print("Button Save Me Pressed")
                let tlsp = tlsp_tee + tlsp_lng + tlsp_shr + tlsp_put
                let tlsp__c = "\(tlsp)"
                
                print("Button Save Me Pressed ")
                newEntry.competition = competition.lowercased()
                newEntry.score = tlsp__c
                
                //store hole details
                //newEntry.details.hole = $selectedHole.rawValue
                print(selectedHole.rawValue)

                print(selectedPar.rawValue)
                print(selectedScore.rawValue)
                
                newEntry.details.hole = selectedHole.rawValue
                newEntry.details.par = selectedPar.rawValue
                newEntry.details.score = selectedScore.rawValue
                
                newEntry.details.tlsp_t = tlsp_tee
                newEntry.details.tlsp_l = tlsp_lng
                newEntry.details.tlsp_s = tlsp_shr
                newEntry.details.tlsp_p = tlsp_put
                print("T:L:S.P = \(tlsp)")
                newEntry.details.nb_putt = nb_putt
                newEntry.details.putt_distance = putt_distance
                
                compet.append(newEntry)
                //competition=""
                //score=""
                tlsp_lng = 0
                tlsp_tee = 0
                tlsp_shr = 0
                tlsp_put = 0
                
                switch selectedHole.rawValue {
                case 1:
                    selectedHole = .h02
                    selectedPar = .par4
                case 2:
                    selectedHole = .h03
                    selectedPar = .par3

                case 3:
                    selectedHole = .h04
                    selectedPar = .par4

                case 4:
                    selectedHole = .h05
                    selectedPar = .par4

                case 5:
                    selectedHole = .h06
                    selectedPar = .par3

                case 6:
                    selectedHole = .h07
                    selectedPar = .par3

                case 7:
                    selectedHole = .h08
                    selectedPar = .par3
                case 8:
                    selectedHole = .h09
                    selectedPar = .par4
                case 9:
                    selectedHole = .h10
                    selectedPar = .par3
                case 10:
                    selectedHole = .h11
                    selectedPar = .par4
                case 11:
                    selectedHole = .h12
                    selectedPar = .par3
                case 12:
                    selectedHole = .h13
                    selectedPar = .par4
                case 13:
                    selectedHole = .h14
                    selectedPar = .par5
                case 14:
                    selectedHole = .h15
                    selectedPar = .par4
                case 15:
                    selectedHole = .h16
                    selectedPar = .par3
                case 16:
                    selectedHole = .h17
                    selectedPar = .par5
                case 17:
                    selectedHole = .h18
                    selectedPar = .par3
                case 18:
                    selectedHole = .h01
                    selectedPar = .par5

                default:
                    selectedHole = .h01
                    selectedPar = .par5
                }
                selectedScore = .Par
                nb_putt = 2
                putt_distance = 10


            }) {
                Text("Save Me!")
                    .padding(10)
                        .font(.title)
                        .foregroundColor(.white)
                        .background(Color.blue)
            }


        }
    }
}

struct CompetitionDetail_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionDetail(compet: .constant(Competitions.sampleData))
    }
}
