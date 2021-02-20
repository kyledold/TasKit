//
//  TaskView.swift
//  TaskIt
//
//  Created by Kyle Dold on 20/02/2021.
//

import SwiftUI

struct TaskView: View {
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                HeaderSection()
                BodySection()
            }.edgesIgnoringSafeArea(.bottom)
        }.backgroundOverlay()
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}

private struct HeaderSection: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack(spacing: 24) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.down")
                Text("all tasks")
                    .font(.title20)
            })
            .foregroundColor(.primary)
            
            Spacer()
        }.padding().padding(.top, 32)
    }
}

private struct BodySection: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                //TitleSection(room: room)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70)), GridItem(.adaptive(minimum: 70)), GridItem(.adaptive(minimum: 70))]) {
                    ForEach(1 ..< 10) { i in
                        //UserCell(index: i, isLarge: true)
                    }
                }
            }.padding().padding(.bottom, 72)
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight - 90)
        .background(Color.t_content_background)
        .cornerRadius(32)
    }
}
