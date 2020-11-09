# figma-roblox-studio-theme-importer
This plugin allows you to import Roblox Studio's built-in themes to Figma as styles. This plugin is available in development mode only!

## Prerequisites
* Figma Desktop
* Node+NPM
* TypeScript
* Roblox Studio

## Instructions
1. Compile the plugin
    1. Navigate to project directory
    2. Run the following command:
        ```
        $ npm i && npm run build
        ```
2. Open a project in Figma Desktop
3. Navigate to `Plugins -> Development -> New plugin...`
4. Link an existing plugin by selecting the `manifest.json` of this plugin
5. Open Roblox Studio and open a new place file
6. Go to the `Model` tab and select `Run Script`
7. Run the generator script in `/lua/ThemeGenerator.lua`
8. Open the generated theme ModuleScripts in `ServerStorage/{theme-name}-colour-palette.json` and copy its contents to your clipboard
9. Run the plugin in Figma by selecting `Plugins -> Development -> Roblox Studio Theme Importer`
10. Paste the contents of the ModuleScript you copied earlier into the textbox
11. Click **"Create Styles"** and the plugin will add each theme colour as a Local Style in your project with the `{theme-name} / {style-type} / {style-modifier}` naming convention
