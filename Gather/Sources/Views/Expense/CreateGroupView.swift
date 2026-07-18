import SwiftUI

struct CreateGroupView: View {
    @Bindable var viewModel: ExpenseViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 32) {
                
                // Group Name
                VStack(alignment: .leading, spacing: 8) {
                    Text("GROUP NAME")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondaryText)
                    
                    TextField("e.g. Weekend Trip Groceries", text: $viewModel.groupName)
                        .font(.title3)
                        .foregroundColor(.primaryText)
                        .focused($isFocused)
                    
                    Divider()
                }
                .padding(24)
                .background(Color.cardBackground)
                .cornerRadius(24)
                .padding(.horizontal, 24)
                .padding(.top, 16)
                
                // Category
                VStack(alignment: .leading, spacing: 16) {
                    Text("Category")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                        .padding(.horizontal, 24)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            Spacer().frame(width: 12)
                            ForEach(GroupCategory.allCases) { category in
                                Button(action: {
                                    viewModel.selectedCategory = category
                                }) {
                                    VStack(spacing: 12) {
                                        Image(systemName: category.iconName)
                                            .font(.title2)
                                        Text(category.rawValue)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                    }
                                    .frame(width: 100, height: 100)
                                    .background(viewModel.selectedCategory == category ? Color.primaryText : Color.cardBackground)
                                    .foregroundColor(viewModel.selectedCategory == category ? Color(UIColor.systemBackground) : .primaryText)
                                    .cornerRadius(24)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                                    )
                                }
                            }
                            Spacer().frame(width: 12)
                        }
                    }
                }
                
                // Invite Members
                VStack(alignment: .leading, spacing: 16) {
                    Text("Invite Members")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                        .padding(.horizontal, 24)
                    
                    VStack(spacing: 0) {
                        InviteCard(title: "Share Link", subtitle: "Send via Messages, Mail, or WhatsApp", iconSystemName: "link") {}
                        Divider().padding(.leading, 56)
                        InviteCard(title: "Show QR Code", subtitle: "Let someone scan from your screen", iconSystemName: "qrcode") {}
                        Divider().padding(.leading, 56)
                        InviteCard(title: "Nearby Share", subtitle: "Find people physically close to you", iconSystemName: "antenna.radiowaves.left.and.right") {}
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(Color.cardBackground)
                    .cornerRadius(24)
                    .padding(.horizontal, 24)
                }
                
                Spacer().frame(height: 100)
            }
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .navigationTitle("New Group")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Create") {
                    viewModel.nextStep()
                }
                .font(.headline)
                .foregroundColor(.primaryText)
            }
        }
        .onAppear {
            isFocused = true
        }
    }
}
