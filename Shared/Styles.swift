//
//  Styles.swift
//  ITS90
//
//  Created by ADH Media Production on 1/26/21.
//

import SwiftUI

// Styles
extension Color {
    static var primaryColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                : UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0) })
    }
    static var secondaryColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 207/255, green: 203/255, blue: 210/255, alpha: 1.0)
                : UIColor(red: 34/255, green: 33/255, blue: 60/255, alpha: 1.0) })
    }//227,223,230
    static var backgroundColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 29/255, green: 28/255, blue: 53/255, alpha: 1.0)
                : UIColor(red: 233/255, green: 233/255, blue: 243/255, alpha: 1.0) })
        
    }
    static var secondaryBackgroundColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 44/255, green: 43/255, blue: 70/255, alpha: 1.0)
                : UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) })
    }//34,33,60
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct NiceButtonStyle: ButtonStyle {
  var foregroundColor: Color
  var backgroundColor: Color
  var pressedColor: Color

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .font(.headline)
      .padding(10)
      .foregroundColor(foregroundColor)
      .background(configuration.isPressed ? pressedColor : backgroundColor)
      .cornerRadius(30)
  }
}

extension View {
  func niceButton(
    foregroundColor: Color = .white,
    backgroundColor: Color = .gray,
    pressedColor: Color = .accentColor
  ) -> some View {
    self.buttonStyle(
      NiceButtonStyle(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        pressedColor: pressedColor
      )
    )
  }
}

// Collapsible View
struct Collapsible<Content: View>: View {
    var label: String
    var width: CGFloat
    @State var collapsed: Bool
    var content: () -> Content
    
    var body: some View {
        VStack {
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack {
                        Text(self.label)
                            .bold()
                            .font(.title2)
                            .padding(.bottom, 20)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .rotationEffect(self.collapsed ? .degrees(-90) : .degrees(0))
                            .animation(.easeIn)
                            .padding(.top, -18)
                    }
                    .animation(.easeIn)
                    .transition(.slide)
                    .padding(.bottom, 1)
                }
            )
            .buttonStyle(PlainButtonStyle())
            .frame(width: self.width)
            
            VStack {
                self.content()
            }
            
            .frame(minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .animation(.easeIn)
            .transition(.slide)
        }
    }
}
