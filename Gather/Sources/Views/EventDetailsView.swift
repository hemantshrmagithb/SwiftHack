import SwiftUI

struct EventDetailsView: View {
    @Bindable var viewModel: PlanningViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Event Details")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primaryText)
                    
                    Text("Step 2: Tell us more about the celebration.")
                        .font(.subheadline)
                        .foregroundColor(.secondaryText)
                }
                .padding(.horizontal, 24)
                
                // Date & Time
                VStack(spacing: 16) {
                    DatePicker("DATE", selection: $viewModel.eventDate, displayedComponents: .date)
                        .padding(16)
                        .background(Color.cardBackground)
                        .cornerRadius(16)
                    
                    DatePicker("TIME", selection: $viewModel.eventTime, displayedComponents: .hourAndMinute)
                        .padding(16)
                        .background(Color.cardBackground)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 24)
                
                // Guests
                VStack(alignment: .leading, spacing: 16) {
                    Text("Guests")
                        .font(.headline)
                        .foregroundColor(.primaryText)
                        .padding(.horizontal, 24)
                    
                    VStack(spacing: 0) {
                        StepperRow(title: "Adults", subtitle: "Age 13+", value: $viewModel.adultGuests)
                        Divider().padding(.vertical, 8)
                        StepperRow(title: "Kids", subtitle: "Ages 2-12", value: $viewModel.childGuests)
                    }
                    .padding(16)
                    .background(Color.cardBackground)
                    .cornerRadius(16)
                    .padding(.horizontal, 24)
                }
                
                // Venue & Budget
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Venue Preference")
                            .font(.headline)
                            .foregroundColor(.primaryText)
                        
                        HStack(spacing: 0) {
                            Button(action: { viewModel.isIndoor = true }) {
                                Text("Indoor")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(viewModel.isIndoor ? Color(UIColor.systemBackground) : .primaryText)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(viewModel.isIndoor ? Color.primaryText : Color.clear)
                                    .cornerRadius(20)
                            }
                            
                            Button(action: { viewModel.isIndoor = false }) {
                                Text("Outdoor")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(!viewModel.isIndoor ? Color(UIColor.systemBackground) : .primaryText)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(!viewModel.isIndoor ? Color.primaryText : Color.clear)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Budget Estimate")
                                .font(.headline)
                                .foregroundColor(.primaryText)
                            Spacer()
                            Text(String(format: "₹%.0f", viewModel.budgetEstimate))
                                .foregroundColor(.secondaryText)
                        }
                        
                        Slider(value: $viewModel.budgetEstimate, in: 100...5000, step: 50)
                            .accentColor(.primaryText)
                    }
                }
                .padding(16)
                .background(Color.cardBackground)
                .cornerRadius(16)
                .padding(.horizontal, 24)
                
                // Dietary
                VStack(alignment: .leading, spacing: 16) {
                    Text("Dietary")
                        .font(.headline)
                        .foregroundColor(.primaryText)
                        .padding(.horizontal, 24)
                    
                    HStack(spacing: 12) {
                        ForEach(DietaryPreference.allCases) { diet in
                            FilterChip(
                                title: diet.rawValue,
                                isSelected: viewModel.selectedDiets.contains(diet)
                            ) {
                                viewModel.toggleDietary(diet)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }
                
                // Weather Preview (Static mock for now)
                VStack(alignment: .leading, spacing: 12) {
                    Text("Weather Preview")
                        .font(.headline)
                        .foregroundColor(.primaryText)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.eventDate.formatted(date: .abbreviated, time: .omitted) + " • " + viewModel.eventTime.formatted(date: .omitted, time: .shortened))
                                .font(.caption)
                                .foregroundColor(.secondaryText)
                            
                            HStack(alignment: .firstTextBaseline) {
                                Text("28°C")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.primaryText)
                                Text("Clear")
                                    .font(.subheadline)
                                    .foregroundColor(.secondaryText)
                            }
                        }
                        Spacer()
                        Image(systemName: Calendar.current.component(.hour, from: viewModel.eventTime) >= 18 ? "moon.fill" : "sun.max.fill")
                            .font(.system(size: 32))
                            .foregroundColor(Calendar.current.component(.hour, from: viewModel.eventTime) >= 18 ? .secondaryText : .orange)
                    }
                }
                .padding(16)
                .background(Color.cardBackground)
                .cornerRadius(16)
                .padding(.horizontal, 24)
                
                Spacer().frame(height: 100)
            }
            .padding(.top, 16)
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .overlay(
            VStack {
                Spacer()
                Button(action: {
                    viewModel.generatePlan()
                }) {
                    Text("Plan Celebration")
                        .font(.headline)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.blinkZoGreen)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.appBackground.opacity(0), Color.appBackground]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 120)
                )
            }
            , alignment: .bottom
        )
    }
}
