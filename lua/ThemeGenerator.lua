local HttpService = game:GetService("HttpService")
local ServerStorage = game:GetService("ServerStorage")

local Studio = settings():GetService("Studio")

local function Color3ToHex(color3, prefix)
    return string.format("%s%.2x%.2x%.2x", prefix or "", color3.R * 255, color3.G * 255, color3.B * 255)
end

local function GenerateColourTable(Theme)
    local ColourTable = {}
    
    for _, Color in next, Enum.StudioStyleGuideColor:GetEnumItems() do        
        for _, Modifier in next, Enum.StudioStyleGuideModifier:GetEnumItems() do
            --local StyleType = Color.Name:match("Text") and "color" or Color.Name:match("Border") and "border" or "background"
            local StyleName = string.format("%s / %s / %s", Theme.Name, Color.Name, Modifier.Name)
            
            local StyleColor3 = Theme:GetColor(Color, Modifier)
            local StyleColorHex = Color3ToHex(StyleColor3, "#")
            
            ColourTable[StyleName] = StyleColorHex
        end
    end
    
    return ColourTable
end

local function GenerateColoursJSONFile(ArrayOnly)
    for _, Theme in next, Studio:GetAvailableThemes() do
        local DataModule = Instance.new("ModuleScript")
        DataModule.Name = string.format("%s-colour-palette.json", string.lower(Theme.Name))
        
        local ColourData = GenerateColourTable(Theme)
        local FinalColourData = {}
        
        if ArrayOnly then
            local StoredColours = {}
            
            for StyleName, HexCode in next, ColourData do
                if not StoredColours[HexCode] then
                    FinalColourData[#FinalColourData + 1] = HexCode
                    StoredColours[HexCode] = true
                end
            end
        else
            FinalColourData = ColourData
        end
        
        local ColourDataJSON = HttpService:JSONEncode(FinalColourData)
        
        DataModule.Source = ColourDataJSON
        DataModule.Parent = ServerStorage 
    end
end

GenerateColoursJSONFile()