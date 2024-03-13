// TotalNutrientsDTO.swift
// Copyright © RoadMap. All rights reserved.

/// Объект передачи описания рецепта
struct TotalNutrientsDTO: Codable {
    let energyCalories: MeasuredCaloriesDTO?
    let carb: MeasuredGramsDTO?
    let fat: MeasuredGramsDTO?
    let protein: MeasuredGramsDTO?

    enum CodingKeys: String, CodingKey {
        case energyCalories = "ENERC_KCAL"
        case carbGram = "CHOCDF"
        case fatGram = "FAT"
        case protein = "PROCNT"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        energyCalories = try? container.decode(MeasuredCaloriesDTO.self, forKey: .energyCalories)
        carb = try? container.decode(MeasuredGramsDTO.self, forKey: .carbGram)
        fat = try? container.decode(MeasuredGramsDTO.self, forKey: .fatGram)
        protein = try? container.decode(MeasuredGramsDTO.self, forKey: .protein)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(energyCalories, forKey: .energyCalories)
        try container.encode(carb, forKey: .carbGram)
        try container.encode(fat, forKey: .fatGram)
        try container.encode(protein, forKey: .protein)
    }
}
