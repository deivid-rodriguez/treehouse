import { defineConfig } from 'vite'
import UnoCSS from 'unocss/vite'
import ViteRails from 'vite-plugin-rails'

export default defineConfig({
  plugins: [
    UnoCSS(),
    ViteRails(),
  ],
})
