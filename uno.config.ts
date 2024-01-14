// uno.config.ts
import {
  defineConfig,
  presetTypography,
  presetUno
} from 'unocss'


export default defineConfig({
  // ...UnoCSS options
  presets: [
    presetUno(),
    presetTypography(),
  ]
})
