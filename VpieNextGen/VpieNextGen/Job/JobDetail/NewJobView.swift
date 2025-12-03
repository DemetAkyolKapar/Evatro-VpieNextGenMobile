//
//  NewJobView.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 2.12.2025.
//

import SwiftUI

struct NewJobView: View {
    @Environment(\.deviceBehavior) private var deviceBehavior
    
    var body: some View {
        
        var columns: [GridItem] {
            let count = (deviceBehavior != .pad) ? 3 : 4
            return Array(repeating: GridItem(.flexible()), count: count)
        }
        ScrollView{
            VStack(alignment: .leading, spacing: AppSpacing.standard) {
                JobItemView(viewModel: MockJobItemVM(sample: 1), showBottomButtons: false)
                
                BorderedButton(
                    title: "Finish Job",
                    titleColor: .appWhite,
                    backgroundColor: Color.appBlack,
                    borderColor: .appWhite,
                    cornerRadius: AppCornerRadius.button,
                    verticalPadding: AppPadding.extraSmall){}
                Grid {
                    GridRow {
                        BorderedVerticalButton(
                            title: "add_note",
                            titleColor: .vpieGray,
                            backgroundColor: Color.appWhite,
                            borderColor: .vpieGray,
                            cornerRadius: AppCornerRadius.button,
                            verticalPadding: AppPadding.extraSmall,            image: Image(systemName: "note.text")
                        ){}
                            .gridCellUnsizedAxes(.vertical)
                            .gridCellAnchor(.top)
                        BorderedVerticalButton(
                            title: "add_form",
                            titleColor: .vpieGray,
                            backgroundColor: Color.appWhite,
                            borderColor: .vpieGray,
                            cornerRadius: AppCornerRadius.button,
                            verticalPadding: AppPadding.extraSmall,            image: Image(systemName: "list.bullet.rectangle")
                        ){}.gridCellUnsizedAxes(.vertical)
                            .gridCellAnchor(.top)
                        
                        BorderedVerticalButton(
                            title: "add_photo",
                            titleColor: .vpieGray,
                            backgroundColor: Color.appWhite,
                            borderColor: .vpieGray,
                            cornerRadius: AppCornerRadius.button,
                            verticalPadding: AppPadding.extraSmall,            image: Image(systemName: "photo")
                        ){}.gridCellUnsizedAxes(.vertical)
                            .gridCellAnchor(.top)
                        
                        
                    }
                }
                ExpandableCustomCard(
                    title: "Forms",
                    isInitiallyExpanded: true,
                    showAddButton: true,
                    onAddButtonTapped: {
                        print("Add form tapped")
                    }
                ) {
                    VStack(spacing: 0) {
                        ForEach(Array([
                            "Columbus Water Install",
                            "Columbus Meter Reading",
                            "Employee Equipment Affidavit"
                        ].enumerated()), id: \.offset) { index, formTitle in
                            Button(action: {
                                print("\(formTitle) tapped")
                            }) {
                                Text(formTitle)
                                    .font(.system(size: FontSize.standard, weight: .semibold))
                                    .dynamicTypeSize(.xSmall ... .accessibility5)
                                    .foregroundColor(Color.vpieGray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, AppPadding.small)
                            }
                            .buttonStyle(.plain)
                            
                            if index < 2 {
                                Line()
                                    .stroke(.vpieGrayWithDarkMode.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [2]))
                                    .frame(height: 0.5)
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                }
                
                ExpandableCustomCard(
                    title: "Notes",
                    isInitiallyExpanded: true,
                    showAddButton: true,
                    onAddButtonTapped: {
                        print("Add note tapped")
                    }
                ) {
                    VStack(spacing: 8) {
                        ForEach(0..<3, id: \.self) { index in
                            HStack(alignment: .top, spacing: AppSpacing.thin) {
                                Image(systemName: "note.text")
                                    .font(.system(size: FontSize.standard))
                                    .foregroundColor(.vpieGray)
                                    .frame(width: 24, height: 24,alignment: .bottom)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Note \(index + 1)")
                                        .font(.system(size: FontSize.standard, weight: .bold))
                                        .foregroundColor(.appBlack)
                                    Text("This is a sample note content...")
                                        .font(.system(size: FontSize.thin))
                                        .foregroundColor(.vpieGray)
                                        .lineLimit(2)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, AppPadding.medium)
                            .padding(.vertical, AppPadding.small)
                            
                            if index < 2 {
                                Line()
                                    .stroke(.vpieGrayWithDarkMode.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [2]))
                                    .frame(height: 0.5)
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                }
                
                ExpandableCustomCard(
                    title: "Photos",
                    subtitle: "12 photos",
                    isInitiallyExpanded: false,
                    showAddButton: true,
                    onAddButtonTapped: {
                        print("Add photo tapped")
                    }
                ) {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(0..<7, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.vpieGray.opacity(0.3))
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(
                                    Image("logo")
                                        .foregroundColor(.vpieGray)
                                )
                        }
                    }
                    .padding(.horizontal, AppPadding.medium)
                    .padding(.vertical, AppPadding.small)
                }
                
            }.padding(AppPadding.medium)
        }
    }
}

#Preview {
    NewJobView()
}
