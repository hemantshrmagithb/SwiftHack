import SwiftUI

struct SharedShoppingRoomView: View {
    @Bindable var viewModel: ExpenseViewModel
    @State private var showAddItemAlert = false
    @State private var newItemName = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if let group = viewModel.group {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Header
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Shared List")
                            .font(.subheadline)
                            .foregroundColor(.secondaryText)
                        
                        Text(group.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primaryText)
                        
                        HStack {
                            HStack(spacing: -10) {
                                MemberAvatar(member: .sarah, size: 32)
                                MemberAvatar(member: .alex, size: 32)
                                Circle()
                                    .fill(Color.cardBackground)
                                    .frame(width: 32, height: 32)
                                    .overlay(Text("+2").font(.caption).fontWeight(.bold))
                                    .overlay(Circle().stroke(Color.appBackground, lineWidth: 2))
                            }
                            
                            HStack(spacing: 6) {
                                Circle().fill(Color.gatherGreen).frame(width: 8, height: 8)
                                Text("3 active now")
                                    .font(.caption)
                                    .foregroundColor(.primaryText)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.gatherGreen.opacity(0.1))
                            .cornerRadius(16)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    
                    // Live Activity
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Live Activity")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.primaryText)
                        
                        VStack(spacing: 8) {
                            ForEach(group.activityFeed) { event in
                                ActivityFeedRow(event: event)
                            }
                        }
                    }
                    .padding(24)
                    .background(Color.cardBackground)
                    .cornerRadius(24)
                    .padding(.horizontal, 24)
                    
                    // To Get List
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("To Get")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.primaryText)
                            Spacer()
                            Button(action: {
                                showAddItemAlert = true
                            }) {
                                Text("Add Item")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(UIColor.systemBackground))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.primaryText)
                                    .cornerRadius(20)
                            }
                        }
                        
                        VStack(spacing: 0) {
                            ForEach(group.items) { item in
                                ShoppingListRow(item: item) {
                                    viewModel.toggleItemSelection(item)
                                }
                                if item.id != group.items.last?.id {
                                    Divider()
                                }
                            }
                        }
                    }
                    .padding(24)
                    .background(Color.cardBackground)
                    .cornerRadius(24)
                    .padding(.horizontal, 24)
                    
                    Spacer().frame(height: 100)
                }
            }
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .overlay(
            VStack {
                Spacer()
                HStack {
                    HStack(spacing: 12) {
                        Image(systemName: "bag")
                            .font(.title3)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(viewModel.group?.items.count ?? 0) Items")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("in Shared Cart")
                                .font(.caption)
                                .foregroundColor(.secondaryText)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            viewModel.nextStep()
                        }
                    }) {
                        Text("Checkout")
                            .font(.headline)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.gatherGreen)
                            .cornerRadius(20)
                    }
                }
                .padding(20)
                .background(Color.cardBackground)
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: -5)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
            }
            , alignment: .bottom
        )
        .alert("Add Item", isPresented: $showAddItemAlert) {
            TextField("Item name", text: $newItemName)
            Button("Add") {
                if !newItemName.isEmpty {
                    viewModel.addItem(name: newItemName)
                    newItemName = ""
                }
            }
            Button("Cancel", role: .cancel) {
                newItemName = ""
            }
        } message: {
            Text("Enter the name of the item to add to the shared cart.")
        }
    }
}
