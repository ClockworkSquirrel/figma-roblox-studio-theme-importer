figma.showUI(__html__)

function HEXToRGB(hexCode): RGB {
  let result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hexCode)

  return result && {
    r: parseInt(result[1], 16) / 255,
    g: parseInt(result[2], 16) / 255,
    b: parseInt(result[3], 16) / 255,
  }
}

figma.ui.onmessage = message => {
  if (message.type === "import-theme") {
    const data = JSON.parse(message.payload)

    let processedStyles = 0
    for (let [styleName, styleColour] of Object.entries(data)) {
      const styleRGB: RGB = HEXToRGB(styleColour)
      const stylePaint: SolidPaint = {
        type: "SOLID",
        color: styleRGB,
        opacity: 1,
      }

      const newStyle = figma.createPaintStyle()
      newStyle.name = styleName
      newStyle.paints = [stylePaint]

      processedStyles++
    }

    return figma.closePlugin(`Successfully imported ${processedStyles} styles`)
  }

  figma.closePlugin()
}
