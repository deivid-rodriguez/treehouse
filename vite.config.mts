import { defineConfig } from 'vite'
import Inspect from 'vite-plugin-inspect'
import UnoCSS from 'unocss/vite'
import ViteRails from 'vite-plugin-rails'

export default defineConfig({
  plugins: [
    Inspect(),
    UnoCSS(),
    ViteRails(),
  ],
})
