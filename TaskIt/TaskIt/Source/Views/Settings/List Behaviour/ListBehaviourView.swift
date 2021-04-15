//
//  ListBehaviourView.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/04/2021.
//

import SwiftUI

struct ListBehaviourView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading, spacing: Layout.Spacing.cozy) {
            List {
                subTaskSection
                reminderSection
                unfinishedTasksSection
                completeSubTasksSection
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle("List Behaviour")
    }
    
    private var subTaskSection: some View {
        Section(footer: subTaskSectionFooter) {
            HStack {
                Toggle(isOn: .constant(false)) {
                    Text("Show Sub-tasks")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .toggleStyle(SwitchToggleStyle(tint: .t_action))
            }
            .frame(height: 40)
        }
    }
    
    private var subTaskSectionFooter: some View {
        Text("If enabled this will show the sub tasks under the related task in the list up to a maximum of 8.")
            .padding(.horizontal)
    }
    
    private var reminderSection: some View {
        Section(footer: reminderSectionFooter) {
            HStack {
                Toggle(isOn: .constant(false)) {
                    Text("Show reminder")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .toggleStyle(SwitchToggleStyle(tint: .t_action))
            }
            .frame(height: 40)
        }
    }
    
    private var reminderSectionFooter: some View {
        Text("If enabled this will show the reminder time next to the task name in the list.")
            .padding(.horizontal)
    }
    
    private var unfinishedTasksSection: some View {
        Section(footer: unfinishedTasksSectionFooter) {
            HStack {
                Toggle(isOn: .constant(false)) {
                    Text("Carry forward incomplete tasks")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .toggleStyle(SwitchToggleStyle(tint: .t_action))
            }
            .frame(height: 40)
        }
    }
    
    private var unfinishedTasksSectionFooter: some View {
        Text("If enabled this will carry forward any uncompleted tasks to the current date.")
            .padding(.horizontal)
    }
    
    private var completeSubTasksSection: some View {
        Section(footer: completeSubTasksSectionFooter) {
            HStack {
                Toggle(isOn: .constant(false)) {
                    Text("Auto complete task")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .toggleStyle(SwitchToggleStyle(tint: .t_action))
            }
            .frame(height: 40)
        }
    }
    
    private var completeSubTasksSectionFooter: some View {
        Text("If enabled this automatically complete task when all sub-tasks are completed.")
            .padding(.horizontal)
    }
}

struct ListBehaviourView_Previews: PreviewProvider {
    static var previews: some View {
        ListBehaviourView()
    }
}
