import SwiftUI

struct CartSummaryView: View {
    @Bindable var viewModel: PlanningViewModel
    var onDismiss: () -> Void
    
    @State private var isPlacingOrder = false
    @State private var showError = false
    
    var allProducts: [ShoppingProduct] {
        let rawProducts = viewModel.plan?.shoppingCategories.flatMap { $0.products } ?? []
        // Merge duplicates by name
        var merged: [String: ShoppingProduct] = [:]
        for product in rawProducts {
            if let existing = merged[product.name] {
                // If exists, just keep the essential one and sum the price (simplified merge for the hackathon)
                let newPrice = existing.estimatedPrice + product.estimatedPrice
                let newEssential = existing.isEssential || product.isEssential
                merged[product.name] = ShoppingProduct(name: product.name, estimatedQuantity: existing.estimatedQuantity + " + " + product.estimatedQuantity, estimatedPrice: newPrice, isEssential: newEssential)
            } else {
                merged[product.name] = product
            }
        }
        return Array(merged.values).sorted { $0.name < $1.name }
    }
    
    var totalPrice: Double {
        allProducts.reduce(0) { $0 + $1.estimatedPrice }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    if !viewModel.path.isEmpty {
                        viewModel.path.removeLast()
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primaryText)
                }
                
                Spacer()
                
                Text("Your Cart")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.primaryText)
                }
            }
            .padding()
            .background(Color.appBackground)
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Blinkit Style Delivery Banner
                    HStack(spacing: 12) {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.gatherOrange)
                        VStack(alignment: .leading) {
                            Text("Delivery in 10 minutes")
                                .font(.subheadline).bold()
                            Text("to Current Location")
                                .font(.caption)
                                .foregroundColor(.secondaryText)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.gatherOrange.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        ForEach(allProducts) { product in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(product.name)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    Text(product.estimatedQuantity)
                                        .font(.caption)
                                        .foregroundColor(.secondaryText)
                                }
                                
                                Spacer()
                                
                                Text(String(format: "₹%.2f", product.estimatedPrice))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .background(Color.cardBackground)
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                    }
                    
                    // Bill Details
                    VStack(spacing: 12) {
                        HStack {
                            Text("Item Total")
                            Spacer()
                            Text(String(format: "₹%.2f", totalPrice))
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondaryText)
                        
                        HStack {
                            Text("Handling Charge")
                            Spacer()
                            Text("₹25.00")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondaryText)
                        
                        HStack {
                            Text("Delivery Fee")
                            Spacer()
                            Text("FREE")
                                .foregroundColor(.gatherGreen)
                                .bold()
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondaryText)
                        
                        Divider()
                        
                        HStack {
                            Text("To Pay")
                                .font(.headline)
                            Spacer()
                            Text(String(format: "₹%.2f", totalPrice + 25.0))
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                    .background(Color.cardBackground)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    Spacer().frame(height: 100)
                }
                .padding(.top)
            }
            
            // Checkout Button
            VStack {
                Button(action: {
                    guard totalPrice > 0 else { return }
                    
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                    
                    isPlacingOrder = true
                    
                    Task {
                        do {
                            try await viewModel.placeOrder()
                            isPlacingOrder = false
                            // Success navigation happens via ViewModel resetting path to [.success]
                        } catch {
                            isPlacingOrder = false
                            showError = true
                        }
                    }
                }) {
                    HStack {
                        if isPlacingOrder {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.systemBackground)))
                            Text("Placing Order...")
                                .font(.headline)
                                .foregroundColor(Color(UIColor.systemBackground))
                                .padding(.leading, 8)
                        } else {
                            VStack(alignment: .leading) {
                                Text(String(format: "₹%.2f", totalPrice + 25.0))
                                    .font(.headline)
                                Text("TOTAL")
                                    .font(.caption)
                            }
                            Spacer()
                            Text("Place Order")
                                .font(.headline)
                            Image(systemName: "chevron.right")
                        }
                    }
                    .foregroundColor(Color(UIColor.systemBackground))
                    .padding()
                    .background(totalPrice > 0 ? Color.gatherGreen : Color.gray)
                    .cornerRadius(16)
                }
                .disabled(isPlacingOrder || totalPrice <= 0)
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
            .background(Color.appBackground)
            .shadow(color: Color.black.opacity(0.05), radius: 10, y: -5)
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .alert("Couldn't Place Order", isPresented: $showError) {
            Button("Try Again", role: .cancel) {}
        } message: {
            Text("Please try again.")
        }
    }
}
