import { defineConfig } from 'vite'
import Inspect from 'vite-plugin-inspect'
import UnoCSS from 'unocss/vite'
import ViteRails from 'vite-plugin-rails'

export default defineConfig({
  plugins: [
    Inspect(),
    UnoCSS(),
    ViteRails({
      fullReload: {
        additionalPaths: [
          'app/channels/**/*_channel.rb',
          'app/controllers/**/*_controller.rb',
          'app/decorators/**/*_decorator.rb',
          'app/helpers/**/*_helper.rb',
          'lib/**/*.rb',
        ],
      },
    }),
  ],
})
