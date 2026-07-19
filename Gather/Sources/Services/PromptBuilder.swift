import Foundation

struct PromptBuilder {
    static func buildPrompt(for template: OccasionTemplate) -> String {
        let dietsString = template.dietaryPreferences.map { $0.rawValue }.joined(separator: ", ")
        
        let prompt = """
        You are an expert AI Event Concierge and Shopping Planner.
        Generate a comprehensive, structured plan for a celebration with the following details:
        
        - Occasion: \(template.type.rawValue)
        - Date: \(template.date.formatted(date: .abbreviated, time: .omitted))
        - Time: \(template.time.formatted(date: .omitted, time: .shortened))
        - Adult Guests: \(template.adultGuests)
        - Child Guests: \(template.childGuests)
        - Total Budget: ₹\(template.budget)
        - Location: \(template.isIndoor ? "Indoor" : "Outdoor")
        - Dietary Preferences: \(dietsString.isEmpty ? "None" : dietsString)
        
        You must return ONLY a valid JSON object matching this exact structure:
        {
            "title": "String (e.g. 'Arpita's Birthday Bash')",
            "summary": {
                "foodStrategy": "String (explain how to feed this many people)",
                "drinkStrategy": "String",
                "dessertRecommendation": "String",
                "wasteReductionTip": "String (how to minimize leftover waste)"
            },
            "timeline": [
                {
                    "title": "String",
                    "description": "String",
                    "timeString": "String (e.g. '4:00 PM')"
                }
            ],
            "checklist": [
                {
                    "task": "String",
                    "isEssential": Bool
                }
            ],
            "shoppingCategories": [
                {
                    "name": "String",
                    "iconName": "String (SF Symbol name)",
                    "products": [
                        {
                            "name": "String",
                            "estimatedQuantity": "String (e.g. '2 kg', '4 bottles')",
                            "estimatedPrice": Double,
                            "isEssential": Bool
                        }
                    ]
                }
            ],
            "totalEstimatedBudget": Double,
            "warnings": ["String"],
            "premiumUpgrades": ["String"],
            "aiReasoning": [
                {
                    "trigger": "String (e.g. '12 Adults + 4 Kids')",
                    "result": "String (e.g. 'Recommended 4 large pizzas')"
                }
            ]
        }
        """
        
        return prompt
    }
}
