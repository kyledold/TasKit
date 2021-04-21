//
//  ListBehaviourView.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/04/2021.
//

import SwiftUI

struct ListBehaviourView<ViewModel: ListBehaviourViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
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
        .navigationBarTitle(viewModel.titleText)
    }
}
    
extension ListBehaviourView {
    
    private var subTaskSection: some View {
        Section(footer: subTaskSectionFooter) {
            HStack {
                Toggle(isOn: $viewModel.isShowSubTasksEnabled) {
                    Text(viewModel.showSubTasksText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .toggleStyle(SwitchToggleStyle(tint: .t_action))
            }
            .frame(height: 40)
        }
    }
    
    private var subTaskSectionFooter: some View {
        Text(viewModel.showSubTasksDescription)
            .padding(.horizontal)
    }
    
    private var reminderSection: some View {
        Section(footer: reminderSectionFooter) {
            HStack {
                Toggle(isOn: $viewModel.isReminderEnabled) {
                    Text(viewModel.showReminderText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .toggleStyle(SwitchToggleStyle(tint: .t_action))
            }
            .frame(height: 40)
        }
    }
    
    private var reminderSectionFooter: some View {
        Text(viewModel.showReminderDescription)
            .padding(.horizontal)
    }
    
    private var unfinishedTasksSection: some View {
        Section(footer: unfinishedTasksSectionFooter) {
            HStack {
                Toggle(isOn: $viewModel.isMoveInompleteTasksEnabled) {
                    Text(viewModel.moveIncompleteTasksText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .toggleStyle(SwitchToggleStyle(tint: .t_action))
            }
            .frame(height: 40)
        }
    }
    
    private var unfinishedTasksSectionFooter: some View {
        Text(viewModel.moveIncompleteTasksDescription)
            .padding(.horizontal)
    }
}

struct ListBehaviourView_Previews: PreviewProvider {
    static var previews: some View {
        ListBehaviourView(viewModel: FakeListBehaviourViewModel())
    }
}
