//
//  ContentView.swift
//  Shared
//
//  Created by ADH Media Production on 1/28/21.
//

import SwiftUI

struct ITS90Object: Codable {
    var rtpw: String
    var ap: String
    var bp: String
    var cp: String
    var an: String
    var bn: String
}

class Model: ObservableObject {
    /*
     @State private var rtpwText: String = "100.103614"
     @State private var apText: String = "-4.198612E-5"
     @State private var bpText: String = "-6.639152E-5"
     @State private var cpText: String = "0.0"
     @State private var anText: String = "-1.670754E-4"
     @State private var bnText: String = "-3.887675E-5"
    */
    @Published var rtpw: String = "0"
    @Published var ap: String = "0"
    @Published var bp: String = "0"
    @Published var cp: String = "0"
    @Published var an: String = "0"
    @Published var bn: String = "0"
    
    @Published var temperature: String = "0"
    @Published var resistance: String = "100"
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    // UI Sizes
    let width : CGFloat = UIScreen.screenWidth - 50;
    
    // Model
    @ObservedObject var model : Model
    
    // Radio Button
    @State private var selectedTempUnit: Int = 1
    @State private var disable: Bool = true
    
    // Label title
    @State private var label: String = "Calculate Resistance Based on Temperature"
    @State private var temperatureSign: [String] = ["Temperature (C°)", "Temperature (F°)", "Temperature (K°)"]
    
    // Unit
    @State private var selectedMode: Int = 1 // 1 - temperature, 2 - resistance
    
    // Resolution
    @State private var selectedResolutionIndex = 1
    
    // Alerts
    @State private var showingActionSheet = false
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // JSON for file saving
    @State private var json: String = String()
    
    // Animation
    @Namespace private var animation
    
    var body: some View {
        // UI
        VStack {
            HStack {
                // Menu button
                Button(
                    action: {
                        self.showingActionSheet = true
                    },
                    label: {
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .frame(width: 24.0, height: 18.0)
                    }
                )
                .buttonStyle(PlainButtonStyle())
                .frame(alignment: .leading)
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Choose an option"), message: nil, buttons: [
                        .default(Text("Save coefficients")) {
                            save()
                        },
                        .default(Text("Load coefficients")) {
                            read()
                        },
                        .default(Text("Clear fields")) {
                            clear()
                        },
                        .cancel()
                    ])
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Got it!")))
                }
                
                Spacer()
                
                Image(colorScheme == .light ? "harwell_logo" : "harwell_logo_white")
                    .resizable()
                    .frame(width: 100, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.leading,-30)
                
                Spacer()
            }
            .frame(width: width, alignment: .leading)
            .padding(.top, isIphoneXAndUp() ? 40 : 0)
            
            HStack{
                Text("ITS-90 \nCalculator")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                    .frame(width: width, alignment: .leading)
            }
            .frame(width: width)
            .padding(.top, 10)
            .padding(.bottom, 20)
            .zIndex(1.0)
            
            ScrollView {
                // CARD 1
                VStack {
                    // Coefficients
                    Collapsible(
                        label:"Coefficient Data",
                        width: width,
                        collapsed: true,
                        content: {
                            VStack {
                                // RTPW
                                VStack {
                                    Text("Resistance Ω at Triple Point of Water")
                                        .padding(.top, 2)
                                        .foregroundColor(Color.secondaryColor)
                                        .frame(width: width, alignment: .leading)
                                    
                                    TextField("",
                                          text:
                                            Binding(
                                                get: {self.model.rtpw},
                                                set: {
                                                    self.model.rtpw = $0.replacingOccurrences(
                                                    of: "(?![0-9-.\\-\\+Ee]).+", with: "", options: .regularExpression)
                                                    updateDocument(object:
                                                                    ITS90Object(rtpw: self.model.rtpw,
                                                                                ap: self.model.ap,
                                                                                bp: self.model.bp,
                                                                                cp: self.model.cp,
                                                                                an: self.model.an,
                                                                                bn: self.model.bn))
                                                }
                                            )
                                        )
                                        .border(Color.white.opacity(0))
                                        .overlay(
                                            VStack{
                                                Divider()
                                                    .background(Color.primaryColor)
                                                    .offset(x: 0, y: 12)
                                                
                                            }
                                        )
                                }
                                .frame(width: width)
                                .padding(.bottom, 15)
                                
                                // AP
                                HStack {
                                    Text("Ap")
                                        .padding(.top, 2)
                                        .frame(width: 50, alignment: .leading)
                                        .foregroundColor(Color.secondaryColor)
                                    
                                    TextField("",
                                              text:
                                                Binding(
                                                    get: {self.model.ap},
                                                    set: {
                                                        self.model.ap = $0.replacingOccurrences(
                                                        of: "(?![0-9-.\\-\\+Ee]).+", with: "", options: .regularExpression)
                                                        updateDocument(object:
                                                                        ITS90Object(rtpw: self.model.rtpw,
                                                                                    ap: self.model.ap,
                                                                                    bp: self.model.bp,
                                                                                    cp: self.model.cp,
                                                                                    an: self.model.an,
                                                                                    bn: self.model.bn))
                                                    }
                                                )
                                        )
                                        .border(Color.white.opacity(0))
                                        .overlay(
                                            VStack{
                                                Divider()
                                                    .background(Color.primaryColor)
                                                    .offset(x: 0, y: 12)
                                                
                                            }
                                        )
                                    
                                }
                                .frame(width: width)
                                .padding(.bottom, 15)
                                
                                // BP
                                HStack {
                                    Text("Bp")
                                        .padding(.top, 2)
                                        .frame(width: 50, alignment: .leading)
                                        .foregroundColor(Color.secondaryColor)
                                    
                                    TextField("",
                                              text:
                                                Binding(
                                                    get: {self.model.bp},
                                                    set: {
                                                        self.model.bp = $0.replacingOccurrences(
                                                        of: "(?![0-9-.\\-\\+Ee]).+", with: "", options: .regularExpression)
                                                        updateDocument(object:
                                                                        ITS90Object(rtpw: self.model.rtpw,
                                                                                    ap: self.model.ap,
                                                                                    bp: self.model.bp,
                                                                                    cp: self.model.cp,
                                                                                    an: self.model.an,
                                                                                    bn: self.model.bn))
                                                    }
                                                )
                                        )
                                        .border(Color.white.opacity(0))
                                        .overlay(
                                            VStack{
                                                Divider()
                                                    .background(Color.primaryColor)
                                                    .offset(x: 0, y: 12)
                                                
                                            }
                                        )
                                    
                                }
                                .frame(width: width)
                                .padding(.bottom, 15)
                                
                                // Cp
                                HStack {
                                    Text("Cp")
                                        .padding(.top, 2)
                                        .frame(width: 50, alignment: .leading)
                                        .foregroundColor(Color.secondaryColor)
                                    
                                    TextField("",
                                              text:
                                                Binding(
                                                    get: {self.model.cp},
                                                    set: {
                                                        self.model.cp = $0.replacingOccurrences(
                                                        of: "(?![0-9-.\\-\\+Ee]).+", with: "", options: .regularExpression)
                                                        updateDocument(object:
                                                                        ITS90Object(rtpw: self.model.rtpw,
                                                                                    ap: self.model.ap,
                                                                                    bp: self.model.bp,
                                                                                    cp: self.model.cp,
                                                                                    an: self.model.an,
                                                                                    bn: self.model.bn))
                                                    }
                                                )
                                        )
                                        .border(Color.white.opacity(0))
                                        .overlay(
                                            VStack{
                                                Divider()
                                                    .background(Color.primaryColor)
                                                    .offset(x: 0, y: 12)
                                                
                                            }
                                        )
                                    
                                }
                                .frame(width: width)
                                .padding(.bottom, 15)
                                
                                // An
                                HStack {
                                    Text("An")
                                        .padding(.top, 2)
                                        .frame(width: 50, alignment: .leading)
                                        .foregroundColor(Color.secondaryColor)
                                    
                                    TextField("",
                                              text:
                                                Binding(
                                                    get: {self.model.an},
                                                    set: {
                                                        self.model.an = $0.replacingOccurrences(
                                                        of: "(?![0-9-.\\-\\+Ee]).+", with: "", options: .regularExpression)
                                                        updateDocument(object:
                                                                        ITS90Object(rtpw: self.model.rtpw,
                                                                                    ap: self.model.ap,
                                                                                    bp: self.model.bp,
                                                                                    cp: self.model.cp,
                                                                                    an: self.model.an,
                                                                                    bn: self.model.bn))
                                                    }
                                                )
                                        )
                                        .border(Color.white.opacity(0))
                                        .overlay(
                                            VStack{
                                                Divider()
                                                    .background(Color.primaryColor)
                                                    .offset(x: 0, y: 12)
                                                
                                            }
                                        )
                                }
                                .frame(width: width)
                                .padding(.bottom, 15)
                                
                                // Bn
                                HStack {
                                    Text("Bn")
                                        .padding(.top, 2)
                                        .frame(width: 50, alignment: .leading)
                                        .foregroundColor(Color.secondaryColor)
                                    TextField("",
                                          text:
                                            Binding(
                                                get: {self.model.bn},
                                                set: {
                                                    self.model.bn = $0.replacingOccurrences(
                                                    of: "(?![0-9-.\\-\\+Ee]).+", with: "", options: .regularExpression)
                                                    updateDocument(object:
                                                                    ITS90Object(rtpw: self.model.rtpw,
                                                                                ap: self.model.ap,
                                                                                bp: self.model.bp,
                                                                                cp: self.model.cp,
                                                                                an: self.model.an,
                                                                                bn: self.model.bn))
                                                }
                                            )
                                        )
                                        .border(Color.white.opacity(0))
                                        .overlay(
                                            VStack{
                                                Divider()
                                                    .background(Color.primaryColor)
                                                    .offset(x: 0, y: 12)
                                                
                                            }
                                        )
                                    
                                }
                                .frame(width: width)
                                .padding(.bottom, 30)
                            }
                        }
                    )
                    
                    Spacer()
                    
                    // Calculate
                    Collapsible(
                        label: label,
                        width: width,
                        collapsed: false,
                        content: {
                            VStack {
                                // Temperature
                                VStack {
                                    Text(temperatureSign[selectedTempUnit - 1])
                                        .padding(.top, 5)
                                        .frame(width: width, alignment: .leading)
                                        .foregroundColor(Color.secondaryColor)
                                    
                                    TextField("",
                                              text:
                                                Binding(
                                                    get: {self.model.temperature},
                                                    set: {
                                                        self.model.temperature = $0.replacingOccurrences(
                                                        of: "(?![0-9-.\\-\\+Ee]).+", with: "", options: .regularExpression)
                                                        
                                                        self.model.resistance = ""
                                                        label = "Calculate Resistance based on Temperature"
                                                        selectedMode = 1
                                                        disable = true
                                                        print("resistance")
                                                    }
                                                )
                                        )
                                        .border(Color.white.opacity(0))
                                        .overlay(
                                            VStack{
                                                Divider()
                                                    .background(Color.primaryColor)
                                                    .offset(x: 0, y: 12)
                                                
                                            }
                                        )
                                    
                                }
                                .frame(width: width)
                                .padding(.bottom, 15)
                                
                                // Resistance
                                VStack {
                                    Text("Resistance (Ω)")
                                        .padding(.top, 5)
                                        .frame(width: width, alignment: .leading)
                                        .foregroundColor(Color.secondaryColor)
                                    
                                    TextField("",
                                              text:
                                                Binding(
                                                    get: {self.model.resistance},
                                                    set: {
                                                        self.model.resistance = $0.replacingOccurrences(
                                                        of: "(?![0-9-.\\-\\+Ee]).+", with: "", options: .regularExpression)
                                                        
                                                        self.model.temperature = ""
                                                        label = "Calculate Temperature based on Resistance"
                                                        selectedMode = 2
                                                        disable = false
                                                        print("resistance")
                                                    }
                                                )
                                        )
                                        .border(Color.white.opacity(0))
                                        .overlay(
                                            VStack{
                                                Divider()
                                                    .background(Color.primaryColor)
                                                    .offset(x: 0, y: 12)
                                                
                                            }
                                        )
                                }
                                .frame(width: width)
                                .padding(.bottom, 15)
                                
                                // Unit
                                VStack {
                                    Text("Unit")
                                        .padding(.top, 5)
                                        .frame(width: width, alignment: .leading)
                                        .foregroundColor(Color.secondaryColor)
                                    Picker(selection: $selectedTempUnit, label: Text("")) {
                                        Text("Celsius (C°)").tag(1)
                                        Text("Fahrenheit (F°)").tag(2)
                                        Text("Kelvin (K°)").tag(3)
                                    }
                                    .disabled(disable)
                                    .pickerStyle(SegmentedPickerStyle())
                                }
                                .frame(width: width)
                                .padding(.bottom, 20)
                                
                                // Resolution
                                VStack {
                                    Text("Resolution")
                                        .padding(.top, 5)
                                        .frame(width: width, alignment: .leading)
                                        .foregroundColor(Color.secondaryColor)
                                    ScrollView(.horizontal) {
                                        VStack{
                                            Picker(selection: $selectedResolutionIndex, label: Text("")) {
                                                Text("0.0").tag(1)
                                                Text("0.00").tag(2)
                                                Text("0.000").tag(3)
                                                Text("0.0000").tag(4)
                                                Text("0.00000").tag(5)
                                                Text("0.000000").tag(6)
                                            }
                                            .pickerStyle(SegmentedPickerStyle())
                                        }.frame(height: 50)
                                    }
                                    .frame(width: width)
                                    .padding(.top, -5)
                                }
                                .padding(.bottom, 20)
                                
                                // Button
                                HStack {
                                    Button(action: {
                                        Calculate();
                                    }){
                                        Text("Calculate").frame(width: width-20)
                                    }
                                    .niceButton(
                                        foregroundColor: .white,
                                        backgroundColor: .blue,
                                        pressedColor: .purple
                                    )
                                }
                                .frame(width: width)
                                .padding(.top, 5)
                            }
                        }
                    )
                    Spacer()
                }
                .padding(30)
                .background(Color.secondaryBackgroundColor)
                .cornerRadius(40)
                .shadow(color: Color.black.opacity(0.06), radius: 15, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                .padding(.top, 140)
            }
            .padding(.top, -140)
            .zIndex(2)
        }
        .padding(.top, 30)
        //.background(Color.backgroundColor)
        .background(colorScheme == .light ?
            LinearGradient(gradient:
                            Gradient(
                                colors: [
                                    Color.backgroundColor,
                                    Color.backgroundColor
                                ]
                            ),
                           startPoint: .top,
                           endPoint: .bottom)
            :
            LinearGradient(gradient:
                            Gradient(
                                colors: [
                                    Color.backgroundColor,
                                    Color(red: 48/255, green: 33/255, blue: 64/255)
                                ]
                            ),
                           startPoint: .leading,
                           endPoint: .trailing))
        .edgesIgnoringSafeArea(.all)
        
    }
    
    // Methods
    func Calculate(){
        // Calculate Resistance based on Temperature
        if selectedMode == 1 {
            let value = (self.model.temperature as NSString).doubleValue
            
            // if below zero
            if value < 0 {
                self.model.resistance = String(CalculateResistanceBasedOnTemperature(
                    temperature: value,
                    sign: "-"))
            }
            
            // if above zero
            if value >= 0 {
                self.model.resistance = String(CalculateResistanceBasedOnTemperature(
                    temperature: value,
                    sign: "+"))
            }
        }
        
        // Calculate Temperature based on Resistance
        if selectedMode == 2 {
            let ap: Double = (self.model.ap as NSString).doubleValue
            let bp: Double = (self.model.bp as NSString).doubleValue
            let an: Double = (self.model.an as NSString).doubleValue
            let bn: Double = (self.model.bn as NSString).doubleValue
            
            let isPositive: Bool = (ap != 0) || (bp != 0)
                                    &&
                                    (an == 0) || (bn == 0)
            
            let value = (self.model.resistance as NSString).doubleValue
            
            if isPositive {
                self.model.temperature = String(CalculateTemperatureBasedOnResistance(
                    resistance: value,
                    sign: "+"))
            }
            
            else {
                self.model.temperature = String(CalculateTemperatureBasedOnResistance(
                    resistance: value,
                    sign: "-"))
            }
        }
    }
    
    func CalculateResistanceBasedOnTemperature(temperature: Double, sign: Character) -> Double {
        var W: Double = 0.0
        var Wr: Double = 0.0
        var dW: Double = 0.0
        
        let rtpw: Double = (self.model.rtpw as NSString).doubleValue
        let ap: Double = (self.model.ap as NSString).doubleValue
        let bp: Double = (self.model.bp as NSString).doubleValue
        let cp: Double = (self.model.cp as NSString).doubleValue
        let an: Double = (self.model.an as NSString).doubleValue
        let bn: Double = (self.model.bn as NSString).doubleValue
        
        let Temp: Double = temperature + ITS90Constants.KELVIN;
        
        // Calculate above zero
        if sign == "+" {
            for (index, element) in ITS90Constants.AboveZeroResistance.enumerated(){
                Wr += element * pow((((Temp) - 754.15) / 481), Double(index));
            }

            dW = ((ap * (Wr - 1.0)) + (pow(bp * (Wr - 1), 2)) + (pow(cp * (Wr - 1), 3)))
                        *
                        ((1.0 + ap + 2.0 * cp * (Wr - 1) + 3.0 * cp * pow(Wr - 1.0, 2)));
        }

        // Calculate below zero
        if (sign == "-") {
            for (index, element) in ITS90Constants.BelowZeroResistance.enumerated() {
                Wr += element * pow(((log((Temp) / 273.16) + 1.5) / 1.5), Double(index));
            }
            
            Wr = exp(Wr);
            
            dW = ((an * (Wr - 1.0)) + (bn * (Wr - 1.0) * log(Wr))) * (1.0 + an + (bn * (1.0 - 1.0 / Wr + log(Wr))));
        }
        W = Wr + dW;
        return Double(W * rtpw).rounded(toPlaces: selectedResolutionIndex)
    }
    
    func CalculateTemperatureBasedOnResistance(resistance: Double, sign: Character) -> Double{
        var W: Double = 0.0
        var Wr: Double = 0.0
        var dW: Double = 0.0
        
        let rtpw: Double = (self.model.rtpw as NSString).doubleValue
        let ap: Double = (self.model.ap as NSString).doubleValue
        let bp: Double = (self.model.bp as NSString).doubleValue
        let an: Double = (self.model.an as NSString).doubleValue
        let bn: Double = (self.model.bn as NSString).doubleValue
        
        var returnValue: Double = 0.0
        
        // Calculate above zero
        if sign == "+" {
            var sum: Double = 0.0
            
            W = resistance / rtpw;
            
            dW = (ap * (W - 1.0)) + pow((bp * (W - 1.0)), 2.0) + pow(bp * (W - 1), 3);
            
            Wr = W - dW;
            
            for (index, element) in ITS90Constants.AboveZeroTemperature.enumerated() {
                sum += element * pow(((Wr - 2.64) / 1.64), Double(index));
            }

            returnValue = sum;
        }

        // Calculate below zero
        if sign == "-" {
            var sum: Double = 0.0;
            var l: Double = 0.0;

            W = resistance / rtpw;
            
            dW = an * (W - 1.0) + bn * (W - 1.0) * log(W);
            
            Wr = W - dW;
            
            l = (pow(Wr, 1.0 / 6.0) - 0.65) / 0.35;
            
            for (index, element) in ITS90Constants.BelowZeroTemperature.enumerated() {
                sum += element * pow(l, Double(index));
            }
            
            returnValue = ((sum) * 273.16) - 273.15;

        }
        
        print(selectedTempUnit)
        return ConvertTemperature(temperature: returnValue, mode: selectedTempUnit);
    }
    
    func ConvertTemperature(temperature: Double, mode: Int) -> Double {
        var returnTemperature: Double = 0.0;
        switch mode {
            case 1:
                returnTemperature = temperature
                break;
            case 2:
                returnTemperature = (temperature * 9/5) + 32;
                break;
            case 3:
                returnTemperature = temperature + ITS90Constants.KELVIN;
                break;
            default:
                break;
        }
        return Double(returnTemperature).rounded(toPlaces: selectedResolutionIndex);
    }
    
    // File functions
    func save() {
        let str = self.json
        let filename = getDocumentsDirectory().appendingPathComponent("Coefficients.txt")

        do {
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            self.showingAlert = true
            self.alertTitle = "Saved!"
            self.alertMessage = "Coefficients updated!"
            
        } catch {
            self.showingAlert = true
            self.alertTitle = "Saving failed!"
            self.alertMessage = "Coefficients not updated!"
        }
    }
    
    func read() {
        let filename = getDocumentsDirectory().appendingPathComponent("Coefficients.txt")

        do {
            let text = try String(contentsOf: filename, encoding: .utf8)
            self.json = text
            
            print(json)
            let object: ITS90Object = createObjectFromFile(json: self.json)
            
            self.model.rtpw = object.rtpw
            self.model.ap = object.ap
            self.model.bp = object.bp
            self.model.cp = object.cp
            self.model.an = object.an
            self.model.bn = object.bn
            
            self.showingAlert = true
            self.alertTitle = "Loaded!"
            self.alertMessage = "Coefficients loaded."
            
        } catch {
            self.showingAlert = true
            self.alertTitle = "Load failed!"
            self.alertMessage = "Please try again."
        }
    }
    
    func updateDocument(object: ITS90Object) {
        let jsonData = try! JSONEncoder().encode(object)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        self.json = jsonString
    }
    
    func createObjectFromFile(json: String) -> ITS90Object {
        if json != "" {
            if let jsonData = json.data(using: .utf8)
            {
                let decoder = JSONDecoder()

                do {
                    let onject = try decoder.decode(ITS90Object.self, from: jsonData)
                    return onject
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        return ITS90Object(rtpw: "", ap: "", bp: "", cp: "", an: "", bn: "")
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // UI functions
    func clear() {
        self.model.rtpw = ""
        self.model.ap = ""
        self.model.bp = ""
        self.model.cp = ""
        self.model.an = ""
        self.model.bn = ""
        
        self.showingAlert = true
        self.alertTitle = "Cleared!"
        self.alertMessage = "Fields cleared!"
    }
    
    func isIphoneXAndUp() -> Bool {
        var returnVal = false
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1136:
                    print("iPhone 5 or 5S or 5C")
                    returnVal = false
                    break;
                case 1334:
                    print("iPhone 6/6S/7/8")
                    returnVal = false
                    break;
                case 1920, 2208:
                    print("iPhone 6+/6S+/7+/8+")
                    returnVal = false
                    break;
                case 2436:
                    print("iPhone X/XS/11 Pro")
                    returnVal = true
                    break;
                case 2688:
                    print("iPhone XS Max/11 Pro Max")
                    returnVal = true
                    break;
                case 1792:
                    print("iPhone XR/ 11 ")
                    returnVal = true
                    break;
                case 2532:
                    print("iPhone 12")
                    returnVal = true
                    break;
                case 2778:
                    print("iPhone 12 Pro Max")
                    returnVal = true
                    break;
                default:
                    print("Unknown")
                    returnVal = false
            }
        }
        return returnVal
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: Model())
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
